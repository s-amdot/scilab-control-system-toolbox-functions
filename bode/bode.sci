/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* bode.sci
computes bode magnitude and phase response of a continuous LTI system */
/*
Description:
      Computes the bode frequency response of a continuous LTI system.
      For each frequency point w, the transfer function is evaluated at s = jw using:
      H(jw) = C*(jwI - A)^-1*B + D
      magnitude is returned in dB: 20*log10(|H(jw)|)
      phase is returned in degrees: angle(H(jw)) * 180/pi
      if no frequency vector is provided, an automatic range is built from the system poles
      if called with no output arguments, a Bode plot is drawn.
Calling Sequence:
      bode(sys)
      bode(sys, w)
      [mag, phase, w] = bode(sys)
      [mag, phase, w] = bode(sys, w)
Parameters:
      sys- state-space system struct with fields .A .B .C .D .dt
      sys.A- n x n system matrix
      sys.B- n x m input matrix
      sys.C- p x n output matrix
      sys.D- p x m feedthrough matrix
      sys.dt- sampling time, 0 for continuous
      w- frequency vector in rad/s (optional, auto-generated if omitted)
      mag- magnitude response in dB
      phase   - phase response in degrees
      w       - frequency vector used in rad/s
Dependencies:
      No external dependencies. Uses Scilab built-ins only.
*/


function [mag_r, pha_r, w_r] = bode(varargin)

    rhs = length(varargin);
    lhs = argn(1);
    if rhs == 0 then
        error("bode: missing input arguments");
    end

    old_warn_mode = warning("query");
    warning("quiet");

    sys1 = varargin(1);
    A = sys1.A;
    B = sys1.B;
    C = sys1.C;
    D = sys1.D;

    // generate automatic frequency range from poles
    poles = spec(A);
    mag_poles = abs(poles);
    mag_poles(mag_poles < 1e-3) = 1e-3; 
    w_min = min(mag_poles) / 10;
    w_max = max(mag_poles) * 10;
    w_auto = logspace(log10(w_min), log10(w_max), 1000);

    has_w = %f;
    if rhs > 1 then
        w = varargin(2);
        has_w = %t;
    else
        w = w_auto;
    end

    n_points = length(w);
    n_auto = length(w_auto);
    mag = zeros(1, n_points);
    pha = zeros(1, n_points);
    pha_auto = zeros(1, n_auto);
    I_mat = eye(A);

    for i = 1:n_auto
        jw_a = %i * w_auto(i);
        H_auto = C * inv(jw_a * I_mat - A) * B + D;
        pha_auto(i) = atan(imag(H_auto), real(H_auto)) * 180 / %pi;
    end

    for i = 1:n_points
        jw = %i * w(i);
        H_jw = C * inv(jw * I_mat - A) * B + D;
        mag(i) = 20 * log10(abs(H_jw));
        pha(i) = atan(imag(H_jw), real(H_jw)) * 180 / %pi;
    end

    initial_phase_auto = pha_auto(1);
    initial_phase = pha(1);

    // Compute transmission zeros using a generalized eigenvalue matrix pencil
    n_states = size(A, 1);
    [n_outputs, n_inputs] = size(D);
    pencil_matrix = [A, B; C, D];
    pencil_weight = [eye(n_states, n_states), zeros(n_states, n_inputs); zeros(n_outputs, n_states), zeros(n_outputs, n_inputs)];
    
    all_zeros_raw = spec(pencil_matrix, pencil_weight);
    zeros_sys = all_zeros_raw(~isinf(all_zeros_raw) & ~isnan(all_zeros_raw));

    H_dc = C * inv((1e-10 * %i) * I_mat - A) * B + D;
    k = real(H_dc);

    pole_integrator = 0;
    if sys1.dt <> "c" & sys1.dt <> 0 then
        pole_integrator = 1;
    end
    tol = sqrt(%eps);

    // asymptotic low-frequency phase alignment
    n_poles_at_origin = sum(abs(poles - pole_integrator) < tol);
    n_zeros_at_origin = sum(abs(zeros_sys - pole_integrator) < tol);
    asymptotic_low_freq_phase = (n_zeros_at_origin - n_poles_at_origin) * 90;
    if (k < 0) then
        asymptotic_low_freq_phase = asymptotic_low_freq_phase - 180;
    end

    pha_auto = pha_auto + round((asymptotic_low_freq_phase - initial_phase_auto) / 90) * 90;
    pha = pha + round((asymptotic_low_freq_phase - initial_phase) / 90) * 90;

    // Phase history alignment for custom frequency vectors
    initial_phase = pha(1);
    if has_w then
        if (length(w) <> length(w_auto)) | or(w <> w_auto) then
            if w(1) > w_auto(1) then
                pha_idx = length(find(w_auto < w(1)));
                if pha_idx == 0 then pha_idx = 1; end
                pha_cmp = pha_auto(pha_idx);
                pha = pha + round((pha_cmp - initial_phase) / 90) * 90;
            end
        else
            pha = pha_auto;
        end
    else
        pha = pha_auto;
    end

    // Correct phase jumps near imaginary axis poles and zeros
    w0_poles = imag(poles(abs(real(poles)) < tol & imag(poles) > 0));
    w0_zeros = imag(zeros_sys(abs(real(zeros_sys)) < tol & imag(zeros_sys) > 0));

    dpha = diff(pha);
    w0_inc = find(dpha > 90);
    w0_dec = find(dpha < -90);
    max_idx = length(pha);

    if ~isempty(w0_poles) then
        for j = 1:length(w0_inc)
            if (w0_inc(j) - 2 > 0 & w0_inc(j) + 2 <= max_idx) then
                lb = w(w0_inc(j) - 2) < w0_poles;
                ub = w(w0_inc(j) + 2) > w0_poles;
                if sum(lb & ub) == 1 then
                    pha(w0_inc(j) + 1:$) = pha(w0_inc(j) + 1:$) - 360;
                end
            end
        end
    end

    if ~isempty(w0_zeros) then
        for j = 1:length(w0_dec)
            if (w0_dec(j) - 2 > 0 & w0_dec(j) + 2 <= max_idx) then
                lb = w(w0_dec(j) - 2) < w0_zeros;
                ub = w(w0_dec(j) + 2) > w0_zeros;
                if sum(lb & ub) == 1 then
                    pha(w0_dec(j) + 1:$) = pha(w0_dec(j) + 1:$) + 360;
                end
            end
        end
    end

    warning(old_warn_mode);

    if lhs == 0 then
        clf();
        subplot(2, 1, 1);
        plot2d1("oln", w, mag);
        xtitle("Bode Diagram", "", "Magnitude [dB]"); 
        xgrid();
        
        subplot(2, 1, 2);
        plot2d1("oln", w, pha);
        xtitle("", "Frequency [rad/s]", "Phase [deg]"); 
        xgrid();
    else
        mag_r = mag;
        pha_r = pha;
        w_r = w;
    end

endfunction

//----------------------------------------------------------------------------------------------------------------------------------//

// TEST CASE 1 (first-order low pass H(s)=1/(s+1))
sys1.A=[-1]; sys1.B=[1]; sys1.C=[1]; sys1.D=[0]; sys1.dt=0;
[m1,p1,w1] = bode(sys1, [0.00001]);
printf("test case 1: DC gain = %.4f dB\n", m1(1)); 
disp("----------------------------------------------------------------------------------------------------------------------------------");

sys2.A=[0 1;-4 -0.4]; sys2.B=[0;1]; sys2.C=[1 0]; sys2.D=[0]; sys2.dt=0;
[m2,p2,w2] = bode(sys2);
printf("test case 2: max magnitude = %.4f dB\n", max(m2));
disp("----------------------------------------------------------------------------------------------------------------------------------");

sys3.A=[-0.001]; sys3.B=[1]; sys3.C=[1]; sys3.D=[0]; sys3.dt=0;
w3 = logspace(-1, 2, 100);
[m3,p3,w3_ignore] = bode(sys3, w3);
slope = (m3($) - m3(1)) / (log10(w3($)) - log10(w3(1)));
printf("test case 3: slope ~ %.1f dB/dec\n", slope); 
disp("----------------------------------------------------------------------------------------------------------------------------------");

// TEST CASE 4 (check output vector length matches frequency vector)
sys4.A=[-2 1;0 -3]; sys4.B=[1;0]; sys4.C=[1 0]; sys4.D=[0]; sys4.dt=0;
w4 = logspace(-1, 3, 150);
[m4,p4,w4_out] = bode(sys4, w4);
printf("test case 4: length match: %s\n", string(length(w4_out)==150));
disp("----------------------------------------------------------------------------------------------------------------------------------");

// TEST CASE 5 (phase of 1/(s+1) at w=1)
sys5.A=[-1]; sys5.B=[1]; sys5.C=[1]; sys5.D=[0]; sys5.dt=0;
[m5,p5,w5] = bode(sys5, [1]);
printf("test case 5: phase at w=1 = %.4f deg\n", p5(1)); 
disp("----------------------------------------------------------------------------------------------------------------------------------");

 //----------------------------------------------------------------------------------------------------------------------------------//

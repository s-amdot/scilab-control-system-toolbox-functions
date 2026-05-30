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

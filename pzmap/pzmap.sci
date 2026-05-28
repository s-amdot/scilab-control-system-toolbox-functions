function [p, z] = pzmap(varargin)

  rhs = length(varargin);
  if (rhs < 1) then
    error("pzmap: wrong number of input arguments");
  end

  if (argn(1) > 0) then
    sys = varargin(1);
    try
      p = spec(sys.A);
      z = trzeros(sys);
    catch
      p = roots(sys.den(1,1));
      z = roots(sys.num(1,1));
    end
    return;
  end

  scf();
  xtitle("pole-zero map", "real axis", "imaginary axis");
  xgrid();

  idx = 1;
  while (idx <= rhs)
    sys   = varargin(idx);
    col   = 'b';
    idx   = idx + 1;
    if (idx <= rhs & typeof(varargin(idx)) == "string") then
      col = varargin(idx);
      idx = idx + 1;
    end

    try
      p_plt = spec(sys.A);
      z_plt = trzeros(sys);
    catch
      p_plt = roots(sys.den(1,1));
      z_plt = roots(sys.num(1,1));
    end

    if (length(p_plt) > 0) then
      plot(real(p_plt), imag(p_plt), col + 'x');
    end
    if (length(z_plt) > 0) then
      plot(real(z_plt), imag(z_plt), col + 'o');
    end
  end

endfunction



s = %s;

// test case 1: first order system, one pole no zeros
sys1     = syslin('c', 1 / (s + 3));
[p1, z1] = pzmap(sys1);
disp("test case 1: 1/(s+3)");
disp("poles (expect -3):");
disp(p1);
disp("zeros (expect none):");
disp(z1);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 2: second order underdamped, two complex poles
sys2     = syslin('c', 1 / (s^2 + 2*s + 5));
[p2, z2] = pzmap(sys2);
disp("test case 2: 1/(s^2+2s+5)");
disp("poles (expect -1 +/- 2i):");
disp(p2);
disp("zeros (expect none):");
disp(z2);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 3: system with both poles and zeros
sys3     = syslin('c', (s + 2) / ((s + 1) * (s + 4)));
[p3, z3] = pzmap(sys3);
disp("test case 3: (s+2)/((s+1)(s+4))");
disp("poles (expect -1, -4):");
disp(p3);
disp("zeros (expect -2):");
disp(z3);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 4: state-space form
A4       = [0, 1; -6, -5];
B4       = [0; 1];
C4       = [1, 0];
D4       = [0];
sys4     = syslin('c', A4, B4, C4, D4);
[p4, z4] = pzmap(sys4);
disp("test case 4: state-space with poles at -2, -3");
disp("poles:");
disp(p4);
disp("zeros:");
disp(z4);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 5: third order with two zeros
sys5     = syslin('c', (s^2 + 3*s + 2) / (s^3 + 6*s^2 + 11*s + 6));
[p5, z5] = pzmap(sys5);
disp("test case 5: (s^2+3s+2)/(s^3+6s^2+11s+6)");
disp("poles (expect -1, -2, -3):");
disp(p5);
disp("zeros (expect -1, -2):");
disp(z5);
disp("----------------------------------------------------------------------------------------------------------------------------------");

function sys = dss(varargin)
  rhs = length(varargin);

  if (rhs < 1 || rhs > 6) then
    error("dss: wrong number of input arguments");
  end

  if (rhs == 1) then
    sys = varargin(1);
    if (isempty(sys.E)) then
      sys.E = eye(size(sys.A, 1), size(sys.A, 1));
    end
    return;
  end

  a = varargin(1);
  b = varargin(2);
  c = varargin(3);
  d = varargin(4);
  e = varargin(5);
  tsam = 0;

  if (rhs == 6) then
    tsam = varargin(6);
  end

  sys = struct();
  sys.A = a;
  sys.B = b;
  sys.C = c;
  sys.D = d;
  sys.E = e;
  sys.dt = tsam;
endfunction


//---------------------------------------------------------------------------------------------------------------------------------------//

// test case 1: simple 2x2 continuous descriptor system with non-identity e
A1 = [1, 2; 3, 4];
B1 = [1; 0];
C1 = [1, 0];
D1 = [0];
E1 = [2, 1; 0, 3];
sys1 = dss(A1, B1, C1, D1, E1);
disp("test case 1: 2x2 continuous descriptor system");
disp("A:");
disp(sys1.A);
disp("E:");
disp(sys1.E);
disp("sampling time (0 = continuous):");
disp(sys1.dt);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 2: identity e reduces to standard state-space
A2 = [0, 1; -2, -3];
B2 = [0; 1];
C2 = [1, 0];
D2 = [0];
E2 = eye(2, 2);
sys2 = dss(A2, B2, C2, D2, E2);
disp("test case 2: identity e");
disp("E equals identity:");
disp(sys2.E);
disp("B:");
disp(sys2.B);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 3: discrete time descriptor system with tsam
A3 = [0.5, 0.1; 0, 0.9];
B3 = [1; 1];
C3 = [1, 0];
D3 = [0];
E3 = [1, 0.2; 0, 1];
tsam3 = 0.01;
sys3 = dss(A3, B3, C3, D3, E3, tsam3);
disp("test case 3: discrete time descriptor system with tsam = 0.01");
disp("sampling time:");
disp(sys3.dt);
disp("E:");
disp(sys3.E);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 4: 3rd order descriptor system
A4 = [0, 1, 0; 0, 0, 1; -6, -11, -6];
B4 = [0; 0; 1];
C4 = [1, 0, 0];
D4 = [0];
E4 = [2, 0, 0; 0, 1, 0; 0, 0, 3];
sys4 = dss(A4, B4, C4, D4, E4);
disp("test case 4: 3rd order descriptor system with diagonal e");
disp("A:");
disp(sys4.A);
disp("E:");
disp(sys4.E);
disp("C:");
disp(sys4.C);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 5: conversion form dss(sys) where e is empty, should be replaced by identity
sys_in = struct();
sys_in.A = [1, 0; 0, 2];
sys_in.B = [1; 1];
sys_in.C = [1, 1];
sys_in.D = [0];
sys_in.E = [];
sys_in.dt = 0;
sys5 = dss(sys_in);
disp("test case 5: conversion from struct with empty e");
disp("E:");
disp(sys5.E);
disp("A:");
disp(sys5.A);
disp("----------------------------------------------------------------------------------------------------------------------------------");


/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* dlqr.sci 
computes the discrete-time linear-quadratic regulator gain */
/*
Description:
      Computes the optimal state feedback gain matrix for a discrete-time linear quadratic regulator (DLQR).
      Given a discrete LTI system and cost weighting matrices, it finds the gain G that minimizes the quadratic cost:
      J = sum( x'Qx + u'Ru + 2x'Su )
      The gain is computed from the solution X to the Discrete Algebraic Riccati Equation (DARE):
      X = A'XA - (A'XB + S)(B'XB + R)^-1(B'XA + S') + Q
      G = (B'XB + R)^-1 * (B'XA + S')
Calling Sequence:
      [G, X, L] = dlqr(A, B, Q, R)
      [G, X, L] = dlqr(A, B, Q, R, S)
Dependencies:
      dare- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/dare/dare.sci
      care- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/care/care.sci
      issample- https://github.com/akash-sankar/CSToolboxFunctions/blob/main/thiran/thiran.sci
      dssdata- https://github.com/nikithad14/Scilab-control-system-toolbox-development-functions/blob/main/dssdata/dssdata.sci
*/

function [g, x, l] = dlqr (a, b, q, r, s, e)
  if (argn(2) < 3 | argn(2) > 6) then
    error("dlqr: wrong number of input arguments");
  end
  if (argn(2) < 4) then r = []; end
  if (argn(2) < 5) then s = []; end
  if (argn(2) < 6) then e = []; end

  if (typeof(a) == "rational" | typeof(a) == "state-space") then
    s = r;
    r = q;
    q = b;
    [a, b, c, d, e, tsam] = dssdata (a, []);
  elseif (argn(2) < 4) then
    error("dlqr: wrong number of input arguments");
  else
    tsam = 1;
  end

  if (issample (tsam, -1)) then
    [x, l, g] = dare (a, b, q, r, s, e);
  else
    [x, l, g] = care (a, b, q, r, s, e);
  end
endfunction


// TEST CASE 1 (standard 2D systems (identity weights))
A1 = [0, 1; -2, 3];
B1 = [0; 1];
Q1 = [1, 0; 0, 1];
R1 = [1];
[G1, X1, L1] = dlqr(A1, B1, Q1, R1);
disp("Test Case 1 - Gain G:");
disp(G1);
disp("Test Case 1 - Riccati X:");
disp(X1);

// TEST CASE 2 (double integrator (unstable/marginal open loop))
A2 = [0, 1; 0, 0];
B2 = [0; 1];
Q2 = [1, 0; 0, 1];
R2 = [0.1];
[G2, X2, L2] = dlqr(A2, B2, Q2, R2);
disp("Test Case 2 - Gain G:");
disp(G2);
disp("Test Case 2 - Riccati X:");
disp(X2);

// TEST CASE 3 (stable 2D systems)
A3 = [0, 1; -2, -3];
B3 = [1; 1];
Q3 = [2, 0; 0, 2];
R3 = [0.5];
[G3, X3, L3] = dlqr(A3, B3, Q3, R3);
disp("Test Case 3 - Gain G:");
disp(G3);
disp("Test Case 3 - Riccati X:");
disp(X3);

// TEST CASE 4 (3D system higher order)
A4 = [0, 1, 0; 0, 0, 1; -1, -5, -6];
B4 = [0; 0; 1];
Q4 = [1, 0, 0; 0, 1, 0; 0, 0, 1];
R4 = [1];
[G4, X4, L4] = dlqr(A4, B4, Q4, R4);
disp("Test Case 4 - Gain G:");
disp(G4);
disp("Test Case 4 - Riccati X:");
disp(X4);

// TEST CASE 5 (discrete-time stable system)
A5 = [0.8, 0.1; 0, 0.9];
B5 = [1; 0];
Q5 = [1, 0; 0, 1];
R5 = [1];
[G5, X5, L5] = dlqr(A5, B5, Q5, R5);
disp("Test Case 5 - Gain G:");
disp(G5);
disp("Test Case 5 - Riccati X:");
disp(X5);
disp("Test Case 5 - Closed-loop Poles:");
disp(L5);

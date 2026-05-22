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
Parameters:
      A   - n x n discrete-time state matrix
      B   - n x m input matrix
      Q   - n x n state cost weighting matrix, must be positive semi-definite
      R   - m x m control cost weighting matrix, must be positive definite
      S   - n x m cross-coupling weight matrix (optional, default is zeros)
      G   - m x n optimal state feedback gain matrix
      X   - n x n solution to the DARE
      L   - n x 1 closed-loop eigenvalues of (A - B*G)
Dependencies:
      No external dependencies. Uses Scilab built-ins only.
*/

function [g, x, l] = dlqr(varargin)

  rhs = length(varargin);
  if (rhs < 3 | rhs > 6) then
    error ("dlqr: wrong number of input arguments");
  end

  a = varargin(1); b = varargin(2); q = varargin(3);
  r = []; s = []; e = [];
  if (rhs >= 4) then r = varargin(4); end
  if (rhs >= 5) then s = varargin(5); end
  if (rhs == 6) then e = varargin(6); end

  if (typeof(a) == "st" & isfield(a, "A")) then
    s = r; r = q; q = b;
    tsam = a.dt; e = a.E; b = a.B; a = a.A;
  elseif (rhs < 4) then
    error ("dlqr: missing input arguments");
  else
    tsam = 1;
  end

  if (isempty(r)) then r = eye(size(b, 2), size(b, 2)); end
  if (isempty(s)) then s = zeros(size(a, 1), size(b, 2)); end
  if (isempty(e)) then e = eye(size(a, 1), size(a, 1)); end

  q_m = q - s * inv(r) * s';
  a_m = a - b * inv(r) * s';
  r_m = b * inv(r) * b';

  if (tsam <> "c" & tsam <> 0) then
    x = riccati(a_m, r_m, q_m, "d");
    g = inv(r + b' * x * b) * (b' * x * a + s');
  else
    x = riccati(a_m, r_m, q_m, "c");
    g = inv(r) * (b' * x * e + s');
  end
  
  l = spec(a - b * g);

endfunction


//----------------------------------------------------------------------------------------------------------------------------------//

// TEST CASE 1 (standard 2D systems (identity weights))
A1 = [0, 1; -2, 3];
B1 = [0; 1];
Q1 = [1, 0; 0, 1];
R1 = [1];
[G1, X1, L1] = dlqr(A1, B1, Q1, R1);
disp("test case 1: gain G:");
disp(G1);
disp("test case 1: riccati X:");
disp(X1);
disp("test case 1: eigenvalues L:");
disp(L1);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// TEST CASE 2 (double integrator (unstable/marginal open loop))
A2 = [0, 1; 0, 0];
B2 = [0; 1];
Q2 = [1, 0; 0, 1];
R2 = [0.1];
[G2, X2, L2] = dlqr(A2, B2, Q2, R2);
disp("test case 2: gain G:");
disp(G2);
disp("test case 2: riccati X:");
disp(X2);
disp("test case 2: eigenvalues L:");
disp(L2);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// TEST CASE 3 (stable 2D systems)
A3 = [0, 1; -2, -3];
B3 = [1; 1];
Q3 = [2, 0; 0, 2];
R3 = [0.5];
[G3, X3, L3] = dlqr(A3, B3, Q3, R3);
disp("test case 3: gain G:");
disp(G3);
disp("test case 3: riccati X:");
disp(X3);
disp("test case 3: eigenvalues L:");
disp(L3);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// TEST CASE 4 (3D system higher order)
A4 = [0, 1, 0; 0, 0, 1; -1, -5, -6];
B4 = [0; 0; 1];
Q4 = [1, 0, 0; 0, 1, 0; 0, 0, 1];
R4 = [1];
[G4, X4, L4] = dlqr(A4, B4, Q4, R4);
disp("test case 4: gain G:");
disp(G4);
disp("test case 4: riccati X:");
disp(X4);
disp("test case 4: eigenvalues L:");
disp(L4);
disp("----------------------------------------------------------------------------------------------------------------------------------");

//----------------------------------------------------------------------------------------------------------------------------------//

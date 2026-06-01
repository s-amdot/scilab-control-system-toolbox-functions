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

function [g, x, l] = dlqr(a, b, q, r, s, e)
  if argn(2) < 3 | argn(2) > 6 then
    error("dlqr: wrong number of input arguments");
  end
  if typeof(a) == "state-space" then
    s = r;
    r = q;
    q = b;
    [a, b, c, d, e, tsam] = dssdata(a, []);
  elseif argn(2) < 4 then
    error("dlqr: wrong number of input arguments");
  else
    tsam = 1;  
  end

  if tsam > 0 then
    [x, g] = riccati(a,b*inv(r)*b',q,"d");
    g = inv(r+b'*x*b)*(b'*x*a);
  else
    [x, g] = riccati(a,b*inv(r)*b',q,"c");
    g = inv(r)*b'*x;
  end
  l = spec(a-b*g);
endfunction

// TEST CASE 1 (standard 2D systems (identity weights))
A1 = [0, 1; -2, 3];
B1 = [0; 1];
Q1 = [1, 0; 0, 1];
R1 = [1];
[G1, X1, L1] = dlqr(A1, B1, Q1, R1);
disp("Test Case 1: Gain G:");
disp(G1);
disp("Test Case 1: Riccati X:");
disp(X1);
disp("Test Case 1: Closed loop L:");
disp(L1);


// TEST CASE 2 (double integrator (unstable/marginal open loop))
A2 = [0, 1; 0, 0];
B2 = [0; 1];
Q2 = [1, 0; 0, 1];
R2 = [0.1];
[G2, X2, L2] = dlqr(A2, B2, Q2, R2);
disp("Test Case 2: Gain G:");
disp(G2);
disp("Test Case 2: Riccati X:");
disp(X2);
disp("Test Case 2: Closed loop L:");
disp(L2);


// TEST CASE 3 (stable 2D systems)
A3 = [0, 1; -2, -3];
B3 = [1; 1];
Q3 = [2, 0; 0, 2];
R3 = [0.5];
[G3, X3, L3] = dlqr(A3, B3, Q3, R3);
disp("Test Case 3: Gain G:");
disp(G3);
disp("Test Case 3: Riccati X:");
disp(X3);
disp("Test Case 3: Closed loop L:");
disp(L3);


// TEST CASE 4 (3D system higher order)
A4 = [0, 1, 0; 0, 0, 1; -1, -5, -6];
B4 = [0; 0; 1];
Q4 = [1, 0, 0; 0, 1, 0; 0, 0, 1];
R4 = [1];
[G4, X4, L4] = dlqr(A4, B4, Q4, R4);
disp("Test Case 4: Gain G:");
disp(G4);
disp("Test Case 4: Riccati X:");
disp(X4);
disp("Test Case 4: Closed loop L:");
disp(L4);

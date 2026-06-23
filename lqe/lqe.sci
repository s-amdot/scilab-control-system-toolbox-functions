/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* lqe.sci
computes the steady-state Kalman estimator */
/*
Description:
      Computes the steady-state Kalman estimator gain for linear systems.
      Solves the associated estimator Riccati equation and returns the
      optimal observer gain, estimation error covariance, estimator poles,
      and Riccati eigenvalues.
      Supports continuous-time and discrete-time state-space systems.

Calling Sequence:
      [M, P, Z, E] = lqe(A, G, C, Q, R)
      [M, P, Z, E] = lqe(A, G, C, Q, R, S)
      [M, P, Z, E] = lqe(sys, Q, R)
      [M, P, Z, E] = lqe(sys, Q, R, S)

Dependencies:
      care
      dlqe
      dssdata
      issample
*/

function [l, p, e] = lqe (a, g, c, q, r, s)
  if (argn(2) < 3 | argn(2) > 6) then
    error("lqe: wrong number of input arguments");
  end
  if (argn(2) < 4) then q = []; end
  if (argn(2) < 5) then r = []; end
  if (argn(2) < 6) then s = []; end

  if (typeof(a) == "rational" | typeof(a) == "state-space") then
    [l, p, e] = lqr (a', g, c, q);
  elseif (isempty (g)) then
    [l, p, e] = lqr (a', c', q, r, s);
  elseif (size(g,2) <> size(q,1) | ~ issquare (q)) then
    error (msprintf("lqe: matrices g(%dx%d) and q(%dx%d) have incompatible dimensions", ..
            size(g,1), size(g,2), size(q,1), size(q,2)));
  elseif (isempty (s)) then
    [l, p, e] = lqr (a', c', g*q*g', r);
  elseif (size(g,2) <> size(s,1)) then
    error (msprintf("lqe: matrices g(%dx%d) and s(%dx%d) have incompatible dimensions", ..
            size(g,1), size(g,2), size(s,1), size(s,2)));
  else
    [l, p, e] = lqr (a', c', g*q*g', r, g*s);
  end

  l = l';
endfunction

// Test 1: g empty (g = I path)
a=[0.9 0.1; 0 0.8]; g=[]; c=[1 0]; q=eye(2,2); r=1;
[l1,p1,e1] = lqe(a,g,c,q,r);
disp("Test 1 l:"); disp(l1);
disp("Test 1 p:"); disp(p1);
disp("Test 1 e:"); disp(e1);

// Test 2: explicit identity g, no s
a=[-1 0.1; 0 -0.8]; g=eye(2,2); c=[1 0]; q=eye(2,2); r=1;
[l2,p2,e2] = lqe(a,g,c,q,r);
disp("Test 2 l:"); disp(l2);
disp("Test 2 p:"); disp(p2);
disp("Test 2 e:"); disp(e2);

// Test 3: non-square g, scalar process noise
a=[-1 0.1; 0 -0.7]; g=[1;1]; c=[1 0]; q=1; r=0.5;
[l3,p3,e3] = lqe(a,g,c,q,r);
disp("Test 3 l:"); disp(l3);
disp("Test 3 p:"); disp(p3);
disp("Test 3 e:"); disp(e3);

// Test 4: with cross-term s
a=[-1 0.1; 0 -0.8]; g=eye(2,2); c=[1 0]; q=eye(2,2); r=1; s=[0.1;0.05];
[l4,p4,e4] = lqe(a,g,c,q,r,s);
disp("Test 4 l:"); disp(l4);
disp("Test 4 p:"); disp(p4);
disp("Test 4 e:"); disp(e4);

// Test 5: two outputs, MIMO measurement
a=[-0.85 0.2; 0.1 -0.7]; g=eye(2,2); c=[1 0; 0 1]; q=diag([2 1]); r=eye(2,2);
[l5,p5,e5] = lqe(a,g,c,q,r);
disp("Test 5 l:"); disp(l5);
disp("Test 5 p:"); disp(p5);
disp("Test 5 e:"); disp(e5);

/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* dlqe.sci
computes the steady-state discrete-time Kalman estimator */
/*
Description:
      Computes the steady-state discrete-time Kalman estimator gain.
      Solves the discrete estimator Riccati equation and returns the
      optimal observer gain, estimation error covariance, estimator poles,
      and Riccati eigenvalues.
      Supports optional process/measurement noise cross-covariance.

Calling Sequence:
      [M, P, Z, E] = dlqe(A, G, C, Q, R)
      [M, P, Z, E] = dlqe(A, G, C, Q, R, S)

Dependencies:
    dare- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/dare/dare.sci
  */

  function [m, p, z, e] = dlqe (a, g, c, q, r, s)
  if (argn(2) < 5 | argn(2) > 6) then
    error("dlqe: wrong number of input arguments");
  end
  
  if (argn(2) < 6) then
    s = [];
  end

  if (isempty (g)) then
    [p, e] = dare (a', c', q, r, s);
    
  elseif (size(g,2) <> size(q,1) | ~ issquare (q)) then
    error (msprintf("dlqe: matrices g(%dx%d) and q(%dx%d) have incompatible dimensions", ..
            size(g,1), size(g,2), size(q,1), size(q,2)));
            
  elseif (isempty (s)) then
    [p, e] = dare (a', c', g*q*g', r);
    
  elseif (size(g,2) <> size(s,1)) then
    error (msprintf("dlqe: matrices g(%dx%d) and s(%dx%d) have incompatible dimensions", ..
            size(g,1), size(g,2), size(s,1), size(s,2)));
            
  else
    [p, e] = dare (a', c', g*q*g', r, g*s);
  end

  m = p*c' / (c*p*c' + r);
  z = p - m*c*p;
  z = (z + z') / 2;
endfunction

// Test 1
a=[0.9 0.1; 0 0.8]; g=[]; c=[1 0]; q=eye(2,2); r=1;
[m1,p1,z1,e1] = dlqe(a,g,c,q,r);
disp("test case 1:");
disp("m1:", m1);
disp("p1:", p1);
disp("z1:", z1);
disp("e1:", e1);

// Test 2
a=[0.9 0.1; 0 0.8]; g=eye(2,2); c=[1 0]; q=eye(2,2); r=1;
[m2,p2,z2,e2] = dlqe(a,g,c,q,r);
disp("test case 2:");
disp("m2:", m2);
disp("p2:", p2);
disp("z2:", z2);
disp("e2:", e2);

// Test 3
a=[0.8 0.1; 0 0.7]; g=[1;1]; c=[1 0]; q=1; r=0.5;
[m3,p3,z3,e3] = dlqe(a,g,c,q,r);
disp("test case 3:");
disp("m3:", m3);
disp("p3:", p3);
disp("z3:", z3);
disp("e3:", e3);

// Test 4
a=[0.9 0.1; 0 0.8]; g=eye(2,2); c=[1 0]; q=eye(2,2); r=1; s=[0.1;0.05];
[m4,p4,z4,e4] = dlqe(a,g,c,q,r,s);
disp("test case 4:");
disp("m4:", m4);
disp("p4:", p4);
disp("z4:", z4);
disp("e4:", e4);

// Test 5
a=[0.85 0.2; 0.1 0.7]; g=eye(2,2); c=[1 0; 0 1]; q=diag([2 1]); r=eye(2,2);
[m5,p5,z5,e5] = dlqe(a,g,c,q,r);
disp("test case 5:");
disp("m5:", m5);
disp("p5:", p5);
disp("z5:", z5);
disp("e5:", e5);

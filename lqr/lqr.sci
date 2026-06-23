/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* lqr.sci
computes the optimal linear quadratic regulator gain */
/*
Description:
      Computes the optimal state-feedback gain matrix for a linear
      quadratic regulator (LQR) problem.
      Solves the associated continuous-time or discrete-time Riccati
      equation and returns the optimal gain, Riccati solution, and
      closed-loop poles.
      Accepts either state-space systems or state-space matrices.

Calling Sequence:
      [G, X, L] = lqr(A, B, Q, R)
      [G, X, L] = lqr(A, B, Q, R, S)
      [G, X, L] = lqr(A, B, Q, R, S, E)
      [G, X, L] = lqr(sys, Q, R)
      [G, X, L] = lqr(sys, Q, R, S)

Dependencies:
      dare- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/dare/dare.sci
      care- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/care/care.sci
      issample- https://github.com/akash-sankar/CSToolboxFunctions/blob/main/thiran/thiran.sci
      dssdata- https://github.com/nikithad14/Scilab-control-system-toolbox-development-functions/blob/main/dssdata/dssdata.sci
*/

function [g, x, l] = lqr (a, b, q, r, s, e)
  if (argn(2) < 3 | argn(2) > 6) then
    error("lqr: wrong number of input arguments");
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
    error("lqr: wrong number of input arguments");
  else
    tsam = 0;
  end

  if (issample (tsam, -1)) then
    [x, l, g] = dare (a, b, q, r, s, e);
  else
    [x, l, g] = care (a, b, q, r, s, e);
  end
endfunction

// Test 1: scalar continuous baseline
a=-1; b=1; q=1; r=1;
[g1,x1,l1] = lqr(a,b,q,r);
disp("Test 1 g:"); disp(g1);
disp("Test 1 x:"); disp(x1);
disp("Test 1 l:"); disp(l1);

// Test 2: double integrator (expect x=[2 1;1 2], g=[1 2])
a=[0 1; 0 0]; b=[0;1]; q=eye(2,2); r=1;
[g2,x2,l2] = lqr(a,b,q,r);
disp("Test 2 g:"); disp(g2);
disp("Test 2 x:"); disp(x2);
disp("Test 2 l:"); disp(l2);

// Test 3: 2x2 two inputs
a=[0 1; -2 -3]; b=[1 0; 0 1]; q=eye(2,2); r=eye(2,2);
[g3,x3,l3] = lqr(a,b,q,r);
disp("Test 3 g:"); disp(g3);
disp("Test 3 x:"); disp(x3);
disp("Test 3 l:"); disp(l3);

// Test 4: cross-term s
a=[0 1; -2 -3]; b=[0;1]; q=eye(2,2); r=1; s=[0;0.1];
[g4,x4,l4] = lqr(a,b,q,r,s);
disp("Test 4 g:"); disp(g4);
disp("Test 4 x:"); disp(x4);
disp("Test 4 l:"); disp(l4);

// Test 5: descriptor with non-identity e
a=[0 1; -2 -3]; b=[0;1]; q=eye(2,2); r=1; s=[]; e=[2 0; 0 1];
[g5,x5,l5] = lqr(a,b,q,r,s,e);
disp("Test 5 g:"); disp(g5);
disp("Test 5 x:"); disp(x5);
disp("Test 5 l:"); disp(l5);

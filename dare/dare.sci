/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* dare.sci
solves the discrete-time algebraic Riccati equation */
/*
Description:
      Solves the discrete-time algebraic Riccati equation (DARE)
      associated with a discrete-time state-space system.
      Computes the stabilizing Riccati solution X, the closed-loop
      eigenvalues L, and the optimal state-feedback gain G.
      Supports optional cross-weighting matrix S and descriptor
      matrix E.
Calling Sequence:
      [X, L, G] = dare(A, B, Q, R)
      [X, L, G] = dare(A, B, Q, R, S)
      [X, L, G] = dare(A, B, Q, R, S, E)
Dependencies:
      __sl_sb02od__
      __sl_sg02ad__
*/

function [x, l, g] = dare(a, b, q, r, s, e)

    if argn(2) < 4 | argn(2) > 6 then
        error("wrong no. of arguments");
    end
    
    if argn(2) < 5 then
        s = [];
    end
    if argn(2) < 6 then
        e = [];
    end
    
    if ~issquare(a) | ~issquare(q) | ~issquare(r) then
        error("a, q, r must be square");
    end
    if ~isreal(a) | ~isreal(q) | ~isreal(r) then
        error("a, q, r must be real");
    end
    
    if ~isreal(b) | size(a,1) <> size(b,1) then
        error("a and b must have the same number of rows");
    end
    if size(r,2) <> size(b,2) then
        error("b and r must have the same number of columns");
    end
    
    if ~isempty(s) & (~isreal(s) | or(size(s) <> size(b))) then
        error("s must be real and identically dimensioned with b");
    end
    if ~isempty(e) & (~isreal(e) | or(size(e) <> size(a))) then
        error("a and e must have the same dimensions");
    end
    
    if isempty(s) then
        t = zeros(size(b,1), size(b,2));
    else
        t = s;
    end
    
    m = [q t; t' r];
    ev = spec(m);

// temporary
    if min(real(ev)) < -sqrt(%eps) then
        error("require [q, s; s'', r] >= 0");
    end

    if isempty(e) then
        if isempty(s) then
            [x,l] = __sl_sb02od__(a,b,q,r,b,1,0);
            g = inv(r + b'*x*b) * (b'*x*a);
        else
            [x,l] = __sl_sb02od__(a,b,q,r,s,1,1);
            g = inv(r + b'*x*b) * (b'*x*a + s');
        end
    else
        if isempty(s) then
            [x,l] = __sl_sg02ad__(a,e,b,q,r,b,1,0);
            g = inv(r + b'*x*b) * (b'*x*a);
        else
            [x,l] = __sl_sg02ad__(a,e,b,q,r,s,1,1);
            g = inv(r + b'*x*b) * (b'*x*a + s');
        end
    end
endfunction

// Test 1
A = 0.5; B = 1; Q = 1; R = 1;
[X, L, G] = dare(A, B, Q, R);
disp("T1 X:", X); disp("T1 L:", L); disp("T1 G:", G);

// Test 2
A = [0.9 0.1; 0 0.8]; B = [0; 1]; Q = eye(2,2); R = 1;
[X, L, G] = dare(A, B, Q, R);
disp("T2 X:", X); disp("T2 L:", L);

// Test 3
A = [1 0.1; 0 1]; B = [0; 0.1]; Q = eye(2,2); R = 1; S = [0; 0.05];
[X, L, G] = dare(A, B, Q, R, S);
disp("T3 X:", X); disp("T3 G:", G);

// descriptor Test 1: diagonal E, single input, no s
a=[0.9 0.1; 0 0.8]; b=[0;1]; q=eye(2,2); r=1; s=[]; e=[2 0; 0 1];
[xe1,le1,ge1] = dare(a,b,q,r,s,e);
disp("xe1:", xe1)
disp("lel:", le1)
disp("ge1:", ge1) 

// descriptor Test 2: full E, cross-term s, single input
a=[0.85 0.2; 0.1 0.7]; b=[1;1]; q=diag([3 1]); r=2; s=[0.1;0.2]; e=[1.5 0.2; 0 1.2];
[xe2,le2,ge2] = dare(a,b,q,r,s,e);
disp("xe2: ", xe2)
disp("le2: ", le2)
disp("ge2:", ge2)

/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* care.sci
solves the continuous-time algebraic Riccati equation */
/*
Description:
      Solves the continuous-time algebraic Riccati equation (CARE)
      associated with a continuous-time state-space system.
      Computes the stabilizing Riccati solution X, the closed-loop
      eigenvalues L, and the optimal state-feedback gain G.
      Supports optional cross-weighting matrix S and descriptor
      matrix E.
Calling Sequence:
      [X, L, G] = care(A, B, Q, R)
      [X, L, G] = care(A, B, Q, R, S)
      [X, L, G] = care(A, B, Q, R, S, E)
Dependencies:
      __sl_sb02od__
      __sl_sg02ad__
*/

function [x, l, g] = care(a, b, q, r, s, e)
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
    if min(real(ev)) < -sqrt(%eps) then
        error("require [q, s; s'', r] >= 0");
    end

    if isempty(e) then
        if isempty(s) then
            [x,l] = __sl_sb02od__(a,b,q,r,b,0,0);
            g = inv(r) * (b'*x);
        else
            [x,l] = __sl_sb02od__(a,b,q,r,s,0,1);
            g = inv(r) * (b'*x + s');
        end
    else
        if isempty(s) then
            [x,l] = __sl_sg02ad__(a,e,b,q,r,b,0,0);
            g = inv(r) * (b'*x*e);
        else
            [x,l] = __sl_sg02ad__(a,e,b,q,r,s,0,1);
            g = inv(r) * (b'*x*e + s');
        end
    end
endfunction


// test case 1:
A1 = [0 1; -2 -3];
B1 = [0; 1];
Q1 = eye(2,2);
R1 = 1;
[X1,L1,G1] = care(A1,B1,Q1,R1);
disp("test case 1:");
disp("X1:", X1);
disp("L1:", L1);
disp("G1:", G1);

// test case 2:
A2 = [1 2; 3 4];
B2 = [1; 0];
Q2 = eye(2,2);
R2 = 1;
[X2,L2,G2] = care(A2,B2,Q2,R2);
disp("test case 2:");
disp("X2:", X2);
disp("L2:", L2);
disp("G2:", G2);

// test case 3:
A3 = [0 1 0; 0 0 1; -1 -5 -6];
B3 = [0; 0; 1];
Q3 = eye(3,3);
R3 = 1;
[X3,L3,G3] = care(A3,B3,Q3,R3);
disp("test case 3:");
disp("X3:", X3);
disp("L3:", L3);
disp("G3:", G3);

// descriptor test 1: diagonal E, no cross-term S
a = [0 1; -2 -3];
b = [0; 1];
q = eye(2,2);
r = 1;
s = [];
e = [2 0; 0 1];
[xe1, le1, ge1] = care(a, b, q, r, s, e);
disp("xe1:", xe1)
disp("le1:", le1)
disp("ge1:", ge1)

// descriptor test 2: full E, cross-term S, single input
a = [0 1; -1 -2];
b = [1; 1];
q = diag([3 1]);
r = 2;
s = [0.1; 0.2];
e = [1.5 0.2; 0 1.2];
[xe2, le2, ge2] = care(a, b, q, r, s, e);
disp("xe2:", xe2)
disp("le2:", le2)
disp("ge2:", ge2)


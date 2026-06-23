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

// Test 4
A = [0.8 0 0; 0.1 0.7 0; 0 0.2 0.6]; B = [1;0;0]; Q = eye(3,3); R = 0.5;
[X, L, G] = dare(A, B, Q, R);
disp("T4 X:", X); disp("T4 L:", L);

// Test 5
A = 0.8;
B = 1;
Q = 1;
R = 1;
[X,L,G] = dare(A,B,Q,R);
disp("T5 X:", X); disp("T5 G:", G);

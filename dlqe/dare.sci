// DEPENDENCY
/* dare.sci */ 
/* 2026 Author: Samiksha
source- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/dare/dare.sci 

parameters:
A - State matrix
B - Input matrix
Q - State weighting matrix
R - Input weighting matrix
S - Cross-weighting matrix (optional)
E - Descriptor matrix (optional)
X - Stabilizing solution of the Riccati equation
L - Closed-loop eigenvalues
G - Optimal state-feedback gain matrix

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

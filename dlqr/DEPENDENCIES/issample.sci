// DEPENDENCY 
/* 2024 Author: Akash S
source: https://github.com/akash-sankar/CSToolboxFunctions/blob/main/iddata/iddata.sci */
/* issample.sci */ 

function sys = thiran (del, tsam)
    
    // check args
    if argn(2) ~= 2 then
        error("Usage: sys = thiran (tau, tsam)");
    end
    
    if (~(issample(del, 0)))
        error("thiran: the delay parameter tau must be a non-negative scalar.");
    end
    
    if (~(issample(tsam)))
        error ("thiran: the second parameter tsam is not a valid sampling time.");
    end
    
    if (del == 0)
        num = flipdim([1], 2);
        den = flipdim([1], 2);
        numPoly = poly(num, 'z', 'coeff');
        denPoly = poly(den, 'z', 'coeff');
        sys = syslin('d', numPoly, denPoly);
        return;
    end
    
   // find fractional and discrete delay
    N = floor (del/tsam + %eps);       // put eps or sometimes it misses
    d = del - N*tsam;
    
    if d/tsam < %eps then
        num = flipdim([1], 2);
        den = flipdim([1 zeros(1, N)], 2);
        numPoly = poly(num, 'z', 'coeff');
        denPoly = poly(den, 'z', 'coeff');
        sys = syslin('d', numPoly, denPoly);
    else
        N = N + 1;
        d = del/tsam;
        tmp = zeros(N+1, N);
        for i = 0:N
            for j = 1:N
                tmp(i+1, j) = (d - N + i) / (d - N + j + i);
            end
        end

        a = 1;
        for k = 1:N
            bin = factorial(N) / (factorial(k) * factorial(N - k));
            term = (-1)^k * bin * prod(tmp(:, k));
            a($+1) = term;
        end
        
        num = a';
        den = flipdim(a',2);
        numPoly2 = poly(num, 'z', 'coeff');
        denPoly2 = poly(den, 'z', 'coeff');
        sys = syslin('d', numPoly2, denPoly2);
    end

endfunction

function bool = issample(tsam, flg)
    if nargin < 2 then
        flg = 1;
    end
    
    if nargin < 1 | nargin > 2 then
        error("Usage: bool = issample(tsam [, flg])");
    end
    
    select flg
    case 1 then
        bool = isreal(tsam) & size(tsam, "*") == 1 & tsam > 0;
    case 0 then
        bool = isreal(tsam) & size(tsam, "*") == 1 & tsam >= 0;
    case -1 then
        bool = isreal(tsam) & size(tsam, "*") == 1 & (tsam > 0 | tsam == -1);
    case -10 then
        bool = isreal(tsam) & size(tsam, "*") == 1 & (tsam >= 0 | tsam == -1);
    else
        error("Usage: bool = issample(tsam [, flg])");
    end
endfunction

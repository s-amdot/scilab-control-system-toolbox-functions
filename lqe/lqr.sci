// DEPENDENCY
/* lqr.sci */ 
/* 2026 Author: Samiksha
source- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/lqr/lqr.sci 

parameters:

A-	State matrix	
B-	Input matrix	
Q-	State weighting matrix (symmetric, positive semidefinite)	
R-	Input weighting matrix (symmetric, positive definite)
S-	Cross-weighting matrix (optional)
E-	Descriptor matrix for generalized systems (optional)	
sys-	Continuous-time state-space model containing A, B, etc.	LTI object

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

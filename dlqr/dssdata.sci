// DEPENDENCY 
/* 2024 Author: Nikitha D
source- */
/* dssdata.sci */ 

function [a, b, c, d, e, stname, scaled] = __sys_data__(sys)
  a = sys.a;
  b = sys.b;
  c = sys.c;
  d = sys.d;
  e = []; 
  stname = []; 
  scaled = [];
endfunction

function [a, b, c, d, e, tsam, scaled] = dssdata(sys, flg)
  if argn(2) < 2 then
     flg = 0;
  end
  if argn(2) > 2 then
      error("Need at most two arguments");
  end
  if typeof(sys) <> "state-space" then
    sys = syslin("c", sys);
  end
  [a, b, c, d, e, tsam, scaled] = __sys_data__(sys);
  if isempty(e) & ~isempty(flg) then
    e = eye(size(a)); // Return eye for e
  end
  tsam = sys.dt;
endfunction

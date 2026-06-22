function sys = lft (sys1, sys2, nu, ny)
  if (argn(2) ~= 2 & argn(2) ~= 4) then
    error("lft: wrong number of input arguments");
  end

  [p1, m1] = size (sys1);
  [p2, m2] = size (sys2);

  nu_max = min (m1, p2);
  ny_max = min (m2, p1);

  if (argn(2) == 2) then

    if nu_max == m1 & ny_max == p1 then
        nu = max(nu_max-1,0);
        ny = max(ny_max-1,0);
    else
        nu = nu_max;
        ny = ny_max;
    end

   end
    if (~ (isreal(nu) & isscalar(nu)) | nu < 0) then
      error ("lft: argument ''nu'' must be a positive integer");
    end
    if (~ (isreal(ny) & isscalar(ny)) | ny < 0) then
      error ("lft: argument ''ny'' must be a positive integer");
    end
    if (nu > nu_max) then
      error (msprintf("lft: argument ''nu'' (%d) must be at most %d", nu, nu_max));
    end
    if (ny > ny_max) then
      error (msprintf("lft: argument ''ny'' (%d) must be at most %d", ny, ny_max));
    end

  M11 = zeros (m1, p1);
  M12 = [zeros(m1-nu, p2); eye(nu, nu), zeros(nu, p2-nu)];
  M21 = [zeros(ny, p1-ny), eye(ny, ny); zeros(m2-ny, p1)];
  M22 = zeros (m2, p2);
  M = [M11, M12; M21, M22];

  in_idx  = [1 : (m1-nu), m1 + (ny+1 : m2)];
  out_idx = [1 : (p1-ny), p1 + (nu+1 : p2)];

  sys = sys_group (sys1, sys2);
  sys = sys_connect (sys, M);
  sys = sys_prune (sys, out_idx, in_idx);

  [p, m] = size (sys);
  if (m == 0) then
    warning ("lft: resulting system has no inputs");
  end
  if (p == 0) then
    warning ("lft: resulting system has no outputs");
  end
endfunction

function sys = __sys_connect__(sys,M)
    H = sys("num") ./ sys("den");

    disp(size(H),"SIZE H");
    disp(size(M),"SIZE M");

    I = eye(size(H,1),size(H,1));
    disp(I - H*M, "I-HM");
    disp(inv(I - H*M), "INV");
    Hc = inv(I - H*M) * H;

    disp(Hc,"H AFTER");

    sys = syslin(sys("dt"),Hc);

endfunction


function sys = __sys_prune__(sys, out_idx, in_idx)
    dom = sys("dt");
    H = sys("num") ./ sys("den");
    H = H(out_idx, in_idx);
    sys = syslin(dom,H);
endfunction


function retsys = __sys_group__ (sys1, sys2)
  if (typeof(sys1) <> "rational" & typeof(sys1) <> "state-space") then
    sys1 = syslin("c", sys1);
  end
  if (typeof(sys1) == "state-space") then
    sys1 = ss2tf(sys1);
  end
  if (typeof(sys2) <> "rational" & typeof(sys2) <> "state-space") then
    sys2 = syslin("c", sys2);
  end
  if (typeof(sys2) == "state-space") then
    sys2 = ss2tf(sys2);
  end

  d1 = sys1("dt");
  d2 = sys2("dt");
  if (d1 == d2) then
    dom = d1;
  elseif (d1 == "c") then
    dom = d2;
  else
    dom = d1;
  end

  H1 = sys1("num") ./ sys1("den");
  H2 = sys2("num") ./ sys2("den");
  v  = varn(H1);

  [p1, m1] = size(H1);
  [p2, m2] = size(H2);

  num12 = poly(0, v) .*. ones(p1, m2);
  num21 = poly(0, v) .*. ones(p2, m1);
  den12 = poly(1, v, "coeff") .*. ones(p1, m2);
  den21 = poly(1, v, "coeff") .*. ones(p2, m1);

  off12 = num12 ./ den12;
  off21 = num21 ./ den21;
  Hbig = [H1,    off12 ;
          off21, H2   ];

  retsys = syslin(dom, Hbig);
endfunction


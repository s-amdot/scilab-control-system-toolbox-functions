/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* horzcat.sci
horizontal concatenation of transfer function models */
/*
Description:
      Concatenates transfer function models horizontally.
      The resulting system has the same number of outputs as the
      input systems and combines their inputs side-by-side.
      All systems must have the same number of outputs and
      compatible sampling times.

Calling Sequence:
      sys = [sys1 sys2]
      sys = horzcat(sys1, sys2, ...)
      
Dependencies:
      tf- https://github.com/FOSSEE-Internship/FOSSEE-Control-Systems-Toolbox/blob/master/tf.sci
      __lti_group__
*/

function sys = horzcat (sys, varargin)
  sys = tf (sys);
  for k = 1 : length(varargin)
    varargin(k) = tf (varargin(k));
  end
  for k = 1 : (argn(2)-1)

    sys1 = sys;
    sys2 = varargin(k);

    sys = tf ();
    sys.lti = __lti_group__ (sys1.lti, sys2.lti, "horzcat");

    [p1, m1] = size (sys1.num);
    [p2, m2] = size (sys2.num);

    if (p1 <> p2) then
      error (msprintf("tf: horzcat: number of system outputs incompatible: [(%dx%d), (%dx%d)]", ..
              p1, m1, p2, m2));
    end

    sys.num = [sys1.num, sys2.num];
    sys.den = [sys1.den, sys2.den];

    if (sys1.tfvar == sys2.tfvar) then
      sys.tfvar = sys1.tfvar;
    elseif (sys1.tfvar == "x") then
      sys.tfvar = sys2.tfvar;
    else
      sys.tfvar = sys1.tfvar;
    end
    if (sys1.inv | sys2.inv) then
      sys.inv = %t;
    end
  end
endfunction


function lti = __lti_group__ (lti1, lti2, ctype)
  lti = lti1;

  if (lti1.tsam == lti2.tsam) then
    lti.tsam = lti1.tsam;
  elseif (lti1.tsam == -1) then
    lti.tsam = lti2.tsam;
  elseif (lti2.tsam == -1) then
    lti.tsam = lti1.tsam;
  else
    error("lti: __lti_group__: systems must have identical sampling times");
  end

  if (ctype == "horzcat") then
    lti.ingroup = [];
    lti.inname = [lti1.inname; lti2.inname];
    lti.outgroup = lti1.outgroup;
    lti.outname = lti1.outname;
  elseif (ctype == "vertcat") then
    lti.outgroup = [];
    lti.outname = [lti1.outname; lti2.outname];
    lti.ingroup = lti1.ingroup;
    lti.inname = lti1.inname;
  else
    lti.ingroup = [];
    lti.outgroup = [];
    lti.inname = [lti1.inname; lti2.inname];
    lti.outname = [lti1.outname; lti2.outname];
  end
endfunction

// Test Case 1

g1 = tf([1],[1 1]);
g2 = tf([2],[1 2]);

H1 = [g1 g2];

disp("test case 1:");
disp(H1);

// Test Case 2

g1 = tf([1],[1 1]);
g2 = tf([1],[1 2]);
g3 = tf([1],[1 3]);

H2 = [g1 g2 g3];

disp("test case 2:");
disp(H2);

// Test Case 3

g1 = tf([1 1],[1 3 2]);
g2 = tf([1],[1 4]);

H3 = [g1 g2];

disp("test case 3:");
disp(H3);

// Test Case 4

g1 = tf([1],[1 1]);
g2 = tf([1 0],[1 2]);

H4 = [g1 g2];

disp("test case 4:");
disp(H4);

// Test Case 5: dimension mismatch

g1 = [tf([1],[1 1]);
      tf([2],[1 2])];

g2 = tf([1],[1 3]);

disp("test case 5: EXPECTING ERROR");
H5 = [g1 g2];

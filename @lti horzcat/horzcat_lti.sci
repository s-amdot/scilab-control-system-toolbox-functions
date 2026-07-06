/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* horzcat_lti.sci
horizontal concatenation of LTI system models */
/*
Description:
      Concatenates LTI system models horizontally.
      The resulting system has the same number of outputs as the
      input systems and combines their inputs side by side.
      All systems must have the same number of outputs and
      compatible sampling times.

Calling Sequence:
      sys = [sys1, sys2]
      sys = horzcat_lti(sys1, sys2, ...)

Dependencies:
      __sys_group__- https://github.com/pavannani99/Scilab-control-system-toolbox-development-functions/tree/main/blkdiag/DEPENDENCIES
*/

function sys = horzcat_lti (sys, varargin)
  for k = 1 : length(varargin)
    sys1 = sys;
    sys2 = varargin(k);
    [p1, m1] = size (sys1);
    [p2, m2] = size (sys2);
    if (p1 <> p2) then
      error (msprintf("lti: horzcat: number of system outputs incompatible: [(%dx%d), (%dx%d)]", ..
              p1, m1, p2, m2));
    end
    sys = __sys_group__ (sys1, sys2);
    out_scl = [eye(p1,p1), eye(p2,p2)];
    sys = out_scl * sys;
  end
endfunction

sys1 = tf([1],[1 1]);   sys2 = tf([1],[1 2]);   sys3 = tf([2],[1 3]);

// Test 1: horzcat two SISO (shared 1 output, appended inputs -> 1 out, 2 in)
h1 = horzcat_lti(sys1, sys2);
disp("H-Test 1:"); disp(size(h1));

// Test 2: horzcat_lti three SISO -> 1 out, 3 in
h2 = horzcat_lti(sys1, sys2, sys3);
disp("H-Test 2:"); disp(size(h2));

// Test 3: horzcat_lti two 2-output systems
A = [-1 0; 0 -2]; B = [1; 1]; C = [1 0; 0 1]; D = [0; 0];
m1 = syslin("c", A, B, C, D);   // 2 out, 1 in
m2 = syslin("c", A, B, C, D);   // 2 out, 1 in
h3 = horzcat_lti(m1, m2);
disp("H-Test 3:"); disp(size(h3));

// Test 4: single-arg horzcat_lti (no-op)
h4 = horzcat_lti(sys1);
disp("H-Test 4:"); disp(size(h4));

// Test 5: incompatible outputs -> error
disp("H-Test 5 (mismatched outputs -> expect error):");
ierr = execstr("h5 = horzcat_lti(sys1, m1);", "errcatch");
if ierr <> 0 then disp(lasterror()); else disp(size(h5)); end


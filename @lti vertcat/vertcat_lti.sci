/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* vertcat_lti.sci
vertical concatenation of LTI system models */
/*
Description:
      Concatenates LTI system models vertically.
      The resulting system has the same number of inputs as the
      input systems and combines their outputs one below another.
      All systems must have the same number of inputs and
      compatible sampling times.

Calling Sequence:
      sys = [sys1; sys2]
      sys = vertcat_lti(sys1, sys2, ...)

Dependencies:
      __sys_group__- https://github.com/pavannani99/Scilab-control-system-toolbox-development-functions/tree/main/blkdiag/DEPENDENCIES
*/

function sys = vertcat_lti (sys, varargin)
  for k = 1 : length(varargin)
    sys1 = sys;
    sys2 = varargin(k);
    [p1, m1] = size (sys1);
    [p2, m2] = size (sys2);
    if (m1 <> m2) then
      error (msprintf("lti: vertcat: number of system inputs incompatible: [(%dx%d); (%dx%d)]", ..
              p1, m1, p2, m2));
    end
    sys = __sys_group__ (sys1, sys2);
    in_scl = [eye(m1,m1); eye(m2,m2)];
    sys = sys * in_scl;
  end
endfunction

sys1 = tf([1],[1 1]);   sys2 = tf([1],[1 2]);   sys3 = tf([2],[1 3]);

// Test 1: vertcat two SISO (shared 1 input, stacked outputs -> 2 out, 1 in)
v1 = vertcat_lti(sys1, sys2);
disp("V-Test 1:"); disp(size(v1));

// Test 2: vertcat three SISO -> 3 out, 1 in
v2 = vertcat_lti(sys1, sys2, sys3);
disp("V-Test 2:"); disp(size(v2));

// Test 3: vertcat two 2-input systems
A = [-1 0; 0 -2]; B = [1 0; 0 1]; C = [1 1]; D = [0 0];
m1 = syslin("c", A, B, C, D);   // 1 out, 2 in
m2 = syslin("c", A, B, [1 0], [0 0]);   // 1 out, 2 in
v3 = vertcat_lti(m1, m2);
disp("V-Test 3:"); disp(size(v3));

// Test 4: single-arg vertcat (no-op, returns system unchanged)
v4 = vertcat_lti(sys1);
disp("V-Test 4:"); disp(size(v4));

// Test 5: incompatible inputs -> error
disp("V-Test 5:");
ierr = execstr("v5 = vertcat(sys1, m1);", "errcatch");
if ierr <> 0 then disp(lasterror()); else disp(size(v5)); end

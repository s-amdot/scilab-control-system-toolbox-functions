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

// Test 1: position and velocity sensors on same system (2 outputs, 1 input)
s1 = syslin('c', [-1], [1], [1], [0]);   // position sensor
s2 = syslin('c', [-2], [1], [2], [0]);   // velocity sensor (different C)
sys1 = vertcat_lti(s1, s2);
disp("T1 sys:"); disp(sys1);

// Test 2: two second-order systems same input, outputs stacked
s1 = syslin('c', [0 1; -1 -2], [0; 1], [1 0], [0]);
s2 = syslin('c', [0 1; -3 -4], [0; 1], [0 1], [0]);
sys2 = vertcat_lti(s1, s2);
disp("T2 sys:"); disp(sys2);

// Test 3: discrete observer with two measurement outputs
s1 = syslin('d', [0.95 0.1; 0 0.9], [0.1; 0.05], [1 0], [0]);
s2 = syslin('d', [0.95 0.1; 0 0.9], [0.1; 0.05], [0 1], [0]);
sys3 = vertcat_lti(s1, s2);
disp("T3 sys:"); disp(sys3);

// Test 4: three sensors on same plant
s1 = syslin('c', [-1], [1], [1], [0]);
s2 = syslin('c', [-1], [1], [2], [0]);
s3 = syslin('c', [-1], [1], [3], [0]);
sys4 = vertcat_lti(s1, s2, s3);
disp("T4 sys:"); disp(sys4);

// Test 5: incompatible inputs (2 inputs vs 1 input) should error
s1 = syslin('c', [0 1; -2 -3], [0 1; 1 0], [1 0], zeros(1,2));
s2 = syslin('c', [-1], [1], [1], [0]);
try
    sys5 = vertcat_lti(s1, s2);
    disp("T5: no error raised");
catch
    disp("T5: error caught correctly");
end

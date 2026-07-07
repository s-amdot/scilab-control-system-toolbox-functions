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


// Test 1: two SISO continuous systems [1/(s-1), 1/(s-2)]
s1 = syslin('c', [1], [1], [1], [0]);
s2 = syslin('c', [2], [1], [1], [0]);
sys1 = horzcat_lti(s1, s2);
disp("T1 sys:"); disp(sys1);

// Test 2: two SISO discrete systems [1/(z-0.9), 1/(z-0.8)]
s1 = syslin('d', [0.9], [1], [1], [0]);
s2 = syslin('d', [0.8], [1], [1], [0]);
sys2 = horzcat_lti(s1, s2);
disp("T2 sys:"); disp(sys2);

// Test 3: two MIMO continuous systems, 2 outputs each
s1 = syslin('c', [0 1; -2 -3], [0; 1], [1 0; 0 1], zeros(2,1));
s2 = syslin('c', [0 1; -1 -2], [1; 0], [1 0; 0 1], zeros(2,1));
sys3 = horzcat_lti(s1, s2);
disp("T3 sys:"); disp(sys3);

// Test 4: three SISO continuous systems [1/(s-1), 1/(s-2), 1/(s-3)]
s1 = syslin('c', [1], [1], [1], [0]);
s2 = syslin('c', [2], [1], [1], [0]);
s3 = syslin('c', [3], [1], [1], [0]);
sys4 = horzcat_lti(s1, s2, s3);
disp("T4 sys:"); disp(sys4);

// Test 5: incompatible outputs should error
s1 = syslin('c', [0 1; -2 -3], [0; 1], [1 0; 0 1], zeros(2,1));
s2 = syslin('c', [1], [1], [1], [0]);
try
    sys5 = horzcat_lti(s1, s2);
    disp("T5: no error raised");
catch
    disp("T5: error caught correctly");
end


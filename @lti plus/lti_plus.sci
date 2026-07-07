/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* plus_lti.sci
adds two LTI systems */
/*
Description:
      Adds two compatible LTI systems and returns the resulting
      system. Both systems must have identical input-output dimensions
      and compatible sampling times. The operation is implemented by
      grouping the systems and applying appropriate input/output scaling
      matrices.

Calling Sequence:
      sys = plus_lti(sys1, sys2)

Dependencies:
      __sys_group__ - https://github.com/pavannani99/Scilab-control-system-toolbox-development-functions/tree/main/blkdiag/DEPENDENCIES
*/

function sys = plus_lti(sys1, sys2)

    if argn(2) <> 2 then
        error("lti: plus: this is a binary operator");
    end

    [p1, m1] = size(sys1);
    [p2, m2] = size(sys2);

    if (p1 <> p2) | (m1 <> m2) then
        error(msprintf("lti: plus: system dimensions incompatible: (%dx%d) + (%dx%d)", ...
                       p1, m1, p2, m2));
    end

    sys = __sys_group__(sys1, sys2);

    in_scl  = [eye(m1,m1); eye(m2,m2)];
    out_scl = [eye(p1,p1), eye(p2,p2)];

    sys = out_scl * sys * in_scl;

endfunction

p1 = tf([3],[1 4]);   p2 = tf([1],[1 5]);   p3 = tf([5],[1 6]);
// plus_lti
a1 = plus_lti(p1, p2);
disp("plus_lti Test 1:"); disp(a1);

a2 = plus_lti(p1, p3);
disp("plus_lti Test 2:"); disp(a2);

A = [-3 0; 1 -5]; B = [2 0; 0 1]; C = [1 0; 0 2]; D = zeros(2,2);
N1 = syslin("c", A, B, C, D);  N2 = syslin("c", A, B, C, D);
a3 = plus_lti(N1, N2);
disp("plus_lti Test 3:"); disp(a3);

a4 = plus_lti(p1, p1);
disp("plus_lti Test 4:"); disp(a4);

a5 = plus_lti(p2, p3);
disp("plus_lti Test 5:"); disp(a5);

// State-space SISO systems
As1 = -1; Bs1 = 1; Cs1 = 1; Ds1 = 0;
ss1 = syslin("c", As1, Bs1, Cs1, Ds1);   // 1/(s+1)
As2 = -2; Bs2 = 1; Cs2 = 1; Ds2 = 0;
ss2 = syslin("c", As2, Bs2, Cs2, Ds2);   // 1/(s+2)
ass1 = plus_lti(ss1, ss2);
disp("SS plus_lti_lti (SISO):"); disp(ass1);


// State-space MIMO 2x2
A = [-1 0.5; 0 -2]; B = [1 0; 0 1]; C = [1 0; 0 1]; D = zeros(2,2);
Ms1 = syslin("c", A, B, C, D);
A2 = [-3 0; 1 -4]; B2 = [1 0; 0 1]; C2 = [1 0; 0 1]; D2 = zeros(2,2);
Ms2 = syslin("c", A2, B2, C2, D2);
ass2 = plus_lti(Ms1, Ms2);
disp("SS plus_lti (MIMO 2x2):"); disp(ass2);

/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* minus_lti.sci
subtracts one LTI system from another */
/*
Description:
      Subtracts two compatible LTI systems and returns the resulting
      system. Both systems must have identical input-output dimensions
      and compatible sampling times. The operation is implemented by
      grouping the systems and applying appropriate input/output scaling
      matrices.

Calling Sequence:
      sys = minus_lti(sys1, sys2)

Dependencies:
      __sys_group__
*/

function sys = minus_lti(sys1, sys2)

    if argn(2) <> 2 then
        error("lti: minus_lti: this is a binary operator");
    end

    [p1, m1] = size(sys1);
    [p2, m2] = size(sys2);

    if (p1 <> p2) | (m1 <> m2) then
        error(msprintf("lti: minus_lti: system dimensions incompatible: (%dx%d) - (%dx%d)", ...
                       p1, m1, p2, m2));
    end

    sys = __sys_group__(sys1, sys2);

    in_scl  = [eye(m1,m1); eye(m2,m2)];
    out_scl = [eye(p1,p1), -eye(p2,p2)];

    sys = out_scl * sys * in_scl;

endfunction

s1 = tf([1],[1 1]);   s2 = tf([1],[1 2]);   s3 = tf([2],[1 3]);

// Test 1: SISO minus_lti
d1 = minus_lti(s1, s2);
disp("minus_lti Test 1 (expect 1 out, 1 in):"); disp(size(d1)); disp(d1);

// Test 2: SISO, compare with operator (should match)
d2 = minus_lti(s1, s3);
disp("minus_lti Test 2:"); disp(size(d2)); disp(d2);

// Test 3: MIMO 2x2 state-space
A = [-1 0; 0 -2]; B = [1 0; 0 1]; C = [1 0; 0 1]; D = zeros(2,2);
M1 = syslin("c", A, B, C, D);
M2 = syslin("c", A, B, C, D);
d3 = minus_lti(M1, M2);
disp("minus_lti Test 3 (expect 2 out, 2 in):"); disp(size(d3));

// Test 4: system minus_lti itself (should be ~0 system)
d4 = minus_lti(s1, s1);
disp("minus_lti Test 4 (expect 1 out, 1 in):"); disp(size(d4)); disp(d4);

// Test 5: incompatible dimensions -> error
disp("minus_lti Test 5 (mismatch -> expect error):");
ierr = execstr("d5 = minus_lti(s1, M1);", "errcatch");
if ierr <> 0 then disp(lasterror()); else disp(size(d5)); end;

// State-space SISO systems
As1 = -1; Bs1 = 1; Cs1 = 1; Ds1 = 0;
ss1 = syslin("c", As1, Bs1, Cs1, Ds1);   // 1/(s+1)
As2 = -2; Bs2 = 1; Cs2 = 1; Ds2 = 0;
ss2 = syslin("c", As2, Bs2, Cs2, Ds2);   // 1/(s+2)
dss1 = minus_lti(ss1, ss2);
disp("SS minus_lti (SISO):"); disp(dss1);

// State-space MIMO 2x2
A = [-1 0.5; 0 -2]; B = [1 0; 0 1]; C = [1 0; 0 1]; D = zeros(2,2);
Ms1 = syslin("c", A, B, C, D);
A2 = [-3 0; 1 -4]; B2 = [1 0; 0 1]; C2 = [1 0; 0 1]; D2 = zeros(2,2);
Ms2 = syslin("c", A2, B2, C2, D2);
dss2 = minus_lti(Ms1, Ms2);
disp("SS minus_lti (MIMO 2x2):"); disp(dss2);

// discrete state-space
Ad = [0.5 0; 0 0.3]; Bd = [1; 1]; Cd = [1 0]; Dd = 0;
dss_a = syslin(0.1, Ad, Bd, Cd, Dd);
dss_b = syslin(0.1, [0.4 0; 0 0.2], [1; 1], [1 0], 0);
dss3 = minus_lti(dss_a, dss_b);
disp("SS minus_lti (discrete):"); disp(dss3);

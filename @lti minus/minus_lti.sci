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

function sys = minus(sys1, sys2)

    if argn(2) <> 2 then
        error("lti: minus: this is a binary operator");
    end

    [p1, m1] = size(sys1);
    [p2, m2] = size(sys2);

    if (p1 <> p2) | (m1 <> m2) then
        error(msprintf("lti: minus: system dimensions incompatible: (%dx%d) - (%dx%d)", ...
                       p1, m1, p2, m2));
    end

    sys = __sys_group__(sys1, sys2);

    in_scl  = [eye(m1, m1); eye(m2, m2)];
    out_scl = [eye(p1, p1), -eye(p2, p2)];

    sys = out_scl * sys * in_scl;

endfunction

// Common variable
s = poly(0, "s");

// ----------------------------------------------------
// Test Case 1: Subtract two SISO systems

sys1 = syslin("c", 1/(s+1));
sys2 = syslin("c", 2/(s+2));

sys = minus(sys1, sys2);

disp("Test Case 1:");
disp(sys);


// ----------------------------------------------------
// Test Case 2: Identical systems (should give zero system)

sys1 = syslin("c", (s+2)/(s+1));

sys = minus(sys1, sys1);

disp("Test Case 2:");
disp(sys);


// ----------------------------------------------------
// Test Case 3: Two SIMO systems (2 outputs, 1 input)

A = [-1 0;
      0 -2];
B = [1;
     1];
C = [1 0;
     0 1];
D = [0;
     0];

sys1 = syslin("c", A, B, C, D);
sys2 = syslin("c", A, B, C, D);

sys = minus(sys1, sys2);

disp("Test Case 3:");
disp(sys);


// ----------------------------------------------------
// Test Case 4: Two MIMO systems (2 outputs, 2 inputs)

A = [-1 0;
      0 -2];
B = eye(2,2);
C = eye(2,2);
D = zeros(2,2);

sys1 = syslin("c", A, B, C, D);
sys2 = syslin("c", 2*A, B, C, D);

sys = minus(sys1, sys2);

disp("Test Case 4:");
disp(sys);


// ----------------------------------------------------
// Test Case 5: Discrete-time systems

z = poly(0,"z");

sys1 = syslin(0.1, (z+1)/(z-0.2));
sys2 = syslin(0.1, 2/(z-0.5));

sys = minus(sys1, sys2);

disp("Test Case 5:");
disp(sys);


// ----------------------------------------------------
// Test Case 6: Dimension mismatch (EXPECTING ERROR)

sys1 = syslin("c", 1/(s+1));

A = [-1 0;
      0 -2];
B = [1;
     1];
C = [1 0;
     0 1];
D = [0;
     0];

sys2 = syslin("c", A, B, C, D);

disp("Test Case 6: EXPECTING ERROR");

sys = minus(sys1, sys2);
disp(sys);


// ----------------------------------------------------
// Test Case 7: Different sampling times (EXPECTING ERROR)

z = poly(0,"z");

sys1 = syslin(0.1, 1/(z-0.5));
sys2 = syslin(0.2, 1/(z-0.3));

disp("Test Case 7: EXPECTING ERROR");

sys = minus(sys1, sys2);
disp(sys);

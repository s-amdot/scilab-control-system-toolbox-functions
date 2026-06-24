/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* vertcat.sci
vertical concatenation of transfer function models */
/*
Description:
      Concatenates transfer function models vertically.
      The resulting system has the same number of inputs as the
      input systems and combines their outputs one above another.
      All systems must have the same number of inputs and
      compatible sampling times.

Calling Sequence:
      sys = [sys1; sys2]
      sys = vertcat(sys1, sys2, ...)
      
Dependencies:
      tf
      __lti_group__
*/

function sys = vertcat(sys, varargin)

    sys = tf(sys);

    for k = 1:length(varargin)
        varargin(k) = tf(varargin(k));
    end

    for k = 1:(argn(2)-1)

        sys1 = sys;
        sys2 = varargin(k);

        sys = tf();
        sys.lti = __lti_group__(sys1.lti, sys2.lti, "vertcat");

        [p1, m1] = size(sys1.num);
        [p2, m2] = size(sys2.num);

        if (m1 <> m2) then
            error(msprintf("tf: vertcat: number of system inputs incompatible: [(%dx%d), (%dx%d)]", ..
                  p1, m1, p2, m2));
        end

        sys.num = [sys1.num; sys2.num];
        sys.den = [sys1.den; sys2.den];

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

// Test Case 1: two SISO transfer functions
g1 = tf([1],[1 1]);
g2 = tf([2],[1 2]);
V1 = [g1; g2];
disp("test case 1:");
disp(V1);

// Test Case 2: three SISO transfer functions
g1 = tf([1],[1 1]);
g2 = tf([1],[1 2]);
g3 = tf([1],[1 3]);
V2 = [g1; g2; g3];
disp("test case 2:");
disp(V2);

// Test Case 3: two 1x2 transfer matrices
g1 = [tf([1],[1 1]) tf([2],[1 2])];
g2 = [tf([3],[1 3]) tf([4],[1 4])];
V3 = [g1; g2];
disp("test case 3:");
disp(V3);

// Test Case 4: mixed dynamics
g1 = [tf([1 1],[1 3 2]) tf([1],[1 5])];
g2 = [tf([2],[1 2]) tf([1 0],[1 4])];
V4 = [g1; g2];
disp("test case 4:");
disp(V4);

// Test Case 5: dimension mismatch (should error)
g1 = [tf([1],[1 1]) tf([2],[1 2])];
g2 = tf([1],[1 3]);
disp("test case 5: EXPECTING ERROR");
V5 = [g1; g2];
disp(V5);

// source- https://github.com/pavannani99/Scilab-control-system-toolbox-development-functions/tree/main/blkdiag/DEPENDENCIES

function retsys = __sys_group__(sys1, sys2)

    // If one system is just a numeric value, create a proper LTI system.
    [sys1, sys2] = __numeric_to_lti__(sys1, sys2);

    if typeof(sys1) <> "state-space" then
        sys1 = tf2ss(sys1);
    end

    if typeof(sys2) <> "state-space" then
        sys2 = tf2ss(sys2);
    end

    dt = __lti_group__(sys1, sys2);

    a1 = sys1.A;
    b1 = sys1.B;
    c1 = sys1.C;
    d1 = sys1.D;

    a2 = sys2.A;
    b2 = sys2.B;
    c2 = sys2.C;
    d2 = sys2.D;

    n1 = size(a1, 1);
    n2 = size(a2, 1);

    [p1, m1] = size(d1);
    [p2, m2] = size(d2);

    // Preserve the correct B and C dimensions for static-gain systems.
    if n1 == 0 then
        a1 = zeros(0, 0);
        b1 = zeros(0, m1);
        c1 = zeros(p1, 0);
    end

    if n2 == 0 then
        a2 = zeros(0, 0);
        b2 = zeros(0, m2);
        c2 = zeros(p2, 0);
    end

    a = [a1, zeros(n1, n2);
         zeros(n2, n1), a2];

    b = [b1, zeros(n1, m2);
         zeros(n2, m1), b2];

    c = [c1, zeros(p1, n2);
         zeros(p2, n1), c2];

    d = [d1, zeros(p1, m2);
         zeros(p2, m1), d2];

    retsys = syslin(dt, a, b, c, d);

endfunction

function dt = __lti_group__(sys1, sys2)

    dt1 = sys1.dt;
    dt2 = sys2.dt;

    if __blkdiag_same_dt__(dt1, dt2) then
        dt = dt1;
    elseif typeof(dt1) == "string" & dt1 == "d" & typeof(dt2) <> "string" then
        dt = dt2;
    elseif typeof(dt2) == "string" & dt2 == "d" & typeof(dt1) <> "string" then
        dt = dt1;
    else
        error("lti_group: systems must have identical sampling times");
    end

endfunction


function flag = __blkdiag_same_dt__(dt1, dt2)

    flag = %f;

    if typeof(dt1) <> typeof(dt2) then
        return;
    end

    if typeof(dt1) == "string" then
        flag = (dt1 == dt2);
    else
        flag = (abs(dt1 - dt2) <= %eps);
    end

endfunction

function [sys1, sys2] = __numeric_to_lti__(sys1, sys2)

    if ~__blkdiag_is_lti__(sys1) then
        if typeof(sys1) <> "constant" then
            error("lti: blkdiag: one system is neither an lti system nor a numeric value");
        else
            sys1 = __blkdiag_numeric_to_static_lti__(sys1, sys2);
        end
    end

    if ~__blkdiag_is_lti__(sys2) then
        if typeof(sys2) <> "constant" then
            error("lti: blkdiag: one system is neither an lti system nor a numeric value");
        else
            sys2 = __blkdiag_numeric_to_static_lti__(sys2, sys1);
        end
    end

    if typeof(sys1) == "rational" then
        sys1 = tf2ss(sys1);
    end

    if typeof(sys2) == "rational" then
        sys2 = tf2ss(sys2);
    end

    // If one of the systems is only a continuous static gain and the other
    // system is discrete, take the sampling domain of the other system.
    if __blkdiag_is_static_gain__(sys1) & __blkdiag_is_continuous__(sys1) & __blkdiag_is_discrete__(sys2) then
        sys1 = syslin(sys2.dt, [], [], [], sys1.D);
    elseif __blkdiag_is_static_gain__(sys2) & __blkdiag_is_continuous__(sys2) & __blkdiag_is_discrete__(sys1) then
        sys2 = syslin(sys1.dt, [], [], [], sys2.D);
    end

endfunction


function flag = __blkdiag_is_lti__(sys)

    flag = (typeof(sys) == "state-space") | (typeof(sys) == "rational");

endfunction


function sys = __blkdiag_numeric_to_static_lti__(gain_matrix, other_sys)

    dt = "c";

    if __blkdiag_is_lti__(other_sys) then
        if typeof(other_sys) == "rational" then
            other_sys = tf2ss(other_sys);
        end
        dt = other_sys.dt;
    end

    sys = syslin(dt, [], [], [], gain_matrix);

endfunction


function flag = __blkdiag_is_static_gain__(sys)

    if typeof(sys) == "rational" then
        sys = tf2ss(sys);
    end

    if typeof(sys) <> "state-space" then
        flag = %f;
        return;
    end

    flag = isempty(sys.A) | (size(sys.A, 1) == 0) | (size(sys.A, 2) == 0);

endfunction


function flag = __blkdiag_is_continuous__(sys)

    if typeof(sys) == "rational" then
        sys = tf2ss(sys);
    end

    flag = (typeof(sys.dt) == "string" & sys.dt == "c");

endfunction


function flag = __blkdiag_is_discrete__(sys)

    if typeof(sys) == "rational" then
        sys = tf2ss(sys);
    end

    if typeof(sys.dt) == "string" then
        flag = (sys.dt <> "c");
    else
        flag = %t;
    end

endfunction

function sys = minreal(sys, tol)
    if argn(2) > 2 then
        error("minreal: wrong number of input arguments");
    end
    if argn(2) < 2 then
        tol = "def";
    end
    if tol <> "def" then
        if ~(isscalar(tol) & isreal(tol)) then
            error("minreal: second argument must be a real-valued scalar");
        end
    end
    sys = __minreal__(sys, tol);
endfunction


s = poly(0, "s");
// Test 1: rational with pole-zero cancellation
sys1 = syslin("c", (s+1)/((s+1)*(s+2)));
r1 = minreal(sys1);
disp("T1:");
disp(r1);

// Test 2: rational, no cancellation
sys2 = syslin("c", (s+3)/(s^2 + 2*s + 5));
r2 = minreal(sys2);
disp("T2:");
disp(r2);

// Test 3: state-space with uncontrollable mode
A = [-1 0; 0 -2];
B = [1; 0];
C = [1 1];
D = 0;
sys3 = syslin("c", A, B, C, D);
r3 = minreal(sys3);
disp("T3 reduced order:");
disp(size(r3.A));

// Test 4: state-space with custom tolerance
A = [-1 1e-9; 0 -2];
B = [1; 1];
C = [1 0];
D = 0;
sys4 = syslin("c", A, B, C, D);
r4 = minreal(sys4, 1e-6);
disp("T4 reduced order:");
disp(size(r4.A));

// Test 5: discrete rational with cancellation
z = poly(0, "z");
sys5 = syslin("d", (z-0.5)*(z+0.2)/((z-0.5)*(z^2-0.7*z+0.1)));
r5 = minreal(sys5);
disp("T5:");
disp(r5);

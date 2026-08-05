/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
//
function [Abar, Bbar, Cbar, T, K] = obsvf(a, b, c, tol)
//
// Observable staircase form decomposition.
//
// Syntax
//   [Abar, Bbar, Cbar, T, K] = obsvf(A, B, C)
//   [Abar, Bbar, Cbar, T, K] = obsvf(A, B, C, tol)
//   [Abar, Bbar, Cbar] = obsvf(sys)
//
// Parameters
//   A: State matrix.
//   B: Input matrix.
//   C: Output matrix.
//   tol: Real scalar. Tolerance used to determine the numerical rank.
//   sys: LTI system object.
//
//   Abar: State matrix in observable staircase form.
//   Bbar: Input matrix corresponding to Abar.
//   Cbar: Output matrix corresponding to Abar.
//   T: State transformation matrix.
//   K: Number of observable states.
//
// Description
//   Computes the observable staircase decomposition of a state-space
//   system. The decomposition separates the observable and
//   unobservable state subspaces using a similarity transformation.
//   For LTI system objects, only the transformed system matrices are
//   returned.
//
// Dependencies
//   ctrbf - https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/ctrbf/ctrbf.sci
//
    if argn(2) < 1 | argn(2) > 4 then
        error("obsvf: wrong number of arguments");
    end

    if argn(2) < 2 then
        b = [];
    end

    if argn(2) < 4 then
        tol = [];
    end

    if typeof(a) == "state-space" | typeof(a) == "rational" then

        if argn(2) > 2 then
            error("too many inputs for LTI form");
        end

        [Abar, Bbar, Cbar] = ctrbf(a.', b);

        Abar = Abar.';
        T = [];
        K = [];

    else

        if argn(2) < 3 then
            error("requires A, B, C");
        end

        [Abar, tmp, Cbar, T, K] = ctrbf(a.', c.', b.', tol);

        Abar = Abar.';
        Bbar = Cbar.';
        Cbar = tmp.';

    end

endfunction


// Test Case 1
A = [0 1;
    -2 -3];
B = [0;
     1];
C = [1 0];

[Ac1,Bc1,Cc1,T1,K1] = obsvf(A,B,C);

disp("Ac1"); disp(Ac1);
disp("Bc1"); disp(Bc1);
disp("Cc1"); disp(Cc1);
disp("T1"); disp(T1);
disp("K1"); disp(K1);


// Test Case 2
tol = 1e-8;

[Ac2,Bc2,Cc2,T2,K2] = obsvf(A,B,C,tol);

disp("Ac2"); disp(Ac2);
disp("Bc2"); disp(Bc2);
disp("Cc2"); disp(Cc2);
disp("T2"); disp(T2);
disp("K2"); disp(K2);


// Test Case 3
A = [1 0;
     0 2];
B = [1;
     1];
C = [1 0];

[Ac3,Bc3,Cc3,T3,K3] = obsvf(A,B,C);

disp("Ac3"); disp(Ac3);
disp("Bc3"); disp(Bc3);
disp("Cc3"); disp(Cc3);
disp("T3"); disp(T3);
disp("K3"); disp(K3);


// Test Case 4
A = [1 2;
     3 4];
B = [1;
     0];
C = [0 0];

[Ac4,Bc4,Cc4,T4,K4] = obsvf(A,B,C);

disp("Ac4"); disp(Ac4);
disp("Bc4"); disp(Bc4);
disp("Cc4"); disp(Cc4);
disp("T4"); disp(T4);
disp("K4"); disp(K4);


// Test Case 5
A = [0 1 0;
     0 0 1;
    -1 -5 -6];
B = [0;
     0;
     1];
C = [1 0 0;
     0 1 0];

[Ac5,Bc5,Cc5,T5,K5] = obsvf(A,B,C);

disp("Ac5"); disp(Ac5);
disp("Bc5"); disp(Bc5);
disp("Cc5"); disp(Cc5);
disp("T5"); disp(T5);
disp("K5"); disp(K5);


// Test Case 6
A = [0 1 0 0;
     0 0 1 0;
     0 0 0 1;
    -4 -6 -4 -1];
B = [0;
     0;
     0;
     1];
C = [1 0 0 0;
     0 0 1 0];
tol = 1e-4;

[Ac6,Bc6,Cc6,T6,K6] = obsvf(A,B,C,tol);

disp("Ac6"); disp(Ac6);
disp("Bc6"); disp(Bc6);
disp("Cc6"); disp(Cc6);
disp("T6"); disp(T6);
disp("K6"); disp(K6);

A = [1 0;
     0 2];

B = [1;
     1];

C = [1 0];

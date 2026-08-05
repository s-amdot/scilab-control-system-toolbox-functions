/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
//
function [ac, bc, cc, z, ncont] = obsvf(a, b, c, tol)
// Observable staircase form decomposition.
//
// Syntax
//   [ac, bc, cc, z, ncont] = obsvf(A, B, C)
//   [ac, bc, cc, z, ncont] = obsvf(A, B, C, tol)
//   [ac, bc, cc] = obsvf(sys)
//
// Parameters
//   A: State matrix.
//   B: Input matrix.
//   C: Output matrix.
//   tol: Real scalar. Tolerance used to determine the numerical rank.
//   sys: LTI system object.
//
//   ac: State matrix in observable staircase form.
//   bc: Input matrix corresponding to ac.
//   cc: Output matrix corresponding to ac.
//   z: State transformation matrix.
//   ncont: Number of observable states.
//
// Description
//   Computes an observable staircase decomposition of a state-space
//   system. The decomposition separates the observable and
//   unobservable state subspaces using a similarity transformation.
//   For LTI system objects, only the transformed system matrices are
//   returned.
//
// Dependencies
//   ctrbf - https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/ctrbf/ctrbf.sci
//
// Examples
// 1) Observable decomposition of a state-space system:
//    A = [0 1; -2 -3];
//    B = [0; 1];
//    C = [1 0];
//    [ac, bc, cc, z, ncont] = obsvf(A, B, C);
//
//    Output:
//    ac =
//       0.   1.
//      -2.  -3.
//
//    z =
//       1.   0.
//       0.   1.
//
//    ncont = 2
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
            error("obsvf: too many inputs for LTI form");
        end
        [ac, bc, cc] = ctrbf(a.', b);
        ac = ac.';
        z = []; ncont = [];
    else
        if argn(2) < 3 then
            error("obsvf: requires at least 3 inputs");
        end
        [ac, tmp, cc, z, ncont] = ctrbf(a.', c.', b.', tol);
        ac = ac.';
        bc = cc.';
        cc = tmp.';
    end

endfunction


// Test Case 1
A = [0 1;
    -2 -3];
B = [0;
     1];
C = [1 0];

[Ac1,Bc1,Cc1,Z1,Ncont1] = obsvf(A,B,C);

disp("Ac1"); disp(Ac1);
disp("Bc1"); disp(Bc1);
disp("Cc1"); disp(Cc1);
disp("Z1"); disp(Z1);
disp("Ncont1"); disp(Ncont1);


// Test Case 2
tol = 1e-8;

[Ac2,Bc2,Cc2,Z2,Ncont2] = obsvf(A,B,C,tol);

disp("Ac2"); disp(Ac2);
disp("Bc2"); disp(Bc2);
disp("Cc2"); disp(Cc2);
disp("Z2"); disp(Z2);
disp("Ncont2"); disp(Ncont2);


// Test Case 3
A = [1 0;
     0 2];
B = [1;
     1];
C = [1 0];

[Ac3,Bc3,Cc3,Z3,Ncont3] = obsvf(A,B,C);

disp("Ac3"); disp(Ac3);
disp("Bc3"); disp(Bc3);
disp("Cc3"); disp(Cc3);
disp("Z3"); disp(Z3);
disp("Ncont3"); disp(Ncont3);


// Test Case 4
A = [1 2;
     3 4];
B = [1;
     0];
C = [0 0];

[Ac4,Bc4,Cc4,Z4,Ncont4] = obsvf(A,B,C);

disp("Ac4"); disp(Ac4);
disp("Bc4"); disp(Bc4);
disp("Cc4"); disp(Cc4);
disp("Z4"); disp(Z4);
disp("Ncont4"); disp(Ncont4);


// Test Case 5
A = [0 1 0;
     0 0 1;
    -1 -5 -6];
B = [0;
     0;
     1];
C = [1 0 0;
     0 1 0];

[Ac5,Bc5,Cc5,Z5,Ncont5] = obsvf(A,B,C);

disp("Ac5"); disp(Ac5);
disp("Bc5"); disp(Bc5);
disp("Cc5"); disp(Cc5);
disp("Z5"); disp(Z5);
disp("Ncont5"); disp(Ncont5);


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

[Ac6,Bc6,Cc6,Z6,Ncont6] = obsvf(A,B,C,tol);

disp("Ac6"); disp(Ac6);
disp("Bc6"); disp(Bc6);
disp("Cc6"); disp(Cc6);
disp("Z6"); disp(Z6);
disp("Ncont6"); disp(Ncont6);


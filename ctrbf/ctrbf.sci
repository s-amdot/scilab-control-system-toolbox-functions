/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* ctrbf.sci
computes the controllability staircase form of a state-space system */
/*
Description:
      Computes the controllability staircase form of a state-space system.
      Separates the controllable and uncontrollable state subspaces using
      an orthogonal similarity transformation. Can be called with either
      state-space matrices or an LTI system object.

Calling Sequence:
      [Ac, Bc, Cc, Z, ncont] = ctrbf(A, B, C)
      [Ac, Bc, Cc, Z, ncont] = ctrbf(A, B, C, tol)
      [sysc, Z, ncont] = ctrbf(sys)
      [sysc, Z, ncont] = ctrbf(sys, tol)

Dependencies:
      __sl_tb01ud__
      ssdata- https://github.com/akash-sankar/CSToolboxFunctions/blob/main/%40lti%20ssdata/ssdata.sci
*/

function [ac, bc, cc, z, ncont] = ctrbf(a, b, c, tol)

    if (argn(2)<1 | argn(2)>4) then
        error("ctrbf: wrong number of input arguments");
    end
    if (argn(2)<2) then
        b = [];
    end
    if (argn(2)<4) then
        tol = [];
    end

    if (typeof(a)=="rational"|typeof(a)=="state-space") then

        if (argn(2) > 2) then
            error("ctrbf: wrong number of input arguments");
        end
        sys = a;
        tol = b;
        [a, b, c] = ssdata (sys);
    else
        if (argn(2) < 3) then
            error("ctrbf: wrong number of input arguments");
        end
        sys = syslin("c", a, b, c);
        [a, b, c] = ssdata(sys);
    end

    if (isempty(tol)) then
        tol = 0;
    elseif ~(isreal(tol) & isscalar(tol)) then
        error("ctrbf: tol must be a real scalar");
    end

    [ac, bc, cc, z, ncont] = __sl_tb01ud__(a, b, c, tol);

    if (typeof(a)=="rational" | typeof(a)=="state-space") then
        ac = set(sys, "a", ac, "b", bc, "c", cc, "scaled", %f);
        bc = z;
        cc = ncont;
    end

endfunction

// Test Case 1: Fully controllable 2-state system

A1 = [0 1;
     -2 -3];
B1 = [0;
      1];
C1 = [1 0];
[Ac1,Bc1,Cc1,Z1,Ncont1] = ctrbf(A1,B1,C1);
disp("test case 1:");
disp("Ac1:",Ac1);
disp("Bc1:",Bc1);
disp("Cc1:",Cc1);
disp("Z1:",Z1);
disp("Ncont1:",Ncont1);

// Test Case 2: One uncontrollable state

A2 = [1 0;
      0 2];
B2 = [1;
      0];
C2 = [1 1];
[Ac2,Bc2,Cc2,Z2,Ncont2] = ctrbf(A2,B2,C2);
disp("test case 2:");
disp("Ac2:",Ac2);
disp("Bc2:",Bc2);
disp("Cc2:",Cc2);
disp("Z2:",Z2);
disp("Ncont2:",Ncont2);

// Test Case 3: Completely uncontrollable system

A3 = [1 2;
      3 4];
B3 = [0;
      0];
C3 = [1 0];
[Ac3,Bc3,Cc3,Z3,Ncont3] = ctrbf(A3,B3,C3);
disp("test case 3:");
disp("Ac3:",Ac3);
disp("Bc3:",Bc3);
disp("Cc3:",Cc3);
disp("Z3:",Z3);
disp("Ncont3:",Ncont3);

// Test Case 4: 3-state system with 2 controllable states

A4 = [0 1 0;
      0 0 0;
      0 0 2];
B4 = [0;
      1;
      0];
C4 = [1 0 1];
[Ac4,Bc4,Cc4,Z4,Ncont4] = ctrbf(A4,B4,C4);
disp("test case 4:");
disp("Ac4:",Ac4);
disp("Bc4:",Bc4);
disp("Cc4:",Cc4);
disp("Z4:",Z4);
disp("Ncont4:",Ncont4);

// Test Case 5: Multi-input system

A5 = [0 1 0;
      0 0 1;
     -1 -5 -6];
B5 = [0 1;
      0 0;
      1 1];
C5 = [1 0 0];
[Ac5,Bc5,Cc5,Z5,Ncont5] = ctrbf(A5,B5,C5);
disp("test case 5:");
disp("Ac5:",Ac5);
disp("Bc5:",Bc5);
disp("Cc5:",Cc5);
disp("Z5:",Z5);
disp("Ncont5:",Ncont5);

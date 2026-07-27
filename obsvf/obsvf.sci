/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* obsvf.sci
   observable staircase form decomposition */
/*
Description:
      Computes the observable staircase decomposition of a state-space
      system. The function separates the observable and unobservable
      subspaces by exploiting the duality between observability and
      controllability.
      The implementation is based on the controllability staircase
      decomposition obtained from ctrbf() applied to the transposed
      system matrices.
Calling Sequence:
      [Ao, Bo, Co, T, nobsv] = obsvf(A, B, C)
      [Ao, Bo, Co, T, nobsv] = obsvf(A, B, C, tol)
Dependencies:
      ctrbf- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/ctrbf/ctrbf.sci
*/

function [ac, bc, cc, z, ncont] = obsvf(a, b, c, tol)
    if argn(2)<1|argn(2)>4 then 
        error("obsvf: wrong number of arguments"); 
    end
    if argn(2)<2 then 
        b = []; 
    end
    if argn(2) < 4 then 
        tol = []; 
    end

    if typeof(a) =="state-space"|typeof(a)=="rational" then
        if argn(2)>2 then 
            error("too many inputs for LTI form"); 
        end
        [ac, bc, cc] = ctrbf(a.', b);
        ac = ac.';
        z = []; ncont = [];
    else
        if argn(2)<3 then 
            error("requires A, B, C"); 
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
[Ac1,Bc1,Cc1,Z1,ncont1] = obsvf(A,B,C);
disp("Ac1"); disp(Ac1);
disp("Bc1"); disp(Bc1);
disp("Cc1"); disp(Cc1);
disp("Z1"); disp(Z1);
disp("ncont1"); disp(ncont1);


// Test Case 2
tol = 1e-8;
[Ac2,Bc2,Cc2,Z2,ncont2] = obsvf(A,B,C,tol);
disp("Ac2"); disp(Ac2);
disp("Bc2"); disp(Bc2);
disp("Cc2"); disp(Cc2);
disp("Z2"); disp(Z2);
disp("ncont2"); disp(ncont2);


// Test Case 3
A = [1 0;
     0 2];
B = [1;
     1];
C = [1 0];
[Ac3,Bc3,Cc3,Z3,ncont3] = obsvf(A,B,C);
disp("Ac3"); disp(Ac3);
disp("Bc3"); disp(Bc3);
disp("Cc3"); disp(Cc3);
disp("Z3"); disp(Z3);
disp("ncont3"); disp(ncont3);


// Test Case 4
A = [1 2;
     3 4];
B = [1;
     0];
C = [0 0];
[Ac4,Bc4,Cc4,Z4,ncont4] = obsvf(A,B,C);
disp("Ac4"); disp(Ac4);
disp("Bc4"); disp(Bc4);
disp("Cc4"); disp(Cc4);
disp("Z4"); disp(Z4);
disp("ncont4"); disp(ncont4);


// Test Case 5
A = [0 1 0;
     0 0 1;
    -1 -5 -6];
B = [0;
     0;
     1];
C = [1 0 0;
     0 1 0];
[Ac5,Bc5,Cc5,Z5,ncont5] = obsvf(A,B,C);
disp("Ac5"); disp(Ac5);
disp("Bc5"); disp(Bc5);
disp("Cc5"); disp(Cc5);
disp("Z5"); disp(Z5);
disp("ncont5"); disp(ncont5);

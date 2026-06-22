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
      https://github.com/yeoleparesh/Control-system/blob/master/ctrbf.sci
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

// Test 1: simple 2x2 fully observable
A = [1 1; 0 2]; B = [0; 1]; C = [1 0];
[Ao, Bo, Co, T, no] = obsvf(A, B, C);
disp("T1 nobsv:", no); disp("T1 Ao:", Ao);

// Test 2: unobservable mode
A = [1 0; 0 2]; B = [1; 1]; C = [1 0];
[Ao, Bo, Co, T, no] = obsvf(A, B, C);
disp("T2 nobsv:", no); disp("T2 Co:", Co);

// Test 3: with tolerance
A = [-1 1; 0 -2]; B = [1; 0]; C = [0 1];
[Ao, Bo, Co, T, no] = obsvf(A, B, C, 1e-8);
disp("T3 nobsv:", no); disp("T3 T:", T);

// Test 4: 3x3 system
A = [0 1 0; 0 0 1; -6 -11 -6]; B = [0; 0; 1]; C = [1 0 0];
[Ao, Bo, Co, T, no] = obsvf(A, B, C);
disp("T4 nobsv:", no); disp("T4 Ao:", Ao);

// Test 5: repeated eigenvalue, partially observable system
A = [2 1 0;0 2 1;0 0 2];
B = [1; 0; 1];
C = [1 0 0];
[Ao, Bo, Co, T, no] = obsvf(A, B, C);
disp("T5 nobsv:", no);
disp("T5 Ao:", Ao);
disp("T5 T:", T);

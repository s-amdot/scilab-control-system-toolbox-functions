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
disp(no, "T1 nobsv:"); disp(Ao, "T1 Ao:");

// Test 2: unobservable mode
A = [1 0; 0 2]; B = [1; 1]; C = [1 0];
[Ao, Bo, Co, T, no] = obsvf(A, B, C);
disp(no, "T2 nobsv:"); disp(Co, "T2 Co:");

// Test 3: with tolerance
A = [-1 1; 0 -2]; B = [1; 0]; C = [0 1];
[Ao, Bo, Co, T, no] = obsvf(A, B, C, 1e-8);
disp(no, "T3 nobsv:"); disp(T, "T3 T:");

// Test 4: 3x3 system
A = [0 1 0; 0 0 1; -6 -11 -6]; B = [0; 0; 1]; C = [1 0 0];
[Ao, Bo, Co, T, no] = obsvf(A, B, C);
disp(no, "T4 nobsv:"); disp(Ao, "T4 Ao:");

// Test 5: completely unobservable system
A = [1 0; 0 2]; B = [1;1];C = [0 0];
[Ao, Bo, Co, T, no] = obsvf(A, B, C);
disp(no, "T5 nobsv:");disp(Ao, "T5 Ao:");disp(Co, "T5 Co:");

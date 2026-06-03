function dat = horzcat(varargin)

    dat = cat(2, varargin(:));

endfunction

// Test 1: two column vectors
a = [1; 2; 3]; b = [4; 5; 6];
r = horzcat(a, b);
disp(r, "T1:");

// Test 2: three column vectors
r = horzcat([1; 2], [3; 4], [5; 6]);
disp(r, "T2:");

// Test 3: matrices with same #rows
A = [1 2; 3 4]; B = [5 6; 7 8];
r = horzcat(A, B);
disp(r, "T3:");

// Test 4: scalars side-by-side
r = horzcat(1, 2, 3, 4);
disp(r, "T4:");

// Test 5: single input passthrough
r = horzcat([9; 9; 9]);
disp(r, "T5:");

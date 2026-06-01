/* 2026 Author: Samiksha <samikshaa18@gmail.com>
vertcat.sci
concatenates input arguments vertically.
*/

/*
Description:
      Performs vertical concatenation of input arguments.
      This function is a simple wrapper around Scilab's built-in cat()
      function with dimension set to 1, allowing multiple inputs to be
      stacked row-wise in a consistent manner.

      It accepts a variable number of input arguments and concatenates
      them along the first dimension (rows).

Calling Sequence:
      dat = vertcat(A, B, C, ...)
      dat = vertcat(varargin)

Parameters:
      varargin - variable number of input matrices/vectors to be concatenated
      dat      - resulting vertically concatenated matrix

Dependencies:
      Uses Scilab built-in function cat().
*/

function dat = vertcat(varargin)

    dat = cat(1, varargin(:));

endfunction

// Test 1: two row vectors
a = [1 2 3]; b = [4 5 6];
v = vertcat(a, b);
disp("T1:", v);

// Test 2: three row vectors
v = vertcat([1 2], [3 4], [5 6]);
disp("T2:", v);

// Test 3: matrices with same #columns
A = [1 2; 3 4]; B = [5 6; 7 8];
v = vertcat(A, B);
disp("T3:", v);

// Test 4: column vectors (scalars stack)
v = vertcat(1, 2, 3, 4);
disp("T4:", v);

// Test 5: single input passthrough
v = vertcat([9, 9, 9]);
disp("T5:", v);

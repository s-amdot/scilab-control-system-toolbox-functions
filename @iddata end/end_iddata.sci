/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* end_iddata.sci
overloaded end indexing support for iddata objects */
/*
Description:
      Returns the size corresponding to the requested dimension
      when the keyword "end" is used while indexing iddata objects.
      For multi-experiment data with equal sample lengths,
      dimension 1 returns the common number of samples.
Calling Sequence:
      r = end_iddata(dat, k, n)
Parameters:
      dat  - iddata object
      k    - dimension being queried by "end"
      n    - total number of indexing dimensions
Dependencies:
      iddata- https://github.com/akash-sankar/CSToolboxFunctions/blob/main/iddata/iddata.sci
*/

function ret = end_iddata (dat, k, n)
  if (n > 4) then
    error("iddata: end: require at most 4 indices in the expression");
  end
  select k
  case 1 then
    ret = size_iddata (dat, 1);
    if (length(ret) <> 1 & ~ and(ret == ret(1))) then
      error("iddata: end: for multi-experiment datasets, require equal number of samples when selecting samples with ''end''");
    end
    ret = ret(1);
  case 2 then
    ret = size_iddata (dat, k);
  case 3 then
    ret = size_iddata (dat, k);
  case 4 then
    ret = size_iddata (dat, k);
  else
    error(msprintf("iddata: end: invalid expression index k = %d", k));
  end
endfunction

y1 = rand(100, 2); u1 = rand(100, 1);
dat1 = iddata(y1, u1, 0.1);

ye = list(rand(50, 2), rand(50, 2));
ue = list(rand(50, 1), rand(50, 1));
dat_eq = iddata(ye, ue, 0.1);

yu = list(rand(50, 2), rand(60, 2));
uu = list(rand(50, 1), rand(60, 1));
dat_uneq = iddata(yu, uu, 0.1);

// Test case 1
r1 = end_iddata(dat1, 1, 2);
disp("Test 1 (samples, single exp):"); 
disp(r1);

// Test case 2
r2 = end_iddata(dat1, 2, 2);
disp("Test 2 (outputs):"); 
disp(r2);

// Test case 3
r3 = end_iddata(dat1, 3, 3);
disp("Test 3 (inputs):"); 
disp(r3);

// Test case 4
r4 = end_iddata(dat1, 4, 4);
disp("Test 4 (experiments):"); 
disp(r4);

// Test case 5
r5 = end_iddata(dat_eq, 1, 2);
disp("Test 5 (samples, multi-exp equal):"); 
disp(r5);

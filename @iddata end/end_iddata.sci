/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* end_iddata.sci
returns the last valid index of an iddata object for indexing expressions */
/*
Description:
      Returns the last valid index along a specified dimension of an
      iddata object. Supports sample, output, input, and experiment
      dimensions for both single- and multi-experiment datasets.
      Used internally to resolve the 'end' keyword in indexing
      expressions involving iddata objects.

Calling Sequence:
      r = end_iddata(dat, k, n)

Dependencies:
      iddata
      size_iddata
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

// Single experiment: 100 samples, 2 outputs, 1 input
y1 = rand(100, 2); u1 = rand(100, 1);
dat1 = iddata(y1, u1, 0.1);

// Multi-experiment, EQUAL sample counts: two exps of 50 samples each
ye = list(rand(50, 2), rand(50, 2));
ue = list(rand(50, 1), rand(50, 1));
dat_eq = iddata(ye, ue, 0.1);

// Multi-experiment, UNEQUAL sample counts: 50 and 60
yu = list(rand(50, 2), rand(60, 2));
uu = list(rand(50, 1), rand(60, 1));
dat_uneq = iddata(yu, uu, 0.1);

// Test 1: k=1, single experiment - sample count (expect 100)
r1 = end_iddata(dat1, 1, 2);
disp("Test 1 (samples, single exp):"); 
disp(r1);

// Test 2: k=2, output count (expect 2)
r2 = end_iddata(dat1, 2, 2);
disp("Test 2 (outputs):"); 
disp(r2);

// Test 3: k=3, input count (expect 1)
r3 = end_iddata(dat1, 3, 3);
disp("Test 3 (inputs):"); 
disp(r3);

// Test 4: k=4, experiment count (expect 1)
r4 = end_iddata(dat1, 4, 4);
disp("Test 4 (experiments):"); 
disp(r4);

// Test 5: k=1, multi-exp EQUAL samples (expect 50)
r5 = end_iddata(dat_eq, 1, 2);
disp("Test 5 (samples, multi-exp equal):"); 
disp(r5);


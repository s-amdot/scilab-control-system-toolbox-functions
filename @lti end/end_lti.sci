/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* end_lti.sci
implements end indexing support for LTI system objects */
/*
Description:
      Implements the overloaded end operator for LTI system objects.
      Returns the appropriate dimension when an LTI object is indexed
      using the end keyword during subscripted reference.

Calling Sequence:
      ret = end_lti(sys, k, n)

Dependencies:
      None
*/

function ret = end_lti (sys, k, n)
  if (n <> 2) then
    error("lti: end: require 2 indices in the expression");
  end
  [p, m] = size(sys);
  select k
  case 1 then
    ret = p;
  case 2 then
    ret = m;
  else
    error(msprintf("lti: end: invalid expression index k = %d", k));
  end
endfunction

// Test 1: SISO system, k=1 (outputs, expect 1)
s = poly(0, "s");
sys1 = syslin("c", s+2, s+3);
r1 = end_lti(sys1, 1, 2);
disp("Test 1 (outputs):"); disp(r1);

// Test 2: same SISO, k=2 (inputs, expect 1)
r2 = end_lti(sys1, 2, 2);
disp("Test 2 (inputs):"); disp(r2);

// Test 3: MIMO 2-output 3-input, both indices
A = [-1 0; 0 -2]; B = [1 0 1; 0 1 1]; C = [1 0; 0 1]; D = zeros(2,3);
sys3 = syslin("c", A, B, C, D);
r3a = end_lti(sys3, 1, 2);
r3b = end_lti(sys3, 2, 2);
disp("Test 3 (outputs):"); disp(r3a);
disp("Test 3 (inputs):"); disp(r3b);

// Test 4: single-input two-output system
A = [-1 0; 0 -3]; B = [1; 2]; C = [1 0; 0 1]; D = zeros(2,1);
sys4 = syslin("c", A, B, C, D);
r4a = end_lti(sys4, 1, 2);
r4b = end_lti(sys4, 2, 2);
disp("Test 4 (outputs):"); disp(r4a);
disp("Test 4 (inputs):"); disp(r4b);

// Test 5: discrete SISO system
z = poly(0, "z");
sys5 = syslin(0.1, z-0.5, z-0.9);
r5a = end_lti(sys5, 1, 2);
r5b = end_lti(sys5, 2, 2);
disp("Test 5 (outputs):"); disp(r5a);
disp("Test 5 (inputs):"); disp(r5b);

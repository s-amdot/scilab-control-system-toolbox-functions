# end_lti

## Description

* Returns the last valid index along a specified dimension of an LTI system object.
* Supports indexing over the output and input dimensions of state-space and transfer function models.
* Used internally to resolve the `end` keyword in indexing expressions such as `sys(:, end)` or `sys(end, :)`.

## Calling Sequence

* `r = end_lti(sys, k, n)`

## Parameters

* `sys` - Input LTI system object
* `k` - Dimension to query: 1=outputs, 2=inputs
* `n` - Total number of indices in the indexing expression
* `r` - Last valid index along dimension `k`

## Dependencies

None

## Examples

## 1

```scilab
s = poly(0, "s");
sys1 = syslin("c", s+2, s+3);
r1 = end_lti(sys1, 1, 2);
disp("Test 1 (outputs):");
disp(r1);
```

```
Test 1 (outputs):
   1.
```

## 2

```scilab
r2 = end_lti(sys1, 2, 2);
disp("Test 2 (inputs):");
disp(r2);
```

```
Test 2 (inputs):
   1.
```

## 3

```scilab
A = [-1 0; 0 -2];
B = [1 0 1; 0 1 1];
C = [1 0; 0 1];
D = zeros(2,3);

sys3 = syslin("c", A, B, C, D);

r3a = end_lti(sys3, 1, 2);
r3b = end_lti(sys3, 2, 2);

disp("Test 3 (outputs):");
disp(r3a);
disp("Test 3 (inputs):");
disp(r3b);
```

```
Test 3 (outputs):
   2.

Test 3 (inputs):
   3.
```

## 4

```scilab
A = [-1 0; 0 -3];
B = [1; 2];
C = [1 0; 0 1];
D = zeros(2,1);

sys4 = syslin("c", A, B, C, D);

r4a = end_lti(sys4, 1, 2);
r4b = end_lti(sys4, 2, 2);

disp("Test 4 (outputs):");
disp(r4a);
disp("Test 4 (inputs):");
disp(r4b);
```

```
Test 4 (outputs):
   2.

Test 4 (inputs):
   1.
```

## 5

```scilab
z = poly(0, "z");
sys5 = syslin(0.1, z-0.5, z-0.9);

r5a = end_lti(sys5, 1, 2);
r5b = end_lti(sys5, 2, 2);

disp("Test 5 (outputs):");
disp(r5a);
disp("Test 5 (inputs):");
disp(r5b);
```

```
Test 5 (outputs):
   1.

Test 5 (inputs):
   1.
```

# obsvf

## Description

- Computes the observability staircase form of a state-space system.
- Transforms the system matrices `(A, B, C)` into a block upper triangular form separating observable and unobservable subspaces.
- Returns the transformed matrices, the orthogonal transformation matrix, and the number of observable states.
- Accepts either raw matrices or a `state-space` system object.

## Calling Sequence

- `[Ao, Bo, Co, Z, Nobs] = obsvf(A, B, C)`
- `[Ao, Bo, Co, Z, Nobs] = obsvf(A, B, C, tol)`
- `[Ao, Bo, Co, Z, Nobs] = obsvf(sys)`
- `[Ao, Bo, Co, Z, Nobs] = obsvf(sys, tol)`

## Parameters

- `A` - State matrix.
- `B` - Input matrix.
- `C` - Output matrix.
- `tol` - Optional tolerance for rank determination. Defaults to `0`.
- `sys` - State-space system object (`state-space`).
- `Ao` - Transformed state matrix in observability staircase form.
- `Bo` - Transformed input matrix.
- `Co` - Transformed output matrix.
- `Z` - Orthogonal transformation matrix such that `Ao = Z'*A*Z`, `Bo = Z'*B`, `Co = C*Z`.
- `Nobs` - Number of observable states.

## Dependencies
- [ctrbf](https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/ctrbf/ctrbf.sci)

  
## Examples

## 1

```scilab
A1 = [0 1;
     -2 -3];
B1 = [0;
      1];
C1 = [1 0];
[Ao1,Bo1,Co1,Z1,Nobs1] = obsvf(A1,B1,C1);
disp("Test 1:");
disp("Nobs1:", Nobs1);
disp("Ao1:", Ao1);
```

```text
  "Test 1:"
  "Nobs1:"
   2.
  "Ao1:"
   0.   1.
  -2.  -3.
```

## 2

```scilab
A2 = [1 0;
      0 2];
B2 = [1;
      0];
C2 = [1 0];
[Ao2,Bo2,Co2,Z2,Nobs2] = obsvf(A2,B2,C2);
disp("Test 2:");
disp("Nobs2:", Nobs2);
disp("Ao2:", Ao2);
```

```text
  "Test 2:"
  "Nobs2:"
   1.
  "Ao2:"
   1.   0.
   0.   2.
```

## 3

```scilab
A3 = [1 2;
      3 4];
B3 = [1;
      0];
C3 = [0 0];
[Ao3,Bo3,Co3,Z3,Nobs3] = obsvf(A3,B3,C3);
disp("Test 3:");
disp("Nobs3:", Nobs3);
disp("Ao3:", Ao3);
```

```text
  "Test 3:"
  "Nobs3:"
   0.
  "Ao3:"
   1.   2.
   3.   4.
```

## 4

```scilab
A4 = [0 1 0;
      0 0 0;
      0 0 2];
B4 = [0;
      1;
      0];
C4 = [1 0 0];
[Ao4,Bo4,Co4,Z4,Nobs4] = obsvf(A4,B4,C4);
disp("Test 4:");
disp("Nobs4:", Nobs4);
disp("Ao4:", Ao4);
```

```text
  "Test 4:"
  "Nobs4:"
   2.
  "Ao4:"
   0.   1.   0.
   0.   0.   0.
   0.   0.   2.
```

## 5

```scilab
A5 = [0 1 0;
      0 0 1;
     -1 -5 -6];
B5 = [0;
      0;
      1];
C5 = [1 0 0;
      0 1 0];
[Ao5,Bo5,Co5,Z5,Nobs5] = obsvf(A5,B5,C5);
disp("Test 5:");
disp("Nobs5:", Nobs5);
disp("Ao5:", Ao5);
```

```text
  "Test 5:"
  "Nobs5:"
   3.
  "Ao5:"
   0.   1.   0.
   0.   0.   1.
  -1.  -5.  -6.
```

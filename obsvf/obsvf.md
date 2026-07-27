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
```

```text
  "Ac1"
   0.   1.
  -2.  -3.
  "Bc1"
   0.
   1.
  "Cc1"
   1.   0.
  "Z1"
   1.   0.
   0.   1.
  "ncont1"
   2.
```

## 2

```scilab
A = [0 1;
    -2 -3];
B = [0;
     1];
C = [1 0];
tol = 1e-8;

[Ac2,Bc2,Cc2,Z2,ncont2] = obsvf(A,B,C,tol);

disp("Ac2"); disp(Ac2);
disp("Bc2"); disp(Bc2);
disp("Cc2"); disp(Cc2);
disp("Z2"); disp(Z2);
disp("ncont2"); disp(ncont2);
```

```text
  "Ac2"
   0.   1.
  -2.  -3.
  "Bc2"
   0.
   1.
  "Cc2"
   1.   0.
  "Z2"
   1.   0.
   0.   1.
  "ncont2"
   2.
```

## 3

```scilab
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
```

```text
  "Ac3"
   1.   0.
   0.   2.
  "Bc3"
   1.
   1.
  "Cc3"
   1.   0.
  "Z3"
   1.   0.
   0.   1.
  "ncont3"
   1.
```

## 4

```scilab
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
```

```text
  "Ac4"
   1.   2.
   3.   4.
  "Bc4"
   1.
   0.
  "Cc4"
   0.   0.
  "Z4"
   1.   0.
   0.   1.
  "ncont4"
   0.
```

## 5

```scilab
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
```

```text
  "Ac5"
   0.   1.   0.
   0.   0.   1.
  -1.  -5.  -6.
  "Bc5"
   0.
   0.
   1.
  "Cc5"
   1.   0.   0.
   0.   1.   0.
  "Z5"
   1.   0.   0.
   0.   1.   0.
   0.   0.   1.
  "ncont5"
   3.
```

## 6

```scilab
A = [0 1 0 0;
     0 0 1 0;
     0 0 0 1;
    -4 -6 -4 -1];
B = [0;
     0;
     0;
     1];
C = [1 0 0 0;
     0 0 1 0];
tol = 1e-4;

[Ac6,Bc6,Cc6,Z6,ncont6] = obsvf(A,B,C,tol);

disp("Ac6"); disp(Ac6);
disp("Bc6"); disp(Bc6);
disp("Cc6"); disp(Cc6);
disp("Z6"); disp(Z6);
disp("ncont6"); disp(ncont6);
```

```text
  "Ac6"
   0.   0.  -1.   0.
   0.   0.   0.  -1.
   0.   1.   0.   0.
  -4.   4.   6.  -1.
  "Bc6"
   0.
   0.
   0.
   1.
  "Cc6"
   1.   0.   0.   0.
   0.  -1.   0.   0.
  "Z6"
   1.   0.   0.   0.
   0.   0.  -1.   0.
   0.  -1.   0.   0.
   0.   0.   0.   1.
  "ncont6"
   4.
```

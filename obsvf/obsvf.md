# obsvf

## Description

- Computes the observability staircase form of a state-space system.
- Transforms the system matrices `(A, B, C)` into a block upper triangular form separating observable and unobservable subspaces.
- Returns the transformed matrices, the orthogonal transformation matrix, and the number of observable states.
- Accepts either raw matrices or a `state-space` system object.

## Calling Sequence

- `[Ao, Bo, Co, T, K] = obsvf(A, B, C)`
- `[Ao, Bo, Co, T, K] = obsvf(A, B, C, tol)`
- `[Ao, Bo, Co, T, K] = obsvf(sys)`
- `[Ao, Bo, Co, T, K] = obsvf(sys, tol)`

## Parameters

- `A` - State matrix.
- `B` - Input matrix.
- `C` - Output matrix.
- `tol` - Optional tolerance for rank determination. Defaults to `0`.
- `sys` - State-space system object (`state-space`).
- `Ao` - Transformed state matrix in observability staircase form.
- `Bo` - Transformed input matrix.
- `Co` - Transformed output matrix.
- `T` - Orthogonal transformation matrix such that `Ao = T'*A*T`, `Bo = T'*B`, `Co = C*T`.
- `K` - Number of observable states.

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

[Ac1,Bc1,Cc1,T1,K1] = obsvf(A,B,C);

disp("Ac1"); disp(Ac1);
disp("Bc1"); disp(Bc1);
disp("Cc1"); disp(Cc1);
disp("T1"); disp(T1);
disp("K1"); disp(K1);
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
  "T1"
   1.   0.
   0.   1.
  "K1"
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

[Ac2,Bc2,Cc2,T2,K2] = obsvf(A,B,C,tol);

disp("Ac2"); disp(Ac2);
disp("Bc2"); disp(Bc2);
disp("Cc2"); disp(Cc2);
disp("T2"); disp(T2);
disp("K2"); disp(K2);
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
  "T2"
   1.   0.
   0.   1.
  "K2"
   2.
```

## 3

```scilab
A = [1 0;
     0 2];
B = [1;
     1];
C = [1 0];

[Ac3,Bc3,Cc3,T3,K3] = obsvf(A,B,C);

disp("Ac3"); disp(Ac3);
disp("Bc3"); disp(Bc3);
disp("Cc3"); disp(Cc3);
disp("T3"); disp(T3);
disp("K3"); disp(K3);
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
  "T3"
   1.   0.
   0.   1.
  "K3"
   1.
```

## 4

```scilab
A = [1 2;
     3 4];
B = [1;
     0];
C = [0 0];

[Ac4,Bc4,Cc4,T4,K4] = obsvf(A,B,C);

disp("Ac4"); disp(Ac4);
disp("Bc4"); disp(Bc4);
disp("Cc4"); disp(Cc4);
disp("T4"); disp(T4);
disp("K4"); disp(K4);
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
  "T4"
   1.   0.
   0.   1.
  "K4"
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

[Ac5,Bc5,Cc5,T5,K5] = obsvf(A,B,C);

disp("Ac5"); disp(Ac5);
disp("Bc5"); disp(Bc5);
disp("Cc5"); disp(Cc5);
disp("T5"); disp(T5);
disp("K5"); disp(K5);
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
  "T5"
   1.   0.   0.
   0.   1.   0.
   0.   0.   1.
  "K5"
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

[Ac6,Bc6,Cc6,T6,K6] = obsvf(A,B,C,tol);

disp("Ac6"); disp(Ac6);
disp("Bc6"); disp(Bc6);
disp("Cc6"); disp(Cc6);
disp("T6"); disp(T6);
disp("K6"); disp(K6);
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
  "T6"
   1.   0.   0.   0.
   0.   0.  -1.   0.
   0.  -1.   0.   0.
   0.   0.   0.   1.
  "K6"
   4.
```

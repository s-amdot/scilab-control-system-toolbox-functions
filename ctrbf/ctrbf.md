# ctrbf

## Description

- Computes the controllability staircase form of a state-space system.
- Transforms the system matrices `(A, B, C)` into a block upper triangular form separating controllable and uncontrollable subspaces.
- Returns the transformed matrices, the orthogonal transformation matrix, and the number of controllable states.
- Accepts either raw matrices or a `state-space` system object.

## Calling Sequence

- `[Ac, Bc, Cc, Z, Ncont] = ctrbf(A, B, C)`
- `[Ac, Bc, Cc, Z, Ncont] = ctrbf(A, B, C, tol)`
- `[Ac, Bc, Cc, Z, Ncont] = ctrbf(sys)`
- `[Ac, Bc, Cc, Z, Ncont] = ctrbf(sys, tol)`

## Parameters

- `A` - State matrix.
- `B` - Input matrix.
- `C` - Output matrix.
- `tol` - Optional tolerance for rank determination. Defaults to `0`.
- `sys` - State-space system object (`state-space`).
- `Ac` - Transformed state matrix in controllability staircase form.
- `Bc` - Transformed input matrix.
- `Cc` - Transformed output matrix.
- `Z` - Orthogonal transformation matrix such that `Ac = Z'*A*Z`, `Bc = Z'*B`, `Cc = C*Z`.
- `Ncont` - Number of controllable states.

## Dependencies
- [@lti/ssdata](https://github.com/akash-sankar/CSToolboxFunctions/tree/main/%40lti%20ssdata)

-  __sl_tb01ud__

## Examples

## 1

```scilab
A1 = [0 1;
     -2 -3];
B1 = [0;
      1];
C1 = [1 0];
[Ac1,Bc1,Cc1,Z1,Ncont1] = ctrbf(A1,B1,C1);
disp("test case 1:");
disp("Ac1:",Ac1);
disp("Bc1:",Bc1);
disp("Cc1:",Cc1);
disp("Z1:",Z1);
disp("Ncont1:",Ncont1);
```

```text
  "test case 1:"
  "Ac1:"
  -3.  -2.
   1.   0.
  "Bc1:"
  -1.
   0.
  "Cc1:"
   0.  -1.
  "Z1:"
   0.  -1.
  -1.   0.
  "Ncont1:"
   2.
```

## 2

```scilab
A2 = [1 0;
      0 2];
B2 = [1;
      0];
C2 = [1 1];
[Ac2,Bc2,Cc2,Z2,Ncont2] = ctrbf(A2,B2,C2);
disp("test case 2:");
disp("Ac2:",Ac2);
disp("Bc2:",Bc2);
disp("Cc2:",Cc2);
disp("Z2:",Z2);
disp("Ncont2:",Ncont2);
```

```text
  "test case 2:"
  "Ac2:"
   1.   0.
   0.   2.
  "Bc2:"
   1.
   0.
  "Cc2:"
   1.   1.
  "Z2:"
   1.   0.
   0.   1.
  "Ncont2:"
   1.
```

## 3

```scilab
A3 = [1 2;
      3 4];
B3 = [0;
      0];
C3 = [1 0];
[Ac3,Bc3,Cc3,Z3,Ncont3] = ctrbf(A3,B3,C3);
disp("test case 3:");
disp("Ac3:",Ac3);
disp("Bc3:",Bc3);
disp("Cc3:",Cc3);
disp("Z3:",Z3);
disp("Ncont3:",Ncont3);
```

```text
  "test case 3:"
  "Ac3:"
   1.   2.
   3.   4.
  "Bc3:"
   0.
   0.
  "Cc3:"
   1.   0.
  "Z3:"
   1.   0.
   0.   1.
  "Ncont3:"
   0.
```

## 4

```scilab
A4 = [0 1 0;
      0 0 0;
      0 0 2];
B4 = [0;
      1;
      0];
C4 = [1 0 1];
[Ac4,Bc4,Cc4,Z4,Ncont4] = ctrbf(A4,B4,C4);
disp("test case 4:");
disp("Ac4:",Ac4);
disp("Bc4:",Bc4);
disp("Cc4:",Cc4);
disp("Z4:",Z4);
disp("Ncont4:",Ncont4);
```

```text
  "test case 4:"
  "Ac4:"
   0.   0.   0.
   1.   0.   0.
   0.   0.   2.
  "Bc4:"
  -1.
   0.
   0.
  "Cc4:"
   0.  -1.   1.
  "Z4:"
   0.  -1.   0.
  -1.   0.   0.
   0.   0.   1.
  "Ncont4:"
   2.
```

## 5

```scilab
A5 = [0 1 0;
      0 0 1;
     -1 -5 -6];
B5 = [0 1;
      0 0;
      1 1];
C5 = [1 0 0];
[Ac5,Bc5,Cc5,Z5,Ncont5] = ctrbf(A5,B5,C5);
disp("test case 5:");
disp("Ac5:",Ac5);
disp("Bc5:",Bc5);
disp("Cc5:",Cc5);
disp("Z5:",Z5);
disp("Ncont5:",Ncont5);
```

```text
  "test case 5:"
  "Ac5:"
  -3.5        -2.5        -2.8284271
  -3.5        -2.5        -4.2426407
   0.7071068   0.7071068   0.       
  "Bc5:"
  -0.7071068  -1.4142136
  -0.7071068  -1.110D-16
   0.          0.       
  "Cc5:"
  -0.7071068   0.7071068   0.
  "Z5:"
  -0.7071068   0.7071068   0.
   0.          0.         -1.
  -0.7071068  -0.7071068   0.
  "Ncont5:"
   3.
```

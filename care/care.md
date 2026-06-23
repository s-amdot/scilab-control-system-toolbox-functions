# care

## Description

* Solves the continuous-time Algebraic Riccati Equation (CARE).
* Computes the stabilizing Riccati solution matrix `X`, the closed-loop eigenvalues `L`, and the optimal state-feedback gain matrix `G`.
* Supports generalized descriptor systems through the descriptor matrix `E`.
* Supports an optional cross-weighting matrix `S`.

## Calling Sequence

* `[X, L, G] = care(A, B, Q, R)`
* `[X, L, G] = care(A, B, Q, R, S)`
* `[X, L, G] = care(A, B, Q, R, S, E)`

## Parameters

* `A` - State matrix
* `B` - Input matrix
* `Q` - State weighting matrix
* `R` - Input weighting matrix
* `S` - Cross-weighting matrix (optional)
* `E` - Descriptor matrix (optional)
* `X` - Stabilizing solution of the Riccati equation
* `L` - Closed-loop eigenvalues
* `G` - Optimal state-feedback gain matrix

## Dependencies

**sl_sb02od**

**sl_sg02ad**

## Examples

## 1

```scilab
A1 = [0 1; -2 -3];
B1 = [0; 1];
Q1 = eye(2,2);
R1 = 1;
[X1,L1,G1] = care(A1,B1,Q1,R1);
disp("test case 1:");
disp("X1:", X1);
disp("L1:", L1);
disp("G1:", G1);
```
```text
"test case 1:"
  "X1:"
   1.236068   0.236068
   0.236068   0.236068
  "L1:"
  -1.       + 0.i
  -2.236068 + 0.i
  "G1:"
   0.236068   0.236068
```

## 2

```scilab
A2 = [1 2; 3 4];
B2 = [1; 0];
Q2 = eye(2,2);
R2 = 1;
[X2,L2,G2] = care(A2,B2,Q2,R2);
disp("test case 2:");
disp("X2:", X2);
disp("L2:", L2);
disp("G2:", G2);
```
```text
"test case 2:"
  "X2:"
   11.385165   17.641941
   17.641941   29.958791
  "L2:"
  -5.3851648 + 0.i
  -1.        + 0.i
  "G2:"
   11.385165   17.641941
```

## 3

```scilab
A3 = [0 1 0; 0 0 1; -1 -5 -6];
B3 = [0; 0; 1];
Q3 = eye(3,3);
R3 = 1;
[X3,L3,G3] = care(A3,B3,Q3,R3);
disp("test case 3:");
disp("X3:", X3);
disp("L3:", L3);
disp("G3:", G3);
```
```text
"test case 3:"
  "X3:"
   2.9355636   2.7432925   0.4142136
   2.7432925   4.2772633   0.6112908
   0.4142136   0.6112908   0.1824414
  "L3:"
  -5.1452924 + 0.i       
  -0.5185745 + 0.0770473i
  -0.5185745 - 0.0770473i
  "G3:"
   0.4142136   0.6112908   0.1824414
```

## 4

```scilab
a = [0 1; -2 -3];
b = [0; 1];
q = eye(2,2);
r = 1;
s = [];
e = [2 0; 0 1];
[xe1, le1, ge1] = care(a, b, q, r, s, e);
disp("test case 4: ");
disp("xe1:", xe1)
disp("le1:", le1)
disp("ge1:", ge1)
```
```text

  "xe1:"
   0.5770218   0.118034 
   0.118034    0.1993856
  "le1:"
  -0.3992833 + 0.i
  -2.8001023 + 0.i
  "ge1:"
   0.236068   0.1993856
```

## 5

```scilab
a = [0 1; -1 -2];
b = [1; 1];
q = diag([3 1]);
r = 2;
s = [0.1; 0.2];
e = [1.5 0.2; 0 1.2];
[xe2, le2, ge2] = care(a, b, q, r, s, e);
disp("test case 5: ");
disp("xe2:", xe2)
disp("le2:", le2)
disp("ge2:", ge2)
```
```text
  "xe2:"
   1.2820963   0.1535951
   0.1535951   0.2645127
  "le2:"
  -1.2967831 + 0.6907758i
  -1.2967831 - 0.6907758i
  "ge2:"
   1.1267686   0.4944338
```

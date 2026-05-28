# dlqr

## Description
Computes the discrete-time Linear Quadratic Regulator (LQR) optimal state-feedback gain matrix `G`, the solution `X` to the associated discrete-time algebraic Riccati equation (DARE), and the closed-loop eigenvalues `L`. 
For a discrete-time system described by $x_{k+1} = A x_k + B u_k$, this function calculates the control law $u_k = -G x_k$ that minimizes the quadratic cost function:
$J = \sum_{k=0}^{\infty} (x_k^T Q x_k + u_k^T R u_k)$

## Calling Sequence
```text
[G, X, L] = dlqr(A, B, Q, R)
```

## Parameters
* **A** - $n \times n$ system state matrix.
* **B** - $n \times m$ system input matrix.
* **Q** - $n \times n$ symmetric positive semi-definite state weighting matrix.
* **R** - $m \times m$ symmetric positive definite input weighting matrix.
* **G** - $m \times n$ optimal state-feedback gain matrix.
* **X** - $n \times n$ symmetric positive definite stabilizing solution of the discrete Riccati equation.
* **L** - $n \times 1$ vector of closed-loop system eigenvalues (i.e., eigenvalues of $A - BG$).

## Dependencies
`dare` or equivalent algebraic Riccati equation solver.

---

## Examples

## 1

```
A1 = [0, 1; -2, 3];
B1 = [0; 1];
Q1 = [1, 0; 0, 1];
R1 = [1];
[G1, X1, L1] = dlqr(A1, B1, Q1, R1);
disp("test case 1: gain G:");
disp(G1);
disp("test case 1: riccati X:");
disp(X1);
disp("test case 1: eigenvalues L:");
disp(L1);
```
```
test case 1: gain G:
  -1.7991   2.2473
test case 1: riccati X:
   4.5983  -4.4946
  -4.4946   8.9572
test case 1: eigenvalues L:
   0.3763 + 0.2434i
   0.3763 - 0.2434i
```

## 2

```
A2 = [0, 1; 0, 0];
B2 = [0; 1];
Q2 = [1, 0; 0, 1];
R2 = [0.1];
[G2, X2, L2] = dlqr(A2, B2, Q2, R2);
disp("test case 2: gain G:");
disp(G2);
disp("test case 2: riccati X:");
disp(X2);
disp("test case 2: eigenvalues L:");
disp(L2);
```
```
test case 2: gain G:
   0   0
test case 2: riccati X:
   1   0
   0   2
test case 2: eigenvalues L:
   0
   0
```

## 3

```
A3 = [0, 1; -2, -3];
B3 = [1; 1];
Q3 = [2, 0; 0, 2];
R3 = [0.5];
[G3, X3, L3] = dlqr(A3, B3, Q3, R3);
disp("test case 3: gain G:");
disp(G3);
disp("test case 3: riccati X:");
disp(X3);
disp("test case 3: eigenvalues L:");
disp(L3);
```
```
test case 3: gain G:
  -1.2740  -1.5580
test case 3: riccati X:
   7.3785  10.1200
  10.1200  21.4611
test case 3: eigenvalues L:
  -0.0840 + 0.1145i
  -0.0840 - 0.1145i
```

## 4

```
A4 = [0, 1, 0; 0, 0, 1; -1, -5, -6];
B4 = [0; 0; 1];
Q4 = [1, 0, 0; 0, 1, 0; 0, 0, 1];
R4 = [1];
[G4, X4, L4] = dlqr(A4, B4, Q4, R4);
disp("test case 4: gain G:");
disp(G4);
disp("test case 4: riccati X:");
disp(X4);
disp("test case 4: eigenvalues L:");
disp(L4);
```
```
test case 4: gain G:
  -0.9706  -4.7034  -5.0760
test case 4: riccati X:
   1.9706   4.7034   5.0760
   4.7034  24.9823  25.3931
   5.0760  25.3931  32.9746
test case 4: eigenvalues L:
  -0.1826 + 0.0000i
  -0.3707 + 0.1542i
  -0.3707 - 0.1542i
```

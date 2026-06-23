# lqr

## Description

- Computes the optimal state-feedback gain matrix for a linear quadratic regulator (LQR) problem.
- Solves the associated continuous-time or discrete-time Riccati equation.
- Returns the optimal gain matrix, Riccati solution, and closed-loop poles.
- Supports descriptor systems and optional state-input cross-weighting matrices.

## Calling Sequence

- `[G, X, L] = lqr(A, B, Q, R)`
- `[G, X, L] = lqr(A, B, Q, R, S)`
- `[G, X, L] = lqr(A, B, Q, R, S, E)`
- `[G, X, L] = lqr(sys, Q, R)`
- `[G, X, L] = lqr(sys, Q, R, S)`

## Parameters

- `A` - State matrix.
- `B` - Input matrix.
- `Q` - State weighting matrix.
- `R` - Input weighting matrix.
- `S` - Optional state-input cross-weighting matrix.
- `E` - Optional descriptor matrix.
- `sys` - State-space system.
- `G` - Optimal state-feedback gain matrix.
- `X` - Riccati equation solution.
- `L` - Closed-loop poles.

## Dependencies

- `dare`- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/dare/dare.sci
- `care`- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/care/care.sci
- `issample`- https://github.com/akash-sankar/CSToolboxFunctions/blob/main/thiran/thiran.sci
- `dssdata`- https://github.com/nikithad14/Scilab-control-system-toolbox-development-functions/blob/main/dssdata/dssdata.sci

## Examples

## 1

```scilab
a=-1; b=1; q=1; r=1;
[g1,x1,l1] = lqr(a,b,q,r);
disp("test case 1:");
disp("g1:", g1);
disp("x1:", x1);
disp("l1:", l1);
```
```text
"test case 1:"
  "g1:"
   0.4142136
  "x1:"
   0.4142136
  "l1:"
  -1.4142136
```

## 2

```scilab
a=[0 1; 0 0]; b=[0;1]; q=eye(2,2); r=1;
[g2,x2,l2] = lqr(a,b,q,r);
disp("test case 2:");
disp("g2:", g2);
disp("x2:", x2);
disp("l2:", l2);
```
```text
"test case 2:"
  "g2:"
   1.   1.7320508
  "x2:"
   1.7320508   1.       
   1.          1.7320508
  "l2:"
  -0.8660254 + 0.5i
  -0.8660254 - 0.5i
```

## 3

```scilab
a=[0 1; -2 -3]; b=[1 0; 0 1]; q=eye(2,2); r=eye(2,2);
[g3,x3,l3] = lqr(a,b,q,r);
disp("test case 3:");
disp("g3:", g3);
disp("x3:", x3);
disp("l3:", l3);
```
```text
"test case 3:"
"g3:"
   0.772884    0.0982494
   0.0982494   0.1916838
"x3:"
   0.772884    0.0982494
   0.0982494   0.1916838
"l3:"
  -1.9822839 + 0.6553239i
  -1.9822839 - 0.6553239i
```

## 4

```scilab
a=[0 1; -2 -3]; b=[0;1]; q=eye(2,2); r=1; s=[0;0.1];
[g4,x4,l4] = lqr(a,b,q,r,s);
disp("test case 4:");
disp("g4:", g4);
disp("x4:", x4);
disp("l4:", l4);
```
```text
"test case 4:"
"g4:"
   0.236068   0.3274819
"x4:"
   1.2404758   0.236068 
   0.236068    0.2274819
"l4:"
  -0.934381 + 0.i
  -2.393101 + 0.i
```

## 5

```scilab
a=[0 1; -2 -3]; b=[0;1]; q=eye(2,2); r=1; s=[]; e=[2 0; 0 1];
[g5,x5,l5] = lqr(a,b,q,r,s,e);

disp("test case 5:");
disp("g5:", g5);
disp("x5:", x5);
disp("l5:", l5);
```
```text
"test case 5:"
"g5:"
   0.236068   0.1993856
"x5:"
   0.5770218   0.118034 
   0.118034    0.1993856
"l5:"
  -0.3992833 + 0.i
  -2.8001023 + 0.i
```

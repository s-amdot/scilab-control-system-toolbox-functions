# lqe

## Description

- Computes the steady-state Kalman estimator gain for linear systems.
- Solves the associated estimator Riccati equation and returns the optimal observer gain.
- Supports optional process/measurement noise cross-covariance matrix `S`.
- Returns the estimator gain, estimation error covariance, and estimator poles.

## Calling Sequence

- `[L, P, E] = lqe(A, G, C, Q, R)`
- `[L, P, E] = lqe(A, G, C, Q, R, S)`
- `[L, P, E] = lqe(sys, Q, R)`
- `[L, P, E] = lqe(sys, Q, R, S)`

## Parameters

- `A` - State matrix.
- `G` - Process noise input matrix. If empty, an identity matrix is used.
- `C` - Measurement matrix.
- `Q` - Process noise covariance matrix.
- `R` - Measurement noise covariance matrix.
- `S` - Optional process/measurement noise cross-covariance matrix.
- `sys` - State-space system.
- `L` - Steady-state Kalman gain matrix.
- `P` - Estimation error covariance matrix.
- `E` - Estimator poles.

## Dependencies

`lqr`- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/lqr/lqr.sci

## Examples

## 1

```scilab
a=[0.9 0.1; 0 0.8]; g=[]; c=[1 0]; q=eye(2,2); r=1;
[l1,p1,e1] = lqe(a,g,c,q,r);
disp("test case 1:");
disp("l1:", l1);
disp("p1:", p1);
disp("e1:", e1);
```
```text
"test case 1:"
"l1:"
   3.8475221
   34.389432
"p1:"
   3.8475221   34.389432
   34.389432   738.52064
"e1:"
  -1.3421586 + 0.i
  -0.8053635 + 0.i
```

## 2

```scilab
a=[-1 0.1; 0 -0.8]; g=eye(2,2); c=[1 0]; q=eye(2,2); r=1;
[l2,p2,e2] = lqe(a,g,c,q,r);
disp("test case 2:");
disp("l2:", l2);
disp("p2:", p2);
disp("e2:", e2);
```
```text
"test case 2:"
"l2:"
   0.4162047
   0.0281790
"p2:"
   0.4162047   0.0281790
   0.0281790   0.6245037
"e2:"
  -1.4115973 + 0.i
  -0.8046074 + 0.i
```

## 3

```scilab
a=[-1 0.1; 0 -0.7]; g=[1;1]; c=[1 0]; q=1; r=0.5;
[l3,p3,e3] = lqe(a,g,c,q,r);
disp("test case 3:");
disp("l3:", l3);
disp("p3:", p3);
disp("e3:", e3);
```
```text
"test case 3:"
"l3:"
   0.7800861
   0.8435322
"p3:"
   0.3900430   0.4217661
   0.4217661   0.4601620
"e3:"
  -1.6953377 + 0.i
  -0.7847483 + 0.i
```

## 4

```scilab
a=[-1 0.1; 0 -0.8]; g=eye(2,2); c=[1 0]; q=eye(2,2); r=1; s=[0.1;0.05];
[l4,p4,e4] = lqe(a,g,c,q,r,s);
disp("test case 4:");
disp("l4:", l4);
disp("p4:", p4);
disp("e4:", e4);
```
```text
"test case 4:"
"l4:"
   0.4843609
   0.0666368
"p4:"
   0.3843609   0.0166368
   0.0166368   0.6222247
"e4:"
  -1.4744812 + 0.i
  -0.8098797 + 0.i
```

## 5

```scilab
a=[-0.85 0.2; 0.1 -0.7]; g=eye(2,2); c=[1 0; 0 1]; q=diag([2 1]); r=eye(2,2);
[l5,p5,e5] = lqe(a,g,c,q,r);
disp("test case 5:");
disp("l5:", l5);
disp("p5:", p5);
disp("e5:", e5);
```
```text
"test case 5:"
"l5:"
   0.8065357   0.0643923
   0.0643923   0.5242271
"p5:"
   0.8065357   0.0643923
   0.0643923   0.5242271
"e5:"
  -1.6674306 + 0.i
  -1.2133322 + 0.i
```

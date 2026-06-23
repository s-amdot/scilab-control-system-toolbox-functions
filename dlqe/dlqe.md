# dlqe

## Description

- Computes the steady-state discrete-time Kalman estimator gain.
- Solves the discrete-time estimator Riccati equation and returns the optimal observer gain.
- Supports an optional process/measurement noise cross-covariance matrix `S`.
- Returns the estimator gain, Riccati solution, estimator poles, and Riccati eigenvalues.

## Calling Sequence

- ` [M, P, Z, E] = dlqe(A, G, C, Q, R)`
- ` [M, P, Z, E] = dlqe(A, G, C, Q, R, S)`

## Parameters

- `A` - State transition matrix.
- `G` - Process noise input matrix. If empty, an identity matrix is used.
- `C` - Measurement matrix.
- `Q` - Process noise covariance matrix.
- `R` - Measurement noise covariance matrix.
- `S` - Optional process/measurement noise cross-covariance matrix.
- `M` - Steady-state Kalman gain matrix.
- `P` - Solution of the estimator Riccati equation.
- `Z` - Estimator poles.
- `E` - Riccati equation eigenvalues.

## Dependencies

`dare`- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/dare/dare.sci
`care`- https://github.com/s-amdot/scilab-control-system-toolbox-functions/blob/main/care/care.sci
## Examples

## 1

```scilab
a=[0.9 0.1; 0 0.8]; g=[]; c=[1 0]; q=eye(2,2); r=1;
[m1,p1,z1,e1] = dlqe(a,g,c,q,r);

disp("test case 1:");
disp("m1:", m1);
disp("p1:", p1);
disp("z1:", z1);
disp("e1:", e1);
```
```text
  "test case 1:"
  "m1:"
   0.6061423
   0.1178593
  "p1:"
   1.538988    0.2992435
   0.2992435   2.715078 
  "z1:"
   0.6061423   0.1178593
   0.1178593   2.6798093
  "e1:"
   0.3643278 + 0.i
   0.7783582 + 0.i
```

## 2

```scilab
a=[0.9 0.1; 0 0.8]; g=eye(2,2); c=[1 0]; q=eye(2,2); r=1;
[m2,p2,z2,e2] = dlqe(a,g,c,q,r);

disp("test case 2:");
disp("m2:", m2);
disp("p2:", p2);
disp("z2:", z2);
disp("e2:", e2);
```
```text
  "test case 2:"
  "m2:"
   0.6061423
   0.1178593
  "p2:"
   1.538988    0.2992435
   0.2992435   2.715078 
  "z2:"
   0.6061423   0.1178593
   0.1178593   2.6798093
  "e2:"
   0.3643278 + 0.i
   0.7783582 + 0.i
...


## 3

```scilab
a=[0.8 0.1; 0 0.7]; g=[1;1]; c=[1 0]; q=1; r=0.5;
[m3,p3,z3,e3] = dlqe(a,g,c,q,r);

disp("test case 3:");
disp("m3:", m3);
disp("p3:", p3);
disp("z3:", z3);
disp("e3:", e3);
```
```text
  "test case 3:"
  "m3:"
   0.7204033
   0.6789797
  "p3:"
   1.2882901   1.2142127
   1.2142127   1.1686889
  "z3:"
   0.3602017   0.3394899
   0.3394899   0.344263 
  "e3:"
   0.2650541 + 0.i
   0.5907253 + 0.i
...


## 4

```scilab
a=[0.9 0.1; 0 0.8]; g=eye(2,2); c=[1 0]; q=eye(2,2); r=1; s=[0.1;0.05];
[m4,p4,z4,e4] = dlqe(a,g,c,q,r,s);

disp("test case 4:");
disp("m4:", m4);
disp("p4:", p4);
disp("z4:", z4);
disp("e4:", e4);
```
```text
  "test case 4:"
  "m4:"
   0.5846740
   0.1048426
  "p4:"
   1.4077469   0.2524344
   0.2524344   2.7045448
  "z4:"
   0.584674    0.1048426
   0.1048426   2.6780789
  "e4:"
   0.3447625 + 0.i
   0.7770141 + 0.i
...
  
## 5

```scilab
a=[0.85 0.2; 0.1 0.7]; g=eye(2,2); c=[1 0; 0 1]; q=diag([2 1]); r=eye(2,2);
[m5,p5,z5,e5] = dlqe(a,g,c,q,r);

disp("test case 5:");
disp("m5:", m5);
disp("p5:", p5);
disp("z5:", z5);
disp("e5:", e5);
```
```text
  "test case 5:"
  "m5:"
   0.7172784   0.0186869
   0.0186869   0.5610735
  "p5:"
   2.5470301   0.1510114
   0.1510114   1.284715 
  "z5:"
   0.7172784   0.0186869
   0.0186869   0.5610735
  "e5:"
   0.2232728 + 0.i
   0.318683  + 0.i
...

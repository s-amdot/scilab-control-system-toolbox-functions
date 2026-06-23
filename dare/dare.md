# dare

## Description

* Solves the discrete-time Algebraic Riccati Equation (DARE).
* Computes the stabilizing Riccati solution matrix `X`, the closed-loop eigenvalues `L`, and the optimal state-feedback gain matrix `G`.
* Supports generalized descriptor systems through the descriptor matrix `E`.
* Supports an optional cross-weighting matrix `S`.

## Calling Sequence

* `[X, L, G] = dare(A, B, Q, R)`
* `[X, L, G] = dare(A, B, Q, R, S)`
* `[X, L, G] = dare(A, B, Q, R, S, E)`

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
A = 0.5; B = 1; Q = 1; R = 1;
[X, L, G] = dare(A, B, Q, R);
disp("Test case 1:")
disp("T1 X:", X); disp("T1 L:", L); disp("T1 G:", G);
```
```text
"T1 X:"
   1.1328

"T1 L:"
   0.2344

"T1 G:"
   0.2656
```

## 2

```scilab
A = [0.9 0.1; 0 0.8]; B = [0; 1]; Q = eye(2,2); R = 1;
[X, L, G] = dare(A, B, Q, R);
disp("Test case 2:")
disp("T2 X:", X); disp("T2 L:", L);
```
```text
"T2 X:"
   5.2634   0.8017
   0.8017   2.1869

"T2 L:"
   0.9000
   0.2965
```

## 3

```scilab
A = [1 0.1; 0 1];
B = [0; 0.1];
Q = eye(2,2);
R = 1;
S = [0; 0.05];

[X, L, G] = dare(A, B, Q, R, S);
disp("Test case 3:")
disp("T3 X:", X);
disp("T3 G:", G);
```
```text
"T3 X:"
   18.3426   10.9046
   10.9046   18.9110

"T3 G:"
   0.9170   1.6821
```

## 4

```scilab
a = [0.9 0.1; 0 0.8];
b = [0;1];
q = eye(2,2);
r = 1;
s = [];
e = [2 0; 0 1];
[xe1,le1,ge1] = dare(a,b,q,r,s,e);
disp("Test case 4:")
disp("xe1:", xe1)
disp("lel:", le1)
disp("ge1:", ge1)
```
```text
  "xe1:"
   0.3134501   0.0166194
   0.0166194   1.3747512
  "lel:"
   0.4471624 + 0.i
   0.3390151 + 0.i
  "ge1:"
   0.0062986   0.4638224
```

## 5

```scilab
a=[0.85 0.2; 0.1 0.7]; 
b=[1;1]; 
q=diag([3 1]); 
r=2; 
s=[0.1;0.2]; 
e=[1.5 0.2; 0 1.2];
[xe2,le2,ge2] = dare(a,b,q,r,s,e);
disp("Test case 5:")
disp("xe2: ", xe2)
disp("le2: ", le2)
disp("ge2:", ge2)
```
```text
  "xe2: "
   1.6607874  -0.3628453
  -0.3628453   0.9293617
  "le2: "
   0.2731445 + 0.i
   0.5       + 0.i
  "ge2:"
   0.326023   0.2215446
```

# dss

## Description

- Create a descriptor state-space model.
- Encapsulates matrices A, B, C, D and descriptor matrix E into a state-space system representing the descriptor equation
  ```
  E*x' = A*x + B*u
  y = C*x + D*u
  ```
- If called with an existing state-space system and the descriptor matrix `E` is empty, `E` is replaced by an identity matrix of appropriate size.

## Calling Sequence

- `sys = dss(A, B, C, D, E)`
- `sys = dss(A, B, C, D, E, tsam)`
- `sys = dss(sys)`

## Parameters

- `A` - State matrix.
- `B` - Input matrix.
- `C` - Output matrix.
- `D` - Feedthrough matrix.
- `E` - Descriptor matrix of the same dimensions as `A`.
- `tsam` - Sampling time. If omitted, the system is continuous-time.
- `sys` - Existing state-space system to be converted to descriptor form.

## Dependencies

`__sys_data__`

## Examples

### 1

```scilab
A1 = [1, 2; 3, 4];
B1 = [1; 0];
C1 = [1, 0];
D1 = [0];
E1 = [2, 1; 0, 3];
sys1 = dss(A1, B1, C1, D1, E1);
disp("test case 1: ");
disp(sys1);
disp("E matrix:");
disp(sys1.E);
```

```
"test case 1: "
[state-space]
  A (matrix) = [1,2;3,4]
  B (matrix) = [1;0]
  C (matrix) = [1,0]
  D (matrix) = 0
  X0 (initial state) = [0;0]
  dt (time domain) = "c"
"E matrix:"
   2.   1.
   0.   3.
```

### 2

```scilab
A2 = [0, 1; -2, -3];
B2 = [0; 1];
C2 = [1, 0];
D2 = [0];
E2 = eye(2, 2);
sys2 = dss(A2, B2, C2, D2, E2);
disp("test case 2: ");
disp(sys2);
disp("E matrix:");
disp(sys2.E);
```

```
"test case 2: "
[state-space]
  A (matrix) = [0,1;-2,-3]
  B (matrix) = [0;1]
  C (matrix) = [1,0]
  D (matrix) = 0
  X0 (initial state) = [0;0]
  dt (time domain) = "c"
"E matrix:"
   1.   0.
   0.   1.
```

### 3

```scilab
A3 = [0.5, 0.1; 0, 0.9];
B3 = [1; 1];
C3 = [1, 0];
D3 = [0];
E3 = [1, 0.2; 0, 1];
tsam3 = 0.01;
sys3 = dss(A3, B3, C3, D3, E3, tsam3);
disp("test case 3: ");
disp(sys3);
disp("E matrix:");
disp(sys3.E);
```

```
"test case 3: "
[state-space]
  A (matrix) = [0.5,0.1;0,0.9]
  B (matrix) = [1;1]
  C (matrix) = [1,0]
  D (matrix) = 0
  X0 (initial state) = [0;0]
  dt (time domain) = 0.01
"E matrix:"
   1.   0.2
   0.   1.
```

### 4

```scilab
A4 = [0, 1, 0; 0, 0, 1; -6, -11, -6];
B4 = [0; 0; 1];
C4 = [1, 0, 0];
D4 = [0];
E4 = [2, 0, 0; 0, 1, 0; 0, 0, 3];
sys4 = dss(A4, B4, C4, D4, E4);
disp("test case 4: ");
disp(sys4);
disp("E matrix:");
disp(sys4.E);
```

```
"test case 4: "
[state-space]
  A (matrix) = [0,1,0;0,0,1;-6,-11,-6]
  B (matrix) = [0;0;1]
  C (matrix) = [1,0,0]
  D (matrix) = 0
  X0 (initial state) = [0;0;0]
  dt (time domain) = "c"
"E matrix:"
   2.   0.   0.
   0.   1.   0.
   0.   0.   3.
```

### 5

```scilab
A5 = [1 0; 0 2];
B5 = [1; 1];
C5 = [1 1];
D5 = [0 0];
E5 = eye(2,2);
disp("test case 5:");
sys5 = dss(A5, B5, C5, D5, E5);
disp(sys5);
```

```
"test case 5: "

syslin: Incompatible input arguments #3 and #5: Same column dimensions expected.
```

### 6

```scilab
A6 = [1.2, 0.3; 0.0, 0.8];
B6 = [1; 0];
C6 = [1, 0];
D6 = [0];
E6 = [2, 0; 0, 1];
tsam6 = 0.1;
sys6 = dss(A6, B6, C6, D6, E6, tsam6);
disp("test case 6: ");
disp(sys6);
disp("E matrix:");
disp(sys6.E);
```

```
"test case 6: "
[state-space]
  A (matrix) = [1.2,0.3;0,0.8]
  B (matrix) = [1;0]
  C (matrix) = [1,0]
  D (matrix) = 0
  X0 (initial state) = [0;0]
  dt (time domain) = 0.1
"E matrix:"
   2.   0.
   0.   1.
```

### 7

```scilab
A7 = [0.9, 0.1; -0.2, 0.95];
B7 = [0; 1];
C7 = [1, 1];
D7 = [0];
E7 = [1, 0.5; 0, 1];
tsam7 = 0.05;
sys7 = dss(A7, B7, C7, D7, E7, tsam7);
disp("test case 7: ");
disp(sys7);
disp("E matrix:");
disp(sys7.E);
```

```
"test case 7: "
[state-space]
  A (matrix) = [0.9,0.1;-0.2,0.95]
  B (matrix) = [0;1]
  C (matrix) = [1,1]
  D (matrix) = 0
  X0 (initial state) = [0;0]
  dt (time domain) = 0.05
"E matrix:"
   1.   0.5
   0.   1.
```

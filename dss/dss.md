# dss

## Description

- Create a descriptor state-space model.
- Encapsulates matrices A, B, C, D and a descriptor matrix E into a struct representing the system
  E*x' = A*x + B*u
  y = C*x + D*u.
- If called with a single struct argument and E is empty, E is replaced by an identity matrix of appropriate size.

## Calling Sequence

- `sys = dss (A, B, C, D, E)`
- `sys = dss (A, B, C, D, E, tsam)`
- `sys = dss (sys)`

## Parameters

- `A, B, C, D` - State-space matrices
- `E` - Descriptor matrix, same size as A
- `tsam` - Sampling time. 0 for continuous-time (default)
- `sys` - Descriptor state-space struct with fields A, B, C, D, E, dt

## Dependencies

none

## Examples

## 1

```
A = [1, 2; 3, 4];
B = [1; 0];
C = [1, 0];
D = [0];
E = [2, 1; 0, 3];
sys = dss(A, B, C, D, E);
disp(sys.E);
```

```
sys1 =
    A =
       1   2
       3   4
    B =
       1
       0
    C =
       1   0
    D = 0
    E =
       2   1
       0   3
    dt = 0
```

## 2

```
A2 = [0, 1; -2, -3]; 
B2 = [0; 1]; 
C2 = [1, 0]; 
D2 = [0]; 
E2 = eye(2, 2);
sys2 = dss(A2, B2, C2, D2, E2)
```

```
sys2 =
  scalar structure containing the fields:
    A =
       0   1
      -2  -3
    B =
       0
       1
    C =
       1   0
    D = 0
    E =
       1   0
       0   1
    dt = 0
```

## 3

```
A3 = [0.5, 0.1; 0, 0.9]; 
B3 = [1; 1]; 
C3 = [1, 0]; 
D3 = [0]; 
E3 = [1, 0.2; 0, 1];
tsam3 = 0.01;
sys3 = dss(A3, B3, C3, D3, E3, tsam3)
```

```
sys3 =
    A =
       0.5000   0.1000
       0.0000   0.9000
    B =
       1
       1
    C =
       1   0
    D = 0
    E =
       1.0000   0.2000
       0.0000   1.0000
    dt = 0.0100
```

## 4

```
A4 = [0, 1, 0; 0, 0, 1; -6, -11, -6]; 
B4 = [0; 0; 1]; 
C4 = [1, 0, 0]; 
D4 = [0]; 
E4 = [2, 0, 0; 0, 1, 0; 0, 0, 3];
sys4 = dss(A4, B4, C4, D4, E4)

```

```
sys4 =
  scalar structure containing the fields:
    A =
       0   1   0
       0   0   1
      -6 -11  -6
    B =
       0
       0
       1
    C =
       1   0   0
    D = 0
    E =
       2   0   0
       0   1   0
       0   0   3
    dt = 0
```

## 5

```
sys_in = struct();
sys_in.A = [1, 0; 0, 2]; 
sys_in.B = [1; 1]; 
sys_in.C = [1, 1]; 
sys_in.D = [0]; 
sys_in.E = []; 
sys_in.dt = 0;
sys5 = dss(sys_in)

```

```
sys5 =
  scalar structure containing the fields:
    A =
       1   0
       0   2
    B =
       1
       1
    C =
       1   1
    D = 0
    E =
       1   0
       0   1
    dt = 0
```

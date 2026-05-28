# dss

## Description

- Create a descriptor state-space model.
- Encapsulates matrices A, B, C, D and a descriptor matrix E into a struct representing the system E*x' = A*x + B*u, y = C*x + D*u.
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

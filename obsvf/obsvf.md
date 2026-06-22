# obsvf

## Description
Computes the observability canonical form (observability staircase form) of a linear state-space system. It transforms the system into a new coordinate basis where observable and unobservable states are separated into distinct subsystems.

## Calling Sequence
```
[Ao, Bo, Co, T, no] = obsvf(A, B, C)
[Ao, Bo, Co, T, no] = obsvf(A, B, C, tol)
```

## Parameters
```
**A** - n×n system state matrix
**B** - n×m input matrix
**C**- p×n output matrix
**tol** - optional tolerance for rank/observability detection
**Ao** - transformed state matrix (observability form)
**Bo** - transformed input matrix
**Co** - transformed output matrix
**T** - similarity transformation matrix
**no** - number of observable states
```

## Dependencies
```
function:
ctrbf

source:
https://github.com/yeoleparesh/Control-system/blob/master/ctrbf.sci
```

## Examples

## 1 

```
A1 = [1 1; 0 2];
B1 = [0; 1];
C1 = [1 0];

[Ao1, Bo1, Co1, T1, no1] = obsvf(A1, B1, C1);

disp("test case 1: no:");
disp(no1);
disp("test case 1: Ao:");
disp(Ao1);
```
```
test case 1: no:
0. 0.

test case 1: Ao:
1. 1.
0. 2.
```

## 2

```
A2 = [1 0; 0 2];
B2 = [1; 1];
C2 = [1 0];

[Ao2, Bo2, Co2, T2, no2] = obsvf(A2, B2, C2);

disp("test case 2: no:");
disp(no2);
disp("test case 2: Co:");
disp(Co2);
```
```
test case 2: no:
0.   0.
test case 2: Co:
1. 0.
```



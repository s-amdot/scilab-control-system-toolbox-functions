# pzmap

## Description

- Plot the poles and zeros of an LTI system in the complex plane.
- If no output arguments are given, the result is plotted on screen with poles marked as 'x' and zeros marked as 'o'.
- Only one system is processed when output arguments are given.
- Multiple systems with optional color styles can be passed for plotting.

## Calling Sequence

- `pzmap (sys)`
- `pzmap (sys1, sys2, ..., sysN)`
- `pzmap (sys1, 'style1', ..., sysN, 'styleN')`
- `[p, z] = pzmap (sys)`

## Parameters

- `sys` - LTI model
- `'style'` - color string e.g. `'r'` for red. marker types are fixed as `x` for poles and `o` for zeros
- `p` - poles of sys
- `z` - invariant zeros of sys

## Dependencies

**trzeros**, **spec**

## Examples

## 1

```
s = %s;
sys1 = syslin('c', 1 / (s + 3));
[p1, z1] = pzmap(sys1);
disp(p1);
disp(z1);
```

```
-3

[]
```

## 2

```
s = %s;
sys2 = syslin('c', 1 / (s^2 + 2*s + 5));
[p2, z2] = pzmap(sys2);
disp(p2);
disp(z2)
```

```
-1. + 2.0i
-1. - 2.0i

[]
```

## 3

```
s = %s;
sys3 = syslin('c', (s + 2) / ((s + 1) * (s + 4)));
[p3, z3] = pzmap(sys3);
disp(p3);
disp(z3);

```

```
-1
-4

-2
```

## 4

```
A = [0, 1; -6, -5];
B = [0; 1];
C = [1, 0];
D = [0];
sys4 = syslin('c', A, B, C, D);
[p4, z4] = pzmap(sys4);
disp(p4);
disp(z4);
```

```
-2
-3

[]
```

## 5

```
s = %s;
sys5 = syslin('c', (s^2 + 3s + 2) / (s^3 + 6s^2 + 11*s + 6));
[p5, z5] = pzmap(sys5);
disp(p5);
disp(z5);
```

```
-1
-2
-3

-1
-2
```

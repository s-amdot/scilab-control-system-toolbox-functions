# filtdata

## Description
- Extracts the numerator and denominator coefficient vectors of a discrete-time transfer function.
- Returns the sampling time of the transfer function.
- Optionally returns coefficient vectors for SISO transfer functions when "vector" output is requested.

## Calling Sequence
- `[num, den] = filtdata(sys)`
- `[num, den, tsam] = filtdata(sys)`
- `[num, den] = filtdata(sys, rtype)`
- `[num, den, tsam] = filtdata(sys, rtype)`

## Parameters
- `sys` - Discrete-time LTI system (transfer function, state-space, or static gain).
- `rtype` - Output format. `"cell"` (default) returns cell arrays, `"vector"` returns vectors for SISO systems.
- `num` - Numerator coefficient vector(s).
- `den` - Denominator coefficient vector(s).
- `tsam` - Sampling time of the system.

## Dependencies
- `tf`
- `tfdata`
- `isdt`
- `issiso`

---

## Examples

## 1

```scilab
sys1 = tf([1 0.5], [1 -0.2 0.1], 0.1);

[num1, den1, tsam1] = filtdata(sys1);

disp("Test Case 1:");
disp(num1);
disp(den1);
disp(tsam1);
```

```text
"Test Case 1:"
   0.   0.5   1.
   0.1  -0.2   1.
   0.1
```

---

## 2

```scilab
sys2 = tf(5, 1, 0.2);

[num2, den2, tsam2] = filtdata(sys2);

disp("Test Case 2:");
disp(num2);
disp(den2);
disp(tsam2);
```

```text
"Test Case 2:"
   5.
   1.
   0.2
```

---

## 3

```scilab
sys3 = tf([0.1 0.2 0.1], [1 -1.2 0.36], 1);

[num3, den3, tsam3] = filtdata(sys3);

disp("Test Case 3:");
disp(num3);
disp(den3);
disp(tsam3);
```

```text
"Test Case 3:"
   0.1   0.2   0.1
   0.36  -1.2   1.
   1.
```

---

## 4

```scilab
sys4 = tf([1 2 3 4], 1, 0.05);

[num4, den4, tsam4] = filtdata(sys4);

disp("Test Case 4:");
disp(num4);
disp(den4);
disp(tsam4);
```

```text
"Test Case 4:"
   4.   3.   2.   1.
   0.   0.   0.   1.
   0.05
```

---

## 5

```scilab
sys5 = tf([1 -1], [1 -0.8], "d");

[num5, den5, tsam5] = filtdata(sys5);

disp("Test Case 5:");
disp(num5);
disp(den5);
disp(tsam5);
```

```text
"Test Case 5:"
  -1.   1.
  -0.8   1.
   1.
```

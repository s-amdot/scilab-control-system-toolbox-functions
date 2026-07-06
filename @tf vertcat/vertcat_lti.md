# vertcat

## Description

- Vertically concatenates two or more LTI system models.
- Applicable to transfer function and state-space (`syslin`) systems.
- Combines systems row-wise, increasing the number of outputs while preserving the number of inputs.
- All systems must have the same number of inputs.
- All systems must have compatible sampling times.

## Calling Sequence

- `V = vertcat_lti(sys1, sys2)`
- `V = vertcat_lti(sys1, sys2, sys3, ...)`
- `V = [sys1; sys2]`

## Parameters

- `sys1, sys2, ...` - LTI system models to concatenate vertically. All systems must have the same number of inputs.
- `V` - Resulting LTI system containing all outputs stacked vertically.

## Dependencies

- `__sys_group__`

## Examples

## 1

```scilab
sys1 = tf([1],[1 1]);
sys2 = tf([1],[1 2]);

v1 = vertcat_lti(sys1, sys2);

disp("V-Test 1:");
disp(size(v1));
```

```text
"V-Test 1:"
   2.   1.
```

---

## 2

```scilab
sys1 = tf([1],[1 1]);
sys2 = tf([1],[1 2]);
sys3 = tf([2],[1 3]);

v2 = vertcat_lti(sys1, sys2, sys3);

disp("V-Test 2:");
disp(size(v2));
```

```text
"V-Test 2:"
   3.   1.
```

---

## 3

```scilab
A = [-1 0;
      0 -2];
B = [1 0;
     0 1];
C = [1 1];
D = [0 0];

m1 = syslin("c", A, B, C, D);

m2 = syslin("c", A, B, [1 0], [0 0]);

v3 = vertcat_lti(m1, m2);

disp("V-Test 3:");
disp(size(v3));
```

```text
"V-Test 3:"
   2.   2.
```

---

## 4

```scilab
sys1 = tf([1],[1 1]);

v4 = vertcat_lti(sys1);

disp("V-Test 4:");
disp(size(v4));
```

```text
"V-Test 4:"
   1.   1.
```

---

## 5

```scilab
sys1 = tf([1],[1 1]);

A = [-1 0;
      0 -2];
B = [1 0;
     0 1];
C = [1 1];
D = [0 0];

m1 = syslin("c", A, B, C, D);

disp("V-Test 5:");

ierr = execstr("v5 = vertcat_lti(sys1, m1);", "errcatch");

if ierr <> 0 then
    disp(lasterror());
else
    disp(size(v5));
end
```

```text
"V-Test 5:"
"lti: vertcat_lti: number of system inputs incompatible: [(1x1); (1x2)]"
```
```text
"test case 5: EXPECTING ERROR"
error: vertcat_lti: transfer functions must have the same number of inputs
```

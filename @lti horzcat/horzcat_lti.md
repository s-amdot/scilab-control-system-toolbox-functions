# horzcat

## Description

- Horizontally concatenates two or more LTI system models.
- Applicable to transfer function and state-space (`syslin`) systems.
- Combines systems column-wise, increasing the number of inputs while preserving the number of outputs.
- All systems must have the same number of outputs.
- All systems must have compatible sampling times.

## Calling Sequence

- `H = horzcat(sys1, sys2)`
- `H = horzcat(sys1, sys2, sys3, ...)`
- `H = [sys1, sys2]`

## Parameters

- `sys1, sys2, ...` - LTI system models to concatenate horizontally. All systems must have the same number of outputs.
- `H` - Resulting LTI system containing all inputs combined horizontally.

## Dependencies

- `__sys_group__`- https://github.com/pavannani99/Scilab-control-system-toolbox-development-functions/tree/main/blkdiag/DEPENDENCIES

## Examples

## 1

```scilab
sys1 = tf([1],[1 1]);
sys2 = tf([1],[1 2]);

h1 = horzcat_lti(sys1, sys2);

disp("H-Test 1:");
disp(size(h1));
```

```text
"H-Test 1:"
   1.   2.
```

---

## 2

```scilab
sys1 = tf([1],[1 1]);
sys2 = tf([1],[1 2]);
sys3 = tf([2],[1 3]);

h2 = horzcat_lti(sys1, sys2, sys3);

disp("H-Test 2:");
disp(size(h2));
```

```text
"H-Test 2:"
   1.   3.
```

---

## 3

```scilab
A = [-1 0;
      0 -2];
B = [1;
     1];
C = [1 0;
     0 1];
D = [0;
     0];

m1 = syslin("c", A, B, C, D);
m2 = syslin("c", A, B, C, D);

h3 = horzcat_lti(m1, m2);

disp("H-Test 3:");
disp(size(h3));
```

```text
"H-Test 3:"
   2.   2.
```

---

## 4

```scilab
sys1 = tf([1],[1 1]);

h4 = horzcat_lti(sys1);

disp("H-Test 4:");
disp(size(h4));
```

```text
"H-Test 4:"
   1.   1.
```

---

## 5

```scilab
sys1 = tf([1],[1 1]);

A = [-1 0;
      0 -2];
B = [1;
     1];
C = [1 0;
     0 1];
D = [0;
     0];

m1 = syslin("c", A, B, C, D);

disp("H-Test 5 (mismatched outputs -> expect error):");

ierr = execstr("h5 = horzcat_lti(sys1, m1);", "errcatch");

if ierr <> 0 then
    disp(lasterror());
else
    disp(size(h5));
end
```

```text
"H-Test 5 (mismatched outputs -> expect error):"
"lti: horzcat: number of system outputs incompatible: [(1x1), (2x1)]"
```

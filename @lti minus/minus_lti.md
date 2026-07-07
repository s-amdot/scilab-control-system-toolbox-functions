# minus_lti

## Description

- Subtracts one LTI system from another.
- Performs element-wise subtraction of two compatible state-space systems.
- Both systems must have identical input-output dimensions and compatible sampling times.
- Returns the resulting LTI system in state-space form.

## Calling Sequence

- `sys = minus_lti(sys1, sys2)`
- `sys = sys1 - sys2`

## Parameters

- `sys1` - First LTI system.
- `sys2` - Second LTI system.
- `sys` - Resulting LTI system after subtraction.

## Dependencies

- `__sys_group__`- https://github.com/pavannani99/Scilab-control-system-toolbox-development-functions/tree/main/blkdiag/DEPENDENCIES

## Examples

### 1

```scilab
s1 = tf([1],[1 1]);
s2 = tf([1],[1 2]);

d1 = minus_lti(s1, s2);

disp("minus_lti Test 1 (expect 1 out, 1 in):");
disp(size(d1));
disp(d1);
```

```text
"minus_lti Test 1 (expect 1 out, 1 in):"
   1.   1.
[state-space]
A (matrix) = [-1,0;0,-2]
B (matrix) = [1;1]
C (matrix) = [1,-1]
D (matrix) = 0
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

---

### 2

```scilab
s1 = tf([1],[1 1]);
s3 = tf([2],[1 3]);

d2 = minus_lti(s1, s3);

disp("minus_lti Test 2:");
disp(size(d2));
disp(d2);
```

```text
"minus_lti Test 2:"
   1.   1.
[state-space]
A (matrix) = [-1,0;0,-3]
B (matrix) = [1;1.4142136]
C (matrix) = [1,-1.4142136]
D (matrix) = 0
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

---

### 3

```scilab
A = [-1 0; 0 -2];
B = [1 0; 0 1];
C = [1 0; 0 1];
D = zeros(2,2);

M1 = syslin("c", A, B, C, D);
M2 = syslin("c", A, B, C, D);

d3 = minus_lti(M1, M2);

disp("minus_lti Test 3 (expect 2 out, 2 in):");
disp(size(d3));
```

```text
"minus_lti Test 3 (expect 2 out, 2 in):"
   2.   2.
```

---

### 4

```scilab
s1 = tf([1],[1 1]);

d4 = minus_lti(s1, s1);

disp("minus_lti Test 4 (expect 1 out, 1 in):");
disp(size(d4));
disp(d4);
```

```text
"minus_lti Test 4 (expect 1 out, 1 in):"
   1.   1.
[state-space]
A (matrix) = [-1,0;0,-1]
B (matrix) = [1;1]
C (matrix) = [1,-1]
D (matrix) = 0
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

---

### 5

```scilab
A = [-1 0; 0 -2];
B = [1 0; 0 1];
C = [1 0; 0 1];
D = zeros(2,2);

M1 = syslin("c", A, B, C, D);

disp("minus_lti Test 5 (mismatch -> expect error):");

d5 = minus_lti(s1, M1);
```

```text
"minus_lti Test 5 (mismatch -> expect error):"

lti: minus_lti: system dimensions incompatible: (1x1) - (2x2)
```

---

### 6

```scilab
As1 = -1; Bs1 = 1; Cs1 = 1; Ds1 = 0;
ss1 = syslin("c", As1, Bs1, Cs1, Ds1);

As2 = -2; Bs2 = 1; Cs2 = 1; Ds2 = 0;
ss2 = syslin("c", As2, Bs2, Cs2, Ds2);

dss1 = minus_lti(ss1, ss2);

disp("SS minus_lti (SISO):");
disp(dss1);
```

```text
"SS minus_lti (SISO):"
[state-space]
A (matrix) = [-1,0;0,-2]
B (matrix) = [1;1]
C (matrix) = [1,-1]
D (matrix) = 0
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

---

### 7

```scilab
A = [-1 0.5; 0 -2];
B = [1 0; 0 1];
C = [1 0; 0 1];
D = zeros(2,2);
Ms1 = syslin("c", A, B, C, D);

A2 = [-3 0; 1 -4];
B2 = [1 0; 0 1];
C2 = [1 0; 0 1];
D2 = zeros(2,2);
Ms2 = syslin("c", A2, B2, C2, D2);

dss2 = minus_lti(Ms1, Ms2);

disp("SS minus_lti (MIMO 2x2):");
disp(dss2);
```

```text
"SS minus_lti (MIMO 2x2):"
[2x2 state-space]
A (matrix) = [-1,0.5,0,0;0,-2,0,0;0,0,-3,0;0,0,1,-4]
B (matrix) = [1,0;0,1;1,0;0,1]
C (matrix) = [1,0,-1,0;0,1,0,-1]
D (matrix) = [0,0;0,0]
X0 (initial state) = [0;0;0;0]
dt (time domain) = "c"
```

---

### 8

```scilab
Ad = [0.5 0; 0 0.3];
Bd = [1; 1];
Cd = [1 0];
Dd = 0;

dss_a = syslin(0.1, Ad, Bd, Cd, Dd);
dss_b = syslin(0.1, [0.4 0; 0 0.2], [1; 1], [1 0], 0);

dss3 = minus_lti(dss_a, dss_b);

disp("SS minus_lti (discrete):");
disp(dss3);
```

```text
"SS minus_lti (discrete):"
[state-space]
A (matrix) = [0.5,0,0,0;0,0.3,0,0;0,0,0.4,0;0,0,0,0.2]
B (matrix) = [1;1;1;1]
C (matrix) = [1,0,-1,0]
D (matrix) = 0
X0 (initial state) = [0;0;0;0]
dt (time domain) = 0.1
```

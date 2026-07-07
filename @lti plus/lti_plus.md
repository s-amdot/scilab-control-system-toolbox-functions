# plus_lti

## Description

- Adds two LTI systems.
- Performs element-wise addition of two compatible state-space systems.
- Both systems must have identical input-output dimensions and compatible sampling times.
- Returns the resulting LTI system in state-space form.

## Calling Sequence

- `sys = plus_lti(sys1, sys2)`
- `sys = sys1 + sys2`

## Parameters

- `sys1` - First LTI system.
- `sys2` - Second LTI system.
- `sys` - Resulting LTI system after addition.

## Dependencies

- `__sys_group__`- https://github.com/pavannani99/Scilab-control-system-toolbox-development-functions/tree/main/blkdiag/DEPENDENCIES

## Examples

### 1.

```scilab
p1 = tf([3],[1 4]);
p2 = tf([1],[1 5]);

a1 = plus_lti(p1, p2);

disp("plus_lti Test 1:");
disp(a1);
```

```text
"plus_lti Test 1:"
[state-space]
A (matrix) = [-4,0;0,-5]
B (matrix) = [1.7320508;1]
C (matrix) = [1.7320508,1]
D (matrix) = 0
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

---

### 2.

```scilab
p1 = tf([3],[1 4]);
p3 = tf([5],[1 6]);

a2 = plus_lti(p1, p3);

disp("plus_lti Test 2:");
disp(a2);
```

```text
"plus_lti Test 2:"
[state-space]
A (matrix) = [-4,0;0,-6]
B (matrix) = [1.7320508;2.236068]
C (matrix) = [1.7320508,2.236068]
D (matrix) = 0
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

---

### 3.

```scilab
A = [-3 0; 1 -5];
B = [2 0; 0 1];
C = [1 0; 0 2];
D = zeros(2,2);

N1 = syslin("c", A, B, C, D);
N2 = syslin("c", A, B, C, D);

a3 = plus_lti(N1, N2);

disp("plus_lti Test 3:");
disp(a3);
```

```text
"plus_lti Test 3:"
[2x2 state-space]
A (matrix) = [-3,0,0,0;1,-5,0,0;0,0,-3,0;0,0,1,-5]
B (matrix) = [2,0;0,1;2,0;0,1]
C (matrix) = [1,0,1,0;0,2,0,2]
D (matrix) = [0,0;0,0]
X0 (initial state) = [0;0;0;0]
dt (time domain) = "c"
```

---

### 4.

```scilab
p1 = tf([3],[1 4]);

a4 = plus_lti(p1, p1);

disp("plus_lti Test 4:");
disp(a4);
```

```text
"plus_lti Test 4:"
[state-space]
A (matrix) = [-4,0;0,-4]
B (matrix) = [1.7320508;1.7320508]
C (matrix) = [1.7320508,1.7320508]
D (matrix) = 0
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

---

### 5.

```scilab
p2 = tf([1],[1 5]);
p3 = tf([5],[1 6]);

a5 = plus_lti(p2, p3);

disp("plus_lti Test 5:");
disp(a5);
```

```text
"plus_lti Test 5:"
[state-space]
A (matrix) = [-5,0;0,-6]
B (matrix) = [1;2.236068]
C (matrix) = [1,2.236068]
D (matrix) = 0
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

---

### 6.

```scilab
As1 = -1; Bs1 = 1; Cs1 = 1; Ds1 = 0;
ss1 = syslin("c", As1, Bs1, Cs1, Ds1);

As2 = -2; Bs2 = 1; Cs2 = 1; Ds2 = 0;
ss2 = syslin("c", As2, Bs2, Cs2, Ds2);

ass1 = plus_lti(ss1, ss2);

disp("SS plus_lti (SISO):");
disp(ass1);
```

```text
"SS plus_lti (SISO):"
[state-space]
A (matrix) = [-1,0;0,-2]
B (matrix) = [1;1]
C (matrix) = [1,1]
D (matrix) = 0
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

---

### 7.

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

ass2 = plus_lti(Ms1, Ms2);

disp("SS plus_lti (MIMO 2x2):");
disp(ass2);
```

```text
"SS plus_lti (MIMO 2x2):"
[2x2 state-space]
A (matrix) = [-1,0.5,0,0;0,-2,0,0;0,0,-3,0;0,0,1,-4]
B (matrix) = [1,0;0,1;1,0;0,1]
C (matrix) = [1,0,1,0;0,1,0,1]
D (matrix) = [0,0;0,0]
X0 (initial state) = [0;0;0;0]
dt (time domain) = "c"
```

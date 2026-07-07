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

- `__sys_group__`

## Examples

## 1

```scilab
s = poly(0, "s");

sys1 = syslin("c", 1/(s+1));
sys2 = syslin("c", 2/(s+2));

sys = plus_lti(sys1, sys2);

disp("Test Case 1:");
disp(sys);
```

```text
"Test Case 1:"
[state-space]
A (matrix) = [-1,0;0,-2]
B (matrix) = [1;1.4142136]
C (matrix) = [1,1.4142136]
D (matrix) = 0
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

## 2

```scilab
sys1 = syslin("c", (s+2)/(s+1));

sys = plus_lti(sys1, sys1);

disp("Test Case 2:");
disp(sys);
```

```text
"Test Case 2:"
[state-space]
A (matrix) = [-1,0;0,-1]
B (matrix) = [1;1]
C (matrix) = [1,1]
D (matrix) = 2
X0 (initial state) = [0;0]
dt (time domain) = "c"
```

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

sys1 = syslin("c", A, B, C, D);
sys2 = syslin("c", A, B, C, D);

sys = plus_lti(sys1, sys2);

disp("Test Case 3:");
disp(sys);
```

```text
"Test Case 3:"
[2x1 state-space]
A (matrix) = [-1,0,0,0;0,-2,0,0;0,0,-1,0;0,0,0,-2]
B (matrix) = [1;1;1;1]
C (matrix) = [1,0,1,0;0,1,0,1]
D (matrix) = [0;0]
X0 (initial state) = [0;0;0;0]
dt (time domain) = "c"
```

## 4

```scilab
A = [-1 0;
      0 -2];
B = eye(2,2);
C = eye(2,2);
D = zeros(2,2);

sys1 = syslin("c", A, B, C, D);
sys2 = syslin("c", 2*A, B, C, D);

sys = plus_lti(sys1, sys2);

disp("Test Case 4:");
disp(sys);
```

```text
"Test Case 4:"
[2x2 state-space]
A (matrix) = [-1,0,0,0;0,-2,0,0;0,0,-2,0;0,0,0,-4]
B (matrix) = [1,0;0,1;1,0;0,1]
C (matrix) = [1,0,1,0;0,1,0,1]
D (matrix) = [0,0;0,0]
X0 (initial state) = [0;0;0;0]
dt (time domain) = "c"
```

## 5

```scilab
z = poly(0,"z");

sys1 = syslin(0.1, (z+1)/(z-0.2));
sys2 = syslin(0.1, 2/(z-0.5));

sys = plus_lti(sys1, sys2);

disp("Test Case 5:");
disp(sys);
```

```text
"Test Case 5:"
[state-space]
A (matrix) = [0.2,0;0,0.5]
B (matrix) = [1.0954451;1.4142136]
C (matrix) = [1.0954451,1.4142136]
D (matrix) = 1
X0 (initial state) = [0;0]
dt (time domain) = 0.1
```

## 6

```scilab
sys1 = syslin("c", 1/(s+1));

A = [-1 0;
      0 -2];
B = [1;
     1];
C = [1 0;
     0 1];
D = [0;
     0];

sys2 = syslin("c", A, B, C, D);

disp("Test Case 6: EXPECTING ERROR");

sys = plus_lti(sys1, sys2);
```

```text
"Test Case 6: EXPECTING ERROR"

lti: plus: system dimensions incompatible: (1x1) + (2x1)
```

## 7

```scilab
z = poly(0,"z");

sys1 = syslin(0.1, 1/(z-0.5));
sys2 = syslin(0.2, 1/(z-0.3));

disp("Test Case 7: EXPECTING ERROR");

sys = plus_lti(sys1, sys2);
```

```text
"Test Case 7: EXPECTING ERROR"

lti_group: systems must have identical sampling times
```

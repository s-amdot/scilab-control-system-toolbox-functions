# WestlandLynx

## Description

- Returns the linearized state-space model of the Westland Lynx helicopter.
- Provides a benchmark multivariable continuous-time LTI system commonly used in control system analysis and design.
- The model is returned as a state-space (`syslin`) object with predefined system matrices.

## Calling Sequence

- `sys = WestlandLynx()`

## Parameters

- `sys` - Continuous-time state-space model of the Westland Lynx helicopter.

## Dependencies

None

## Examples

## 1

```scilab
sys = WestlandLynx();

// Test Case 1: Load the Westland Lynx benchmark model

disp("Test Case 1:");
disp(sys);
```

```text
"Test Case 1:"
[6x4 state-space]
A (matrix): [8x8 double]
B (matrix): [8x4 double]
C (matrix): [6x8 double]
D (matrix) = [0,0,0,0;
              0,0,0,0;
              0,0,0,0;
              0,0,0,0;
              0,0,0,0;
              0,0,0,0]
X0 (initial state) = [0;0;0;0;0;0;0;0]
dt (time domain) = "c"
```

## 2

```scilab
// Test Case 2: Incorrect number of input arguments (should error)

sys0 = WestlandLynx(1);

disp("Test Case 2:");
disp(sys0);
```

```text
at line     3 of function WestlandLynx
( C:\Users\ssami\OneDrive\Desktop\CStoolbox\fossee\WestlandLynx.sci line 3 )
at line    59 of executed file
C:\Users\ssami\OneDrive\Desktop\CStoolbox\fossee\WestlandLynx.sci

Wrong number of input arguments: This function has no input argument.
```

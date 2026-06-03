# horzcat

## Description
Horizontally concatenates a variable number of input arguments along the second dimension (columns).
This function is a simple wrapper around Scilab’s built-in cat() function with dimension set to 2.

It allows matrices, vectors, and scalars with compatible row dimensions to be concatenated side by side.

## Calling Sequence
```text
dat = horzcat(A,B,C...)
```

## Parameters
* **varargin (or A here)** - Variable number of input arrays (vectors, matrices, or scalars) to be concatenated horizontally. All inputs must have the same number of rows.
* **dat** - Resulting vertically concatenated matrix.

## Dependencies
`cat`- inbuilt scilab function.

---

## Examples

## 1

```
a = [1; 2; 3];
b = [4; 5; 6];
h = horzcat(a, b);
disp(h);
```

```
1 4
2 5
3 6
```

## 2

```
h = horzcat([1; 2], [3; 4], [5; 6]);
disp(h);
```

```
1 3 5
2 4 6
```

## 3

```
A = [1 2; 3 4];
B = [5 6; 7 8];
h = horzcat(A, B);
disp(h);
```

```
1 2 5 6
3 4 7 8
```

## 4

```
h = horzcat(1, 2, 3, 4);
disp(h);
```

```
1 2 3 4
```

## 5

```
h = horzcat([9; 9; 9]);
disp(h);
```

```
9 
9
9
```

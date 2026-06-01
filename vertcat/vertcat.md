# vertcat

## Description
Vertically concatenates a variable number of input arguments along the first dimension (rows).
This function is a simple wrapper around Scilab’s built-in cat() function with dimension set to 1.

It allows matrices, vectors, and scalars with compatible column dimensions to be stacked vertically.

## Calling Sequence
```text
dat = vertcat(A,B,C...)
```

## Parameters
* **varargin (or A here)** - Variable number of input arrays (vectors, matrices, or scalars) to be concatenated vertically. All inputs must have the same number of columns.
* **dat** - Resulting vertically concatenated matrix.

## Dependencies
`cat`- inbuilt scilab function.

---

## Examples

## 1

```
a = [1 2 3]; b = [4 5 6];
v = vertcat(a, b);
disp(v);
```

```
1  2  3
4  5  6
```

## 2

```
v = vertcat([1 2], [3 4], [5 6]);
disp(v);
```

```
1  2
3  4
5  6
```

## 3

```
A = [1 2; 3 4]; B = [5 6; 7 8];
v = vertcat(A, B);
disp(v);
```

```
1  2
3  4
5  6
7  8
```

## 4

```
v = vertcat(1, 2, 3, 4);
disp(v);
```

```
1
2
3
4
```

## 5

```
v = vertcat([9 9 9]);
disp(v);
```

```
9 9 9
```



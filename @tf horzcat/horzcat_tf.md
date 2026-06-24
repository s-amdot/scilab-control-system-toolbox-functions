# horzcat

## Description
- Horizontally concatenates two or more transfer function objects into a MIMO transfer matrix.
- Applicable to `tf` objects only.
- Combines transfer functions column-wise, increasing the number of inputs.
- All transfer functions must have the same number of outputs.

## Calling Sequence
- `H = [g1, g2]`
- `H = [g1, g2, g3, ...]`

## Parameters
- `g1, g2, ...` - Transfer function objects (`tf`) to concatenate horizontally. Must have the same number of rows (outputs).
- `H` - Resulting MIMO transfer function matrix with combined inputs.

## Dependencies
-`tf`- https://github.com/FOSSEE-Internship/FOSSEE-Control-Systems-Toolbox/blob/master/tf.sci

- __sys_group__

## Examples
## 1
```scilab
g1 = tf([1],[1 1]);
g2 = tf([2],[1 2]);

H1 = [g1 g2];

disp("test case 1:");
disp(H1);
```
```text
"test case 1:"
H1 =

  1      2  
 ---   -----
 s+1   s+2  

```

## 2
```scilab
g1 = tf([1],[1 1]);
g2 = tf([1],[1 2]);
g3 = tf([1],[1 3]);

H2 = [g1 g2 g3];

disp("test case 2:");
disp(H2);
```
```text
"test case 2:"
H2 =

  1      1      1  
 ---   -----  -----
 s+1   s+2    s+3  

```

## 3
```scilab
g1 = tf([1 1],[1 3 2]);
g2 = tf([1],[1 4]);

H3 = [g1 g2];

disp("test case 3:");
disp(H3);
```
```text
"test case 3:"
H3 =

   s+1        1   
---------   -----
s^2+3s+2    s+4  

```

## 4
```scilab
g1 = tf([1],[1 1]);
g2 = tf([1 0],[1 2]);

H4 = [g1 g2];

disp("test case 4:");
disp(H4);
```
```text
"test case 4:"
H4 =

  1      s  
 ---   -----
 s+1   s+2  

```

## 5
```scilab
g1 = [tf([1],[1 1]);
      tf([2],[1 2])];

g2 = tf([1],[1 3]);

disp("test case 5: EXPECTING ERROR");
H5 = [g1 g2];
```
```text
"test case 5: EXPECTING ERROR"
error: horzcat: transfer functions must have the same number of outputs
```

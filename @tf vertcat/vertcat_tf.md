# vertcat

## Description
- Vertically concatenates two or more transfer function objects into a MIMO transfer matrix.
- Applicable to `tf` objects only.
- Combines transfer functions row-wise, increasing the number of outputs.
- All transfer functions must have the same number of inputs.
- 
## Calling Sequence
- `V = [g1; g2]`
- `V = [g1; g2; g3; ...]`
  
## Parameters
- `g1, g2, ...` - Transfer function objects (`tf`) to concatenate vertically. Must have the same number of columns (inputs).
- `V` - Resulting MIMO transfer function matrix with combined outputs.

## Dependencies
-`tf`- https://github.com/FOSSEE-Internship/FOSSEE-Control-Systems-Toolbox/blob/master/tf.sci

- __sys_group__
  
## Examples
## 1
```scilab
g1 = tf([1],[1 1]);
g2 = tf([2],[1 2]);

V1 = [g1; g2];

disp("test case 1:");
disp(V1);
```
```text
"test case 1:"
V1 =

  1  
 ---  
 s+1  

  2  
 ---  
 s+2  

```

## 2
```scilab
g1 = tf([1],[1 1]);
g2 = tf([1],[1 2]);
g3 = tf([1],[1 3]);

V2 = [g1; g2; g3];

disp("test case 2:");
disp(V2);
```
```text
"test case 2:"
V2 =

  1  
 ---  
 s+1  

  1  
 ---  
 s+2  

  1  
 ---  
 s+3  

```

## 3
```scilab
g1 = [tf([1],[1 1]) tf([2],[1 2])];
g2 = [tf([3],[1 3]) tf([4],[1 4])];

V3 = [g1; g2];

disp("test case 3:");
disp(V3);
```
```text
"test case 3:"
V3 =

  1      2  
 ---   -----
 s+1   s+2  

  3      4  
 ---   -----
 s+3   s+4  

```

## 4
```scilab
g1 = [tf([1 1],[1 3 2]) tf([1],[1 5])];
g2 = [tf([2],[1 2]) tf([1 0],[1 4])];

V4 = [g1; g2];

disp("test case 4:");
disp(V4);
```
```text
"test case 4:"
V4 =

   s+1        1   
---------   -----
s^2+3s+2    s+5  

  2      s  
 ---   -----
 s+2   s+4  

```

## 5
```scilab
g1 = [tf([1],[1 1]) tf([2],[1 2])];
g2 = tf([1],[1 3]);

disp("test case 5: EXPECTING ERROR");
V5 = [g1; g2];
disp(V5);
```
```text
"test case 5: EXPECTING ERROR"
error: vertcat: transfer functions must have the same number of inputs
```

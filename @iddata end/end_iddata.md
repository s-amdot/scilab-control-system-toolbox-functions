# end_iddata

## Description

* Returns the last valid index along a specified dimension of an iddata object.
* Supports all four dimensions: samples, outputs, inputs, and experiments.
* Handles both single-experiment and multi-experiment iddata objects.
* Used internally to resolve end in indexing expressions such as dat(1:end, :, :).

## Calling Sequence

* `r = end_iddata(dat, k, n)`

## Parameters

* `dat` - Input iddata object (single or multi-experiment)
* `k` - Dimension to query: 1=samples, 2=outputs, 3=inputs, 4=experiments
* `n` - Total number of indices in the indexing expression
* `r` - Last valid index along dimension k

## Dependencies

- iddata - https://github.com/akash-sankar/CSToolboxFunctions/blob/main/iddata/iddata.sci

- size_iddata - https://github.com/akash-sankar/CSToolboxFunctions/blob/main/%40iddata%20size/size.sci


## Examples

## 1 

```scilab
y1 = rand(100, 2); u1 = rand(100, 1);
dat1 = iddata(y1, u1, 0.1);
r1 = end_iddata(dat1, 1, 2);
disp("Test 1 (samples, single exp):");
disp(r1);
```
```
Test 1 (samples, single exp):
   100
```

## 2 
```scilab
r2 = end_iddata(dat1, 2, 2);
disp("Test 2 (outputs):");
disp(r2);
```
```
Test 2 (outputs):
   2
```

## 3 
```scilab
r3 = end_iddata(dat1, 3, 3);
disp("Test 3 (inputs):");
disp(r3);
```
```
Test 3 (inputs):
   1
```

## 4 
```scilab
r4 = end_iddata(dat1, 4, 4);
disp("Test 4 (experiments):");
disp(r4);
```
```
Test 4 (experiments):
   1
```

## 5 
```scilab
ye = list(rand(50, 2), rand(50, 2));
ue = list(rand(50, 1), rand(50, 1));
dat_eq = iddata(ye, ue, 0.1);
r5 = end_iddata(dat_eq, 1, 2);
disp("Test 5 (samples, multi-exp equal):");
disp(r5);
```
```
Test 5 (samples, multi-exp equal):
   50
```

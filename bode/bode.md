# bode

## Description

- Compute and display the bode diagram of a frequency response.
- Returns magnitude in dB and phase in degrees over a frequency vector in rad/s.
- If no output arguments are given, the response is plotted on screen with separate magnitude and phase subplots.
- Frequency range is auto-determined from the system poles and zeros if w is not provided.

## Calling Sequence

- `bode (sys)`
- `bode (sys1, sys2, ..., sysN)`
- `bode (sys1, sys2, ..., sysN, w)`
- `bode (sys1, 'style1', ..., sysN, 'styleN')`
- `[mag, pha, w] = bode (sys)`
- `[mag, pha, w] = bode (sys, w)`

## Parameters

- `sys` - SISO LTI system
- `w` - optional vector of frequency values in rad/s, or cell `{wmin, wmax}` specifying frequency range
- `'style'` - line style string, e.g. `'r'` or `'-.k'`
- `mag` - vector of magnitude values in dB, same length as w
- `pha` - vector of phase values in degrees, same length as w
- `w` - vector of frequency values used in rad/s

## Dependencies

none

## Examples

## 1

```
sys1.A=[-1];
sys1.B=[1];
sys1.C=[1];
sys1.D=[0];
sys1.dt=0;

[m1,p1,w1] = bode(sys1, [0.00001]); 
```

```
test case 1: DC gain = -0.0000 dB
```

## 2

```
sys2.A=[0 1;-4 -0.4];
sys2.B=[0;1];
sys2.C=[1 0];
sys2.D=[0];
sys2.dt=0;
[m2,p2,w2] = bode(sys2);
```

```
test case 2: max magnitude = 1.9809 dB
```

## 3

```
sys3.A=[-0.001];
sys3.B=[1];
sys3.C=[1];
sys3.D=[0];
sys3.dt=0;
w3 = logspace(-1, 2, 100);
[m3,p3,w3_ignore] = bode(sys3, w3);
slope = (m3($) - m3(1)) / (log10(w3($)) - log10(w3(1)));
printf("test case 3: slope ~ %.1f dB/dec\n", slope);
```

```
test case 3: slope ~ -20.0 dB/dec
```

## 4

```
sys4.A=[-2 1;0 -3];
sys4.B=[1;0];
sys4.C=[1 0];
sys4.D=[0];
sys4.dt=0;
w4 = logspace(-1, 3, 150);
[m4,p4,w4_out] = bode(sys4, w4);
printf("test case 4: length match: %s\n", string(length(w4_out)==150));

```

```
test case 4: length match: T
```

## 5

```
sys5.A=[-1];
sys5.B=[1];
sys5.C=[1];
sys5.D=[0];
sys5.dt=0;
[m5,p5,w5] = bode(sys5, [1]);
printf("test case 5: phase at w=1 = %.4f deg\n", p5(1));
```

```
test case 5: phase at w=1 = -45.0000 deg
```

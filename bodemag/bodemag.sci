/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* bodemag.sci
computes only the bode magnitude of a continuous LTI system */
/*
Description:
      Computes the Bode magnitude response only of a continuous LTI system.
      Stripped-down version of bode() that skips phase computation entirely.
      Magnitude is evaluated as 20*log10(|C*(jwI - A)^-1*B + D|) at each frequency point.
      Useful when only gain crossover frequency or resonance peaks are needed.
      If called with no output arguments, the magnitude is plotted on a log-frequency axis.
Calling Sequence:
      bodemag(sys)
      bodemag(sys, w)
      [mag, w] = bodemag(sys)
      [mag, w] = bodemag(sys, w)
Parameters:
      sys     - state-space system struct with fields .A .B .C .D .dt
      sys.A   - n x n system matrix
      sys.B   - n x m input matrix
      sys.C   - p x n output matrix
      sys.D   - p x m feedthrough matrix
      sys.dt  - sampling time, 0 for continuous
      w       - frequency vector in rad/s (optional, auto-generated if omitted)
      mag     - magnitude response in dB
      w       - frequency vector used in rad/s
Dependencies:
      No external dependencies. Uses Scilab built-ins only.
*/

function [num, den, tsam] = filtdata (sys, rtype)
  if (argn(2) > 2) then
    error("filtdata: too many input arguments");
  end
  if (argn(2) < 2) then
    rtype = "cell";
  end

  if (typeof(sys) <> "rational" & typeof(sys) <> "state-space") then
    if (~ (isreal(sys) & (type(sys) == 1))) then
      error("filtdata: has to be called with an @lti object or with a real matrix (static gain)");
    else
      sys = tf (sys, [], -1);
    end
  end

  if (~ isdt (sys)) then
    error("lti: filtdata: require discrete-time system");
  end

  [num, den, tsam] = tfdata (sys);

  for i = 1:length(num)
    lnum = length(num);
    lden = length(den);
    lmax = max(lnum, lden);
    
    num = prepad(num, lmax);
    den = prepad(den, lmax);
  end

  if strncmpi(rtype, "v", 1) & issiso(sys) then
    num = num(1);
    den = den(1);
  end
endfunction

// DEPENDENCIES:

function v = prepad(v, n)
  if (length(v) < n) then
    v = [zeros(1, n - length(v)), matrix(v, 1, -1)];
  end
endfunction

function bool = strncmpi(s1, s2, n)
    if argn(2) <> 3 then
        error("Usage: strncmpi(s1, s2, n)");
    end
    s1 = convstr(s1, "l");
    s2 = convstr(s2, "l");
    bool = part(s1, 1:min(n, length(s1))) == part(s2, 1:min(n, length(s2)));
endfunction

/* issiso.sci source: https://github.com/nikithad14/Scilab-control-system-toolbox-development-functions/blob/main/issiso/issiso.sci */
function bool = issiso(sys)
    if nargin() ~= 1 then
        error("Usage: issiso(sys)");
    end
    bool = and(size(sys) == 1);
endfunction

/* isdt.sci source: https://github.com/pavannani99/Scilab-control-system-toolbox-development-functions/blob/main/isdt.sci */
function bool = isdt(sys)
    [lhs, rhs] = argn(0);

    if rhs <> 1 then
        error("isdt: wrong number of input arguments");
    end

    if typeof(sys) <> "state-space" & typeof(sys) <> "rational" then
        error("isdt: input argument must be an LTI system");
    end

    bool = (sys.dt <> "c");
endfunction


// TEST CASES:
// Test Case 1: Basic discrete-time transfer function
sys1 = tf([1 0.5], [1 -0.2 0.1], 0.1);
[num1, den1, tsam1] = filtdata(sys1);
disp("Test Case 1:");
disp(num1);
disp(den1);
disp(tsam1)


// Test Case 2: Discrete-time static gain
sys2 = tf(5, 1, 0.2);
[num2, den2, tsam2] = filtdata(sys2);
disp("Test Case 2:");
disp(num2);
disp(den2);
disp(tsam2)

// Test Case 3: Second-order IIR filter
sys3 = tf([0.1 0.2 0.1], [1 -1.2 0.36], 1);
[num3, den3, tsam3] = filtdata(sys3);
disp("Test Case 3:");
disp(num3);
disp(den3);
disp(tsam3)

// Test Case 4: FIR filter
sys4 = tf([1 2 3 4], 1, 0.05);
[num4, den4, tsam4] = filtdata(sys4);
disp("Test Case 4:");
disp(num4);
disp(den4);
disp(tsam4)

// Test Case 5: Unknown discrete sampling time
sys5 = tf([1 -1], [1 -0.8], "d");
[num5, den5, tsam5] = filtdata(sys5);
disp("Test Case 5:");
disp(num5);
disp(den5);
disp(tsam5)


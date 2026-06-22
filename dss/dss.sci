/* 2026 Author: Samiksha <samikshaa18@gmail.com> */
/* dss.sci
creates a descriptor state-space system structure */
/*
Description:
      Creates a descriptor state-space (DSS) system representation.
      Extends standard state-space representations by including the 
      descriptor matrix E, which accounts for algebraic constraints.
      Handles both continuous and discrete-time descriptor systems.
Calling Sequence:
      sys = dss(sys_in)
      sys = dss(A, B, C, D, E)
      sys = dss(A, B, C, D, E, tsam)
Dependencies:
      __sys_data__
*/

function [a, b, c, d, e] = __sys_data__(sys)
  a = sys.a;
  b = sys.b;
  c = sys.c;
  d = sys.d;
  e = []; 
endfunction

function sys = dss(varargin)
    select argn(2)
    case 0 then
        error("Wrong number of input arguments.");
    case 1 then
        sys = syslin("c", varargin(1));
        [a, b, c, d, e] = __sys_data__(sys);
        if isempty(e) then
            e = eye(size(a, 1), size(a, 2));
        end

    case 5 then
        A = varargin(1); B = varargin(2); C = varargin(3); D = varargin(4); E = varargin(5);
        sys = syslin("c", A, B, C, D);
        e = E;

    case 6 then
        A = varargin(1); B = varargin(2);
        C = varargin(3); D = varargin(4);
        E = varargin(5);
        tsam = varargin(6);
        if tsam == 0 then
            sys = syslin("c", A, B, C, D);
        else
            sys = syslin(tsam, A, B, C, D);
        end
        e = E;
    
    else
        error("Wrong number of input arguments.");
    end

endfunction
//---------------------------------------------------------------------------------------------------------------------------------------//

// test case 1: simple 2x2 continuous descriptor system with non-identity e
A1 = [1, 2; 3, 4];
B1 = [1; 0];
C1 = [1, 0];
D1 = [0];
E1 = [2, 1; 0, 3];
sys1 = dss(A1, B1, C1, D1, E1);
disp("test case 1: 2x2 continuous descriptor system");
disp("A:");
disp(A1);
disp("E:");
disp(E1);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 2: identity e reduces to standard state-space
A2 = [0, 1; -2, -3];
B2 = [0; 1];
C2 = [1, 0];
D2 = [0];
E2 = eye(2, 2);
sys2 = dss(A2, B2, C2, D2, E2);
disp("test case 2: identity e (equivalent to standard ss)");
disp("E equals identity:");
disp(E2);
disp("B:");
disp(B2);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 3: discrete time descriptor system with tsam
A3 = [0.5, 0.1; 0, 0.9];
B3 = [1; 1];
C3 = [1, 0];
D3 = [0];
E3 = [1, 0.2; 0, 1];
tsam3 = 0.01;
sys3 = dss(A3, B3, C3, D3, E3, tsam3);
disp("test case 3: discrete time descriptor system with tsam = 0.01");
disp("E:");
disp(E3);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 4: 3rd order descriptor system
A4 = [0, 1, 0; 0, 0, 1; -6, -11, -6];
B4 = [0; 0; 1];
C4 = [1, 0, 0];
D4 = [0];
E4 = [2, 0, 0; 0, 1, 0; 0, 0, 3];
sys4 = dss(A4, B4, C4, D4, E4);
disp("test case 4: 3rd order descriptor system with diagonal e");
disp("A:");
disp(A4);
disp("E:");
disp(E4);
disp("C:");
disp(C4);
disp("----------------------------------------------------------------------------------------------------------------------------------");

// test case 5: conversion form dss(sys) where e is empty, should be replaced by identity
A5 = [1, 0; 0, 2];
B5 = [1; 1];
C5 = [1, 1];
D5 = [0];
E5 = [];
sys5 = dss(A5, B5, C5, D5, E5)
disp("test case 5: conversion from struct with empty e, expects e = eye(2)");
disp("E:");
disp(E5);
disp("A:");
disp(A5);
disp("----------------------------------------------------------------------------------------------------------------------------------");

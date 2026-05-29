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
Parameters:
      A       - n x n system matrix
      B       - n x m input matrix
      C       - p x n output matrix
      D       - p x m feedthrough matrix
      E       - n x n descriptor matrix (identity assumed if omitted in struct conversion)
      tsam    - sampling time in seconds, 0 for continuous (optional, default = 0)
      sys_in  - state-space system struct with missing or empty E field
      sys     - output system structure with fields .A .B .C .D .E .dt
Dependencies:
      No external dependencies. Uses Scilab built-ins only.
*/

function sys = dss(varargin)
    select argn(2)
    case 0 then
        error("Wrong number of input arguments.");
    case 1 then
        sys = varargin(1);
        if isempty(sys.E) then
            sys.E = eye(size(sys.A));
        end
    case 5 then
        sys = struct("A",varargin(1),"B",varargin(2),"C",varargin(3),"D",varargin(4),"E",varargin(5));

    case 6 then
        sys = struct("A",varargin(1),"B",varargin(2),"C",varargin(3),"D",varargin(4),"E",varargin(5),"tsam",varargin(6));

    else
        error("Wrong number of input arguments.");

    end
endfunction

//---------------------------------------------------------------------------------------------------------------------------------------//


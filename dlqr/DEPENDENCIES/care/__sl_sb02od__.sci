// DEPENDENCY FOR CARE

function [x,pole] = __sl_sb02od__(A,B,Q,R,L,discrete,jobl)

    n = size(A,1);
    m = size(B,2);

    if jobl == 0 then
        L = zeros(n,m);
    end

    if discrete then
        H = [A            zeros(n,n)  B;
            -Q            eye(n,n)   -L;
             L'           zeros(m,n)  R];

        J = [eye(n,n)     zeros(n,n)  zeros(n,m);
             zeros(n,n)   A'          zeros(n,m);
             zeros(m,n)  -B'          zeros(m,m)];

        [Hs, Js, Zs, dim] = schur(H, J, "d");

    else

        H = [A            zeros(n,n)  B;
            -Q           -A'         -L;
             L'           B'          R];

        J = [eye(n,n)     zeros(n,n)  zeros(n,m);
             zeros(n,n)   eye(n,n)    zeros(n,m);
             zeros(m,n)   zeros(m,n)  zeros(m,m)];

        [Hs, Js, Zs, dim] = schur(H, J, "c");
    end

    if dim <> n then
        error("__sl_sb02od__: stable subspace dimension not equal to n");
    end

    U = Zs(:,1:n);
    U1 = U(1:n,:);
    U2 = U(n+1:2*n,:);

    if abs(det(U1)) < %eps then
        error("__sl_sb02od__: singular invariant subspace");
    end

    x = real(U2/U1);
    x = (x + x')/2;

    if discrete then
        g = (R + B'*x*B) \ (B'*x*A + L');
        pole = spec(A - B*g);
    else
        g = R \ (B'*x + L');
        pole = spec(A - B*g);
    end
endfunction

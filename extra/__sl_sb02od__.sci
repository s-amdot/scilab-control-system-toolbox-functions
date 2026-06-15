function [x,pole] = __sl_sb02od__(A,B,Q,R,L,discrete,jobl)

    n = size(A,1);
    m = size(B,2);

    if jobl == 0 then
        L = zeros(n,m);
    end

    H = [ A zeros(n,n) B ;
         -Q eye(n,n) -L ;
          L' zeros(m,n) R ];

    J = [ eye(n,n) zeros(n,n) B ;
          zeros(n,n) A' zeros(n,m) ;
          zeros(m,n) -B' zeros(m,m) ];

    if discrete then
        [Hs, Js, Zs, dim] = schur(H, J, "d");
    else
        [Hs, Js, Zs, dim] = schur(H, J, "c");
    end

    if dim <> n then
        error("__sl_sb02od__: stable subspace dimension not equal to n");
    end

    U = Zs(:,1:n);

    U1 = U(1:n,:);
    U2 = U(n+1:2*n,:);

    if det(U1) == 0 then
        error("__sl_sb02od__: singular invariant subspace");
    end

    x = real(U2/U1);

    if discrete then
        g = inv(R + B'*x*B) * (B'*x*A + L');
        pole = spec(A - B*g);
    else
        g = inv(R) * (B'*x + L');
        pole = spec(A - B*g);
    end

endfunction

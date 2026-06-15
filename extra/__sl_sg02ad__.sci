function [x,l] = __sl_sg02ad__(A,E,B,Q,R,L,discrete,jobl)

    n = size(A,1);
    m = size(B,2);

    if jobl == 0 then
        L = zeros(n,m);
    end

    H = [ A zeros(n,n) B ;
         -Q E' -L ;
          L' zeros(m,n) R ];

    J = [ E zeros(n,n) B ;
          zeros(n,n) A' zeros(n,m) ;
          zeros(m,n) -B' zeros(m,m) ];

    if discrete then
        [Hs,Js,Zs,dim] = schur(H,J,"d");
    else
        [Hs,Js,Zs,dim] = schur(H,J,"c");
    end

    if dim <> n then
        error("__sl_sg02ad__: stable subspace dimension not equal to n");
    end

    U = Zs(:,1:n);

    U1 = U(1:n,:);
    U2 = U(n+1:2*n,:);

    x = real(U2/U1);

    if discrete then
        g = inv(R + B'*x*B) * (B'*x*A + L');
        l = spec(A - B*g, E);
    else
        g = inv(R) * (B'*x*E + L');
        l = spec(A - B*g, E);
    end

endfunction

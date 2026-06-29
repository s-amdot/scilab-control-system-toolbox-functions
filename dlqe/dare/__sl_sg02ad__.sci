// DEPENDENCY FOR DARE

function [x,l] = __sl_sg02ad__(A,E,B,Q,R,L,discrete,jobl)

    n = size(A,1);
    m = size(B,2);

    if jobl == 0 then
        L = zeros(n,m);
    end
    if discrete then
        H = [ A           zeros(n,n)  B          ;
             -Q           E'          -L         ;
              L'          zeros(m,n)  R          ];
        J = [ E           zeros(n,n)  zeros(n,m) ;
              zeros(n,n)  A'          zeros(n,m) ;
              zeros(m,n)  -B'         zeros(m,m) ];
        [Hs,Js,Zs,dim] = schur(H,J,"d");

    else
        H = [ A           zeros(n,n)  B          ;
             -Q          -A'          -L         ;
              L'          B'          R          ];
        J = [ E           zeros(n,n)  zeros(n,m) ;
              zeros(n,n)  E'          zeros(n,m) ;
              zeros(m,n)  zeros(m,n)  zeros(m,m) ];
        [Hs,Js,Zs,dim] = schur(H,J,"c");
    end

    if dim <> n then
        error("__sl_sg02ad__: stable subspace dimension not equal to n");
    end

    U = Zs(:,1:n);
    U1 = U(1:n,:);
    U2 = U(n+1:2*n,:);
    xt = real(U2/U1);
    x = xt / E;
    x = (x + x')/2;

    if discrete then
        g = (R + B'*x*B) \ (B'*x*A + L');
        l = spec(A - B*g, E);
    else
        g = R \ (B'*x*E + L');
        l = spec(A - B*g, E);
    end

endfunction

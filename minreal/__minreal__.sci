function sys = __minreal__(sys, tol)
    if typeof(sys) == "state-space" then
        if tol == "def" then
            sys = minss(sys);
        else
            sys = minss(sys, tol);
        end
        return;
    end

    sqrt_eps = sqrt(%eps);
    [p, m] = size(sys.num);
    var = varn(sys.den(1,1));
    for ny = 1:p
        for nu = 1:m
            num_p = sys.num(ny,nu);
            den_p = sys.den(ny,nu);

            zer = roots(num_p);
            pol = roots(den_p);

            cn = coeff(num_p);
            cd = coeff(den_p);

            gain = cn($) / cd($);

            for k = length(zer):-1:1
                [mv, idx] = min(abs(zer(k) - pol));
                if tol == "def" then
                    if abs(zer(k)) < sqrt_eps then
                        t = 1000 * %eps;
                    else
                        t = 1000 * abs(zer(k)) * sqrt_eps;
                    end
                else
                    t = tol;
                end
                if abs(zer(k) - pol(idx)) < t then
                    zer(k) = [];
                    pol(idx) = [];
                end
            end

            num = real(gain * poly(zer, var));
            den = real(poly(pol, var));

            n = coeff(num_p);
            d = coeff(den_p);

            n = n($:-1:1);
            d = d($:-1:1);

            num_v = coeff(num);
            den_v = coeff(den);

            num_v = num_v($:-1:1);
            den_v = den_v($:-1:1);

            if and(size(num_v) == size(n)) & and(size(den_v) == size(d)) then

                if d(1) <> 1 then
                    n = n / d(1);
                    d = d / d(1);
                end

                num = poly(n($:-1:1), var, "coeff");
                den = poly(d($:-1:1), var, "coeff");

            end

            sys.num(ny,nu) = num;
            sys.den(ny,nu) = den;

        end
    end

endfunction

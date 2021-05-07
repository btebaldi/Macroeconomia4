function U = UtilityCube(assetGridValues, laborGridValues, wage, eco_param)

% Constroi o Grid de a, a1 e l
U.a_domain = assetGridValues;
U.l_domain = laborGridValues;
[U.a1, U.l, U.a] = meshgrid(U.a_domain, U.l_domain, U.a_domain);

% calcula o cubo de consumo
U.c = (1 + eco_param.r) .* U.a + wage*U.l - U.a1;

% Nao existe consumo negativo
U.c(U.c<=0) = 0.00001;

% Calcula cubo de utilidades
U.Values = (U.c .^(1-eco_param.sigma_c) ./ (1 - eco_param.sigma_c)) + ...
    eco_param.gamma*((1 - U.l) .^(1-eco_param.sigma_l) ./(1-eco_param.sigma_l));

% U.Values = log(U.c) + log(U.l);
end % end of fucntion
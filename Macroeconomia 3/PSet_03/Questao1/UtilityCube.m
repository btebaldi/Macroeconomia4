function U = UtilityCube(assetGridValues, incomeStatesValues, Econom_param)

% Constroi o Grid de a, a1 e c
U.a_domain = assetGridValues;
U.z_domain = incomeStatesValues;
[U.k, U.k1, U.z] = meshgrid(U.a_domain, U.a_domain, U.z_domain);

U.c = U.z + U.k.*(1 + Econom_param.r) - U.k1;

U.c(U.c<0) = 0;

U.Values = (U.c.^(1-Econom_param.Sigma)-1) ./ (1 - Econom_param.Sigma);

end % end of fucntion
function U = Utility(k_ss, econom_param, test_param, z)
    a = econom_param.alpha;
    d = econom_param.delta;
    g = econom_param.gamma;
    u = econom_param.mu;
    GridPoints = test_param.T;
    
    % Constroi o Grid de K, k1 e h
    U.k_domain = linspace(0.25*k_ss, 1.25*k_ss, GridPoints);
    U.h_domain = linspace(0, 1, GridPoints);
    [U.k1, U.h, U.k] = meshgrid(U.k_domain, U.h_domain, U.k_domain);
    
    % Calcula o consumo para cada ponto do grid
    [U.Consumption, U.Production]= Consumption(U.k, U.k1, U.h, econom_param, z);
    
    % caso o consumo seja negativo imponho consumo zero.
    U.Consumption(U.Consumption<0) = 0;
    
    % Calcula a utilidade associada
    U.Value = ((U.Consumption .^g .* (1-U.h).^(1-g) ).^(1-u) )/(1-u);
    
end %end of function Utility
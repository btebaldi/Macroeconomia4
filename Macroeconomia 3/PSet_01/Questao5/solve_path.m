function out = solve_path(k_guess, param_economy, param_conditions)
%param_economy = [A, n0, alpha, delta, ga, gn, beta, gamma, open];
%param_conditions=[k_0, k_ss];
% alpha =param_economy(3);
% delta=param_economy(4);
% ga=param_economy(5);
% gn=param_economy(6);
% beta=param_economy(7);
% gamma=param_economy(8);
open = param_economy(9);
k_ss = param_conditions(2);
if (open == 0)
    % se a economia e fechada ele calcula a trajetoria de equilibrio

    % Definindo opcoes de otimizacao
    options=optimoptions('fsolve','Display','off');
    k_solution=fsolve(@(z)Conditions(z,param_economy,param_conditions),k_guess,options);
else
    % se a economia e aberta entao ela vai direto para o k_ss
    k_solution = ones(size(k_guess))*k_ss;
end
out=k_solution;
end % end of function
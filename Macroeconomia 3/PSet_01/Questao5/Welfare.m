function out=Welfare(c, param_economy, param_conditions)
%param_economy = [A, n0, alpha, delta, ga, gn, beta, gamma, open];
%param_conditions=[k_0, k_ss];
% A =param_economy(1);
n_0 =param_economy(2);
alpha =param_economy(3);
% delta=param_economy(4);
ga=param_economy(5);
gn=param_economy(6);
beta=param_economy(7);
% gamma=param_economy(8);
open = param_economy(9);
k_0=param_conditions(1);
k_ss=param_conditions(2);

c_0 = (ga/beta - gn*ga)*k_0 + (1-alpha)*(k_ss^alpha);
if open
    out = n_0*(1/(1 - gn*beta))*log(c_0);
else
    % inicializa utilidade em t
    u_t = 0;
    for t= 1:numel(c)
        u_t = u_t + (beta*gn)^t*log(c(t));
    end
    
    % Calcula a soma infinita
    out = u_t + (beta*gn)^(numel(c))*(1/(1 - beta*gn))*(log(consumption(k_ss, k_ss, param_economy)));
    
end

end %end of function
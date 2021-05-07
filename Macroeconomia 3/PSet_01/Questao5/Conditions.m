function out = Conditions(k_guess,param_economy,param_conditions)
%param_economy = [A, n0, alpha, delta, ga, gn, beta, gamma, open];
%param_conditions=[k_0, k_ss];
alpha =param_economy(3);
delta=param_economy(4);
ga=param_economy(5);
% gn=param_economy(6);
beta=param_economy(7);
% gamma=param_economy(8);
k_0=param_conditions(1);
k_ss=param_conditions(2);

% Definicao das condicoes de contorno

% define o numero de periodos
T = numel(k_guess);

% Sao T periodos +3 (inicial e final e final)
k = nan(1,T+3);

% Leitura das variaveis endogeas (definidas pelo sistema)
% Dos T periodos
for i=1:T
    k(i+1)=k_guess(i);
end

% No primeiro periodo o sistema esta nos pontos iniciais
k(1)=k_0;

% No ultimo periodo o sistema deve estar em equilibrio.
% Logo as variaveis endogenas devem ser iguais a do steady state
k(T+2)=k_ss;
k(T+3)=k_ss;

% Inicializacao dos output's
% Temos T+1 output's pois o ultimo periodo nao tem pois o sys já esta em SS
out = nan(1,T);
for t=2:T+1
    
    rhs = (beta/ga)*(1-delta + alpha*k(t+1)^(alpha-1));
    lhs_u = consumption(k(t),k(t+1), param_economy);
    lhs_l = consumption(k(t-1),k(t), param_economy);
    out(t-1) = (lhs_u /lhs_l)  - rhs;
end
% out
end % end of function
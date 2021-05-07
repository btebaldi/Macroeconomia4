clear all
clc
%Variaveis Iniciais
A = 1;
n0 = 1;
alpha = 0.3;
delta = 0.06;
ga = 1.012;
gn = 1.0074;
beta = 0.96;
gamma = 1;

open = 0;
T=100;
% Computes steady state ktilde
k_ss = (alpha/((ga/beta) + delta - 1))^(1/(1-alpha));

r_star = (ga^gamma)/(beta);


%Inicializa o grid de analise
grid_spaces = linspace(0.01, 1.6, 100);

%inicializa o vetor de resltado
mu = nan(size(grid_spaces));

for ncount=1:numel(grid_spaces)
    grid = grid_spaces(ncount);
    
    % define o ponto inicial
    k_0 = grid*k_ss;
    
    % Definicao da trajetoria inicial
    k_guess = linspace(k_0, k_ss, 102);
    k_guess = k_guess(2:end-1);
    
    % Definido parametros de condicoes iniciais e finais
    param_conditions=[k_0, k_ss];
    param_economy = [A, n0, alpha, delta, ga, gn, beta, gamma, open];
    
    % resolve o modelo dado a economia
    k_optimal = solve_path(k_guess, param_economy, param_conditions);
    
%     plot(k_optimal);
    % maldito vetor estendido
    k_optimal = [k_0, k_optimal, k_ss, k_ss];
    
    % calcula c otimo
    c_optimal  = nan(1,numel(k_optimal)-1);
    for i=1:numel(k_optimal)-1
        c_optimal(i)  = consumption(k_optimal(i),k_optimal(i+1),param_economy);
    end
    % calcula wellfare
    welf_aut = Welfare(c_optimal, param_economy, param_conditions);
    
    % Troco sistema para economia aberta
    param_economy = [A, n0, alpha, delta, ga, gn, beta, gamma, 1];
    
    % resolve o modelo dado a economia
    k_optimal = solve_path(k_guess, param_economy, param_conditions);
    
    % maldito vetor estendido
    k_optimal = [k_0, k_optimal, k_ss, k_ss];
%     plot(k_optimal)
    % calcula c otimo
    c_optimal  = nan(1,numel(k_optimal)-1);
    for i=1:numel(k_optimal)-1
        c_optimal(i)  = consumption(k_optimal(i),k_optimal(i+1),param_economy);
    end
    % calcula wellfare
    welf_int = Welfare(c_optimal, param_economy, param_conditions);
    
    % definicao do paper
    mu(ncount)= exp((1-gn*beta)*(welf_int - welf_aut))-1; 
end

plot(grid_spaces, mu)

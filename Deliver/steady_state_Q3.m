% Funcao que calcula o steady state
% Alunos: Bruno Tebaldi Q Barbosa / Matheus Melo
function [vecss, SteadyState] = steady_state_Q3(parameters)
%parameters
sigma = parameters(1);
varphi = parameters(2);
B = parameters(3); 
theta = parameters(4);
beta = parameters(5); 
delta = parameters(6); 
rho_a = parameters(7); 
sigma_a = parameters(8); 

%start to solve the steady state

Ass = 1; % No steady state Total Factor Productivity is stable A=1
Rss = 1/beta - (1-delta); % Juros do emprestimo do capital
Hss = (1-theta)/(B*(1-delta*(theta/Rss)) + (1-theta)); % Labor (total de horas???)
Kss = Hss * (theta/Rss)^(1/(1-theta)); % Capital
Iss = delta * Kss; % Investimento
Wss = (1-theta)*(Kss/Hss)^theta; % Salario
Yss = Ass * Kss^theta * Hss^(1-theta); % Produto
% Css = (kss_hss)^theta - delta*kss;
Css = Yss - Iss; % Consumo


%steady state vector
vecss = [Ass, Rss, Hss, Kss, Iss, Wss, Yss, Css];

%struct steady vector
SteadyState = struct();

SteadyState.A = Ass;
SteadyState.Rss = Rss;
SteadyState.Hss = Hss; 
SteadyState.Kss = Kss;
SteadyState.Iss = Iss;
SteadyState.Wss = Wss;
SteadyState.Yss = Yss;
SteadyState.Css = Css;
end % Fim function [vecss, SteadyState] = steady_state_3(parameters)
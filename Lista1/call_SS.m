% Chama a funcao que calcula o steady state
% Alunos: 
% BRUNA MIRELLE DE JESUS DA SILVA
% BRUNO TEBALDI DE QUEIROZ BARBOSA 
% MATHEUS ANTHONY DE MELO
clear;
parameters = [1 1 1.72 0.36 0.99 0.025 0.95 0.01];

[vecss, SteadyState] = steady_state_Q3(parameters);

disp(vecss);
disp(SteadyState);
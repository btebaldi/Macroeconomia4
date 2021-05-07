%% Limpeza de variaveis
clear all
clc
%% Setup Inicial
clc
%parametros do sistema
beta=0.96;
delta=0.1;
gamma=0.02;
alpha=0.4;
theta=1;
eta=0;
%parametros do governo
tau_c=0.17;
tau_h=0.27;
tau_k=0.15;

% numero de periodos analisados (grid)
T=100;      

param_sys = [beta,delta,gamma,alpha,theta,eta];
param_gov = [tau_c,tau_h,tau_k];

% definicao de funcao salario e funcao juros
w_t=@(h,k)((1-alpha)*(k/h)^alpha);
r_t=@(h,k)(alpha*(h/k)^(1-alpha));

% calculo do steady state
[h_ss,c_ss,k_ss,g_ss,y_ss,i_ss] = CalculoSteadyState(param_sys, param_gov, w_t, r_t);

% definicao do ponto inicial
h_0 = 0.8*h_ss;
c_0 = 0.8*c_ss;
k_0 = 0.8*k_ss;
g_0 = 0.8*g_ss;

% defino o vetor de variaveis iniciais e finais
initial_state=[k_0, h_0];
final_state = [k_ss, h_ss];

% calculo a trajetoria de equilibrio
[k,h] = CalculaTrajetoriaEquilibrio(initial_state, final_state, T, param_sys, param_gov);

% Calculo y, c, g e i
[y,c,g,i] = Calculo_YCGI(k,h, param_sys, param_gov);

% imprime os graficos
Data=[k,h,y,c,g,i];
Legenda={'Capital', 'Labor', 'Output', 'Consumption', 'Gov', 'Invest'};
PlotStuff(Data, Legenda);

%% Choque em 

% tau_c=0.17;
% tau_h=0.27;
tau_k_new = 0.02;

% Definido parametros

% defino um chute inicial para o novo valor de tau_h
tau_h_new = 0.5;

% Definindo opcoes de otimizacao
options=optimoptions('fsolve','Display','iter');

% otimiza tau_h_new, a funcao de variacao do gasto do governo de maneira que a
% variacao seja zero.
tau_h_new=fsolve(@(tau_h_new)VariacaoGss(tau_h_new, tau_k_new, param_sys, param_gov, w_t, r_t, g_ss),tau_h_new ,options);

% cria o vetor de novos parametros do governo
param_gov_new =[tau_c,tau_h_new,tau_k_new];

% calculo novo steady state
[h_ss_new,c_ss_new,k_ss_new,g_ss_new,y_ss_new,i_ss_new] = CalculoSteadyState(param_sys, param_gov_new, w_t, r_t);

% Definido parametros de condicoes iniciais e finais
% neste caso nosso ponto de saida eh o steady state anterior e o final sera
% o novo steady state calculado
initial_state=[k_ss, h_ss];
final_state = [k_ss_new, h_ss_new];

% calculo a trajetoria de equilibrio
[k_new,h_new] = CalculaTrajetoriaEquilibrio(initial_state, final_state, T, param_sys, param_gov_new);

% Calculo y, c, g e i
[y_new, c_new, g_new, i_new] = Calculo_YCGI(k_new, h_new, param_sys, param_gov_new);

% monto a sequancia antiga de equilibrio junto com a nova
k_total = [k;k_new];
h_total = [h;h_new];
y_total = [y;y_new];
c_total = [c;c_new];
g_total = [g;g_new];
i_total = [i;i_new];

% imprime os graficos
Data=[k_total, h_total, y_total, c_total, g_total, i_total];
Legenda={'Capital', 'Labor', 'Output', 'Consumption', 'Gov', 'Invest'};
PlotStuff(Data, Legenda);




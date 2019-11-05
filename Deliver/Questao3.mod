/*
 * MACRO 4
 * Bruno Tebaldi Q Barbosa e Matheus Melo
 */


%Variables 
var y k h i c r w A;
varexo eps;

%Parameters
parameters B theta beta delta rho_a sigma_a; 

B = 1.72;
theta = 0.36;
beta = 0.99;
delta = 0.025;
rho_a = 0.95;
sigma_a = 0.01;

sigma = 1;
varphi =1;

model;
(1/c) = beta*(1/c(+1))*(1+r(+1)-delta);           % euler equation
B*c/(1-h) = w;                                    % trade off consumo e lazer
y = i + c;                                        % restrição da economia
y = A*((k(-1))^theta)*((h)^(1-theta));            % função de produção
w = A*(1-theta)*((k(-1))^(theta))*(h)^(-theta);   % equação de salário
r = A*(theta)*((k(-1))^(theta-1))*(h)^(1-theta);  % equação de juros
i = k - (1-delta)*k(-1);                          % movimento do investimento
log(A) = rho_a*log(A(-1)) - eps;                  % movimento da produtividade
end;

%Initial Values: Steady State Values
initval;
A = 1;
r = 0.0351;
h = 0.3335;
k = 12.6698;
i = 0.3167;
w = 2.3706;
y = 1.2353;
c = 0.9186;
end;

steady;
check;

shocks;
var eps = sigma^2;
end;

stoch_simul(periods=2100, irf=25, order=1);
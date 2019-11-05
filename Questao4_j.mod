/*
 * Exercicio 4 da lista 1 de Macro 4
 * Bruna Mirelle
 * Bruno Tebaldi Q. Barbosa
 * Matheus A. Melo 
 */
 
% Variaveis
var
y         // produto
c         // consumo
r         // juros real
w         // salario real (W/P)
n         // horas trabalhadas
m         // oferta real de moeda (M/P)
i         // juros nominal
pi        // inflacao
a         // tecnologia
nu        // processo de choque de politica monetaria
;

% Variaveis exogenas
varexo ea em;

parameters sigma rho varphi alpha beta eta phi_pi rho_m rho_a sigma_a sigma_m;

% calibracao
alpha   = 0.25;
beta    = 0.99;
sigma   = 1;
varphi  = 5;
eta     = 3.77;
phi_pi  = 1.5;
rho_m   = 0.5;
rho_a   = 0.9;
sigma_a = 0.01;
sigma_m =  0.01;



% Condicoes de primeira Ordem (FOC)

model(linear);
% Eq de Euller #1
c = c(+1) - (1/sigma)*(r);

% Eq de Fisher   #2
r = i -pi(+1);

% Oferta de trabalho  #3
w = sigma*c + varphi*n;

% Restricao de Recursos #4
y = c;

% Funcao de Producao  #5
y = a + (1-alpha)*n;

% Demanda por trabalho  #6
w = a - alpha*n;

% Demanda por moeda  #7
m = y - eta*i;

% Regra de Politica Monetaria #8
i = phi_pi*pi + nu;

% Choque de tecnologia #9
a = rho_a*a(-1) - ea;

% Choque de Politica Monetaria  #10
nu = rho_m*nu(-1) + em;

end;

% define shock variances
shocks;
var ea = sigma_a^2;
var em = sigma_m^2;
end;

steady;
check;

stoch_simul(order = 1,irf=30);







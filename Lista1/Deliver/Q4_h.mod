/*
 * Exercicio 4 da lista 1 de Macro 4
 * Bruna Mirelle J. Silva
 * Bruno Tebaldi Q. Barbosa
 * Matheus A. Melo 
 */

% Variaveis
var 
c             //consumo
r             //taxa real de juros
i             //taxa de juros nominal
pi            //inflacao
n             //horas trabalhadas
w             //salario real (W/P)
y             //produto
a             //tecnologia
m             //oferta real de moeda (M/P)
nu           //processo de choque de politica monetaria
;

% Variaveis exogenas
varexo ea em;

% Parametros
parameters sigma beta varphi alpha  phi_pi eta rho_a rho_nu y_ss n_ss c_ss w_ss r_ss pi_ss a_ss m_ss nu_ss;

% calibracao
sigma   = 1;
beta    = 0.99;
varphi  = 5;
alpha   = 0.25;
phi_pi  = 1.5;
eta     = 3.77;
rho_a   = 0.9;
rho_nu  = 0.5;

% calibrated parameters steady state
r_ss = 1/beta;
n_ss = (1-alpha)^( 1/varphi + alpha + sigma*(1-alpha)) ;
c_ss = n_ss^(1-alpha);
y_ss = c_ss;
w_ss =  exp(c_ss)^sigma*exp(n_ss)^varphi;
pi_ss = 0;
a_ss = 1;
m_ss = exp(y_ss)*exp(r_ss)^eta;
nu_ss = 1;
i_ss = r_ss;

model;
% Eq. de Euller
exp(c)^(-sigma) = beta*( exp(c(+1))^(-sigma) )*( exp(r));

% Oferta de Trabalho
( exp(n)^(varphi) )*( exp(c)^(sigma) )  = exp(w);

% Market Clearing
exp(y) = exp(c);

% Funcao de Producao
exp(y) = exp(a)*( exp(n)^(1-alpha) );

% Oferta de trabalho
exp(w) = (1-alpha)*exp(a)*( exp(n)^(-alpha) );

% Demanda por moeda
exp(m) = exp(y)*exp(i)^(-eta);

% Taylor Rule
exp(i) = ( 1/beta )*( exp(pi)^(phi_pi) )*exp(nu);

% Regra de Fisher
exp(r) = exp(i)/exp(pi(+1));

% Choque da tecnologia
log(a) = rho_a*log(a(-1)) + (-1)*ea;

% Choque de politica monetaria
nu = rho_nu*nu(-1) + em;


end;

initval;
r = log(r_ss);
n = log(n_ss);
c = log(c_ss);
y = log(y_ss);
w = log(w_ss);
m = log(m_ss);
pi = pi_ss;
a = a_ss;
nu = log(nu_ss);
i = log(i_ss);
end;

check;
steady;

shocks;
var ea = (0.01)^2;
var em = 0.01;
end; 

stoch_simul(order = 1,irf=40);











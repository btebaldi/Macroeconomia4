/*
 * Exercicio 3 da lista 2 de Macro 4
 * Bruna Mirelle J. Silva
 * Bruno Tebaldi Q. Barbosa
 * Matheus A. Melo 
 */
 
@#define money_grow_rule = 01

// Endogenous Variables
var 
@#if money_grow_rule == 0
Nu
@#endif
A
Pi
Pi_star
R 
r 
N 
Y 
C 
W 
M 
D 
MC 
x_one 
x_two;

// Exogenous Variables
varexo eps_m eps_a;

// Parameters
Parameters alpha epsilon beta sigma phi theta eta rho_a rho_m phi_pi phi_y;

alpha = 1/3;
epsilon = 6;
beta = 0.99;
sigma = 1;
phi = 1;
theta = 2/3;
eta = 4;
rho_a = 0.5;
rho_m = 0.5;
phi_pi = 1.5;
phi_y = 1/8;


// Model
model (linear);
#Y_ss = (((1-alpha)*(epsilon-1)/epsilon)^(1/(sigma*(1-alpha)+phi+alpha)))^(1-alpha);

// I. Real Balances Demand
M = Y - eta*R;

// II. Market Clearing Condition
Y = C;

// III. Optimal Labor Supply
W = N*phi + C*sigma;

// IV. Nominal Interest Rate
R = sigma*(C(+1) - C) + Pi(+1);

// V. Production Function
Y = A + (1- alpha)*N + (alpha - 1)*D;

// VI. Price Dispersion Motion
D = theta*D(-1);

// VII. Inflation Dynamics
Pi_star = (theta/(1 - theta))*Pi;

// VIII. Average Marginal Cost
MC = W + N - Y; 

// IX. Recursive Pricing
Pi_star*(1+((alpha*epsilon)/(1 - alpha))) + x_two = x_one;

// X. Auxiliar 1
x_one = (1 - beta*theta)*(C*(- sigma) + MC + Y) + (beta*theta)*((Pi(+1)+(((epsilon/(1 - alpha)) - 1))) + x_one(+1));       

// XI. Auxiliar 2
x_two = (1 - beta*theta)*(C*(- sigma) + Y) + (beta*theta)*(Pi(+1)*(epsilon - 2) + (x_two(+1)));

// XII. Law of Motion of Tecnology
A = rho_a*A(-1) + eps_a; 

// XIII. Fisher
R = r + Pi(+1);

@#if money_grow_rule == 0
// XIV. Monetary Shock
Nu = rho_m*Nu(-1) - eps_m;

// XV. Taylor
R = (Pi*phi_pi) + ((Y - Y_ss)*(phi_y)) + Nu;
@#else   
// XV. Exogenous Money Supply
M  + Pi = rho_a*M(-1) - eps_m;
@#endif
end;

%----------------------------------------------------------------
%  steady states: all 0 due to linear model
%---------------------------------------------------------------
steady;
check;


%----------------------------------------------------------------
%  define shock variances
%---------------------------------------------------------------
// Shock Block
shocks;
var eps_a = 0.1^2;
var eps_m = 0.1^2;
end;

// Stochastic Simulation;
stoch_simul(irf=25, order=1, periods=100, drop=0, noprint);
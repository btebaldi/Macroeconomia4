/*
 * Exercicio 3 da lista 2 de Macro 4
 * Bruna Mirelle J. Silva
 * Bruno Tebaldi Q. Barbosa
 * Matheus A. Melo 
 */

@#define money_grow_rule = 1

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
model;
#Y_ss = (((1-alpha)*(epsilon-1)/epsilon)^(1/(sigma*(1-alpha)+phi+alpha)))^(1-alpha);


// I. Real Balances Demand (eq. 57)
M = Y*(R^(-eta));

// II. Market Clearing Condition (eq. 59)
Y = C;

// III. Optimal Labor Supply (eq. 54)
W = (N^phi)* (C^sigma);

// IV. Nominal Interest Rate (eq. 55 + 56)
1/R = beta*((C(+1)/C)^(-sigma))*(1/Pi(+1));

// V. Production Function (eq. 58)
Y = A*((N/D)^(1- alpha));

// VI. Price Dispersion Motion (eq. 60)
D = (1- theta)*(Pi_star^(-epsilon/(1-alpha))) + theta*(Pi^(epsilon/(1-alpha)))*D(-1);

// VII. Inflation Dynamics (eq. 61)
1 = theta*(Pi^(epsilon - 1)) + (1 - theta)*(Pi_star^(1 - epsilon));

// VIII. Average Marginal Cost (eq. 62)
MC = (W*N)/((1-alpha)*Y); 

// IX. Recursive Pricing (eq. 63 com problema M esquisito)
(Pi_star^((1+(alpha*epsilon))/(1 - alpha)))*x_two = (epsilon/(epsilon - 1))*x_one;

// X. Auxiliar 1 (eq. 64 com problema +1)
x_one = (C^(- sigma))*MC*Y + (beta*theta)*(Pi(+1)^(((epsilon/(1 - alpha)) - 1)))*x_one(+1);       

// XI. Auxiliar 2 (eq. 65 com problema+1)
x_two = (C^(- sigma))*Y + (beta*theta*Pi(+1)^(epsilon - 2))*(x_two(+1));

// XII. Law of Motion of Tecnology (eq. 66)
log(A) = rho_a*log(A(-1)) - eps_a;

// XIII. Fisher (eq. 67)
R = r*Pi(+1);

@#if money_grow_rule == 0
// XIV. Monetary Shock (eq. 70)
Nu = rho_m*Nu(-1) - eps_m;
    
// XV. Taylor  (eq. 69)
R = ((1/beta)*(Pi^phi_pi))*((Y/Y_ss)^(phi_y))*exp(Nu);
@#else   
// XV. Exogenous Money Supply
log(M) - log(M(-1)) + log(Pi) = rho_a*(log(M(-1)) - log(M(-2)) + log(Pi(-1))) - eps_m;
@#endif
end;

initval;

@#if money_grow_rule == 0
Nu = 1;
@#endif
A = 1;
Pi = 1;
R = 1;
r = 1;
D = 1;
Pi_star = 1;
N = 0.5;
Y =  1;
C =  1;
W =  0.5;
M =  1;
MC = 1;
x_one = 1;
x_two = 1;
end;

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
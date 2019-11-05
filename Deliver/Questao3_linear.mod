/*
 * MACRO 4
 * Bruno Tebaldi Q Barbosa e Matheus Melo
 */

%Variables 
var y k h i c r w A;
varexo eps;

%Parameters
parameters be theta beta delta rho_a sigma kss css hss rss yss iss; 

B = 1.72;
theta = 0.36;
beta = 0.99;
delta = 0.025;
rho_a = 0.95;
sigma = 0.01;
kss = 12.6698;
css = 3.3873;
hss = 0.3335;
rss = 0.0351;
yss = 3.7041;
iss = 0.3167;



model(linear);
c(+1) = c + (1/(rss+(1-delta)))*rss*r(+1); 
r = y - k(-1); 
i(-1) = (1/delta)*(k-(1-delta)*k(-1)); 
w - c = hss/(1-hss)*h; 
w = A + theta*(k(-1) - h); 
y = A + theta*k(-1) + (1-theta)*h; 
y = (iss/yss)*i + (css/yss)*c; 
A = rho_a*A(-1) - eps; 

end;

steady;
check;

shocks;
var eps = sigma^2;
end;

stoch_simul(periods=2100, irf=25, order=1);

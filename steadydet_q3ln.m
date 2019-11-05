function [vecss, SteadyState] = steadydet_q3ln(parameters)
%parameters
sigma1 = parameters(1);
phi = parameters(2);
b = parameters(3);
theta = parameters(4);
beta = parameters(5);
delta = parameters(6);
rho_a = parameters(7);
sigma = parameters(8);

%start to solve the steady state
hss = (1-theta)/(b*(1-delta*(theta/((1/beta)-(1-delta))))+(1-theta)); 
kss = (1-theta)/(b*(1-delta*(theta/((1/beta)-(1-delta))))+(1-theta))*((theta/((1/beta)-(1-delta))))^(1/(1-theta));
kss_hss = kss/hss;
iss = delta*kss;
yss = (kss_hss)^(theta)*hss;
rss = theta*(kss_hss)^(theta-1);
wss = (1-theta)*(kss_hss)^theta;
css = (kss_hss)^theta - delta*kss;
yss = css + iss;

%steady state vector
vecss = [hss, kss, kss_hss, iss, yss, rss, wss, css];

%struct steady vector
SteadyState = struct();

SteadyState.hss = hss;
SteadyState.kss = kss;
SteadyState.kss_hss = kss_hss;
SteadyState.iss = iss;
SteadyState.yss = yss;
SteadyState.rss = rss;
SteadyState.wss = wss;
SteadyState.css = css;
end




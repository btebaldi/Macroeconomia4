function [X, Z, D, E, F] = AuxMatrix(param_sys, param_gov )

beta = param_sys(1);
delta= param_sys(2);
gamma = param_sys(3);
alpha = param_sys(4);
theta = param_sys(5);
eta = param_sys(6);

tau_c= param_gov(1);
tau_h = param_gov(2);
tau_k = param_gov(3);

X = ((alpha*beta*(1-tau_k))/((1+gamma)-beta*(1-delta)))^(1/(1-alpha));
Z = (1-alpha)*X^alpha *(1-tau_h)/(1+tau_c);
D = ((1+eta)*(1+gamma) - (1-delta))*X;
E = X^alpha*(1-tau_h*(1-alpha) -tau_k*alpha);
F = ( D-E -(1+tau_c)*Z/theta);

end % end of functions
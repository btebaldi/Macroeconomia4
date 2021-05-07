%parameters
parameters = [1 1 1.72 0.36 0.99 0.025 0.95 0.01];

[vecss, SteadyState] = steadydet_q3ln(parameters);


hss = parameters(1);
eta = parameters(2);
theta = parameters(3);
beta = parameters(4);
delta = parameters(5);

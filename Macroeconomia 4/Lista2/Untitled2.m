
clear all
alpha= 1/3;
epsilon= 6;
beta = 0.99;
sigma= 1;
phi = 1;
theta = 2/3;
eta = 4;

param = [alpha;
epsilon;
beta ;
sigma;
phi;
theta;
eta 
]
%%
[vecss, SteadyState] = steady_state_3(param);

SteadyState

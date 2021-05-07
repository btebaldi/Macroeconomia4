function [h_ss,c_ss,k_ss,g_ss,y_ss,i_ss] = CalculoSteadyState(param_sys, param_gov, w_t, r_t)

% beta = param_sys(1);
% delta= param_sys(2);
% gamma = param_sys(3);
alpha = param_sys(4);
theta = param_sys(5);
% eta = param_sys(6);

tau_c= param_gov(1);
tau_h = param_gov(2);
tau_k = param_gov(3);

[X, Z, ~, ~, F] = AuxMatrix(param_sys, param_gov );
 
h_ss = -(1+tau_c)*Z/(theta*F);
c_ss = (1-h_ss)*Z/theta;
k_ss = X*h_ss;
g_ss = tau_c*c_ss + tau_h*w_t(h_ss,k_ss)*h_ss + tau_k*r_t(h_ss,k_ss)*k_ss;

y_ss = k_ss^alpha * h_ss^(1-alpha);
i_ss = y_ss - c_ss - g_ss;
end % end of function
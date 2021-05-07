function out = VariacaoGss(tau_h_new, tau_k_new,param_sys, param_gov, w_t, r_t, GSS_OLD)
% x = tau_kn

% Atualizo o parameto
param_gov(1,2) = tau_h_new;
param_gov(1,3) = tau_k_new;

% calculo do steady state
[~,~,~,g_ss,~,~] = CalculoSteadyState(param_sys, param_gov, w_t, r_t);

% calculo a variacao do gasto do governo
out = - GSS_OLD + g_ss;

end % end of function
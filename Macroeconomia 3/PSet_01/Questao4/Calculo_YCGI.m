function [y,c,g,i] = Calculo_YCGI(k,h, param_sys, param_gov)

% leitura dos parametros do sistema
alpha = param_sys(4);
theta = param_sys(5);

% leitura dos parametros do governo
tau_c= param_gov(1);
tau_h = param_gov(2);
tau_k = param_gov(3);


y = k.^alpha.*h.^(1-alpha);
c = (1-h).*(1-tau_h).*(1-alpha).*k.^(alpha).*h.^(-alpha).*theta.^(-1).*(1+tau_c).^(-1);
g = tau_c*c + tau_h*(1-alpha)*k.^alpha.*h.^(-alpha).*h + tau_k*alpha*k.^(alpha-1).*h.^(1-alpha).*k;
i = y - c - g;

end % end of function
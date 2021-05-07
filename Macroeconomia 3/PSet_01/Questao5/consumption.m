function out = consumption(k,k1, param_economy)
%param_economy = [A, n0, alpha, delta, ga, gn, beta, gamma, open];
%param_conditions=[k_0, k_ss];
alpha =param_economy(3);
delta=param_economy(4);
ga=param_economy(5);
gn=param_economy(6);

out = -gn*ga*k1 + (1-delta + alpha*k^(alpha-1))*k +(1-alpha)*k^alpha;

end % end of function
function eq = SolveLabor(l,params)
a = params(1);
z = params(2);
w = params(3);
r = params(4);

% -u_l/u_c = wz
eq = l - (w*z*l + r*a)^(-1)*(w*z);

end % end of funcction


%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'Q4_h';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('Q4_h.log');
M_.exo_names = 'ea';
M_.exo_names_tex = 'ea';
M_.exo_names_long = 'ea';
M_.exo_names = char(M_.exo_names, 'em');
M_.exo_names_tex = char(M_.exo_names_tex, 'em');
M_.exo_names_long = char(M_.exo_names_long, 'em');
M_.endo_names = 'c';
M_.endo_names_tex = 'c';
M_.endo_names_long = 'c';
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names_long = char(M_.endo_names_long, 'i');
M_.endo_names = char(M_.endo_names, 'pi');
M_.endo_names_tex = char(M_.endo_names_tex, 'pi');
M_.endo_names_long = char(M_.endo_names_long, 'pi');
M_.endo_names = char(M_.endo_names, 'n');
M_.endo_names_tex = char(M_.endo_names_tex, 'n');
M_.endo_names_long = char(M_.endo_names_long, 'n');
M_.endo_names = char(M_.endo_names, 'w');
M_.endo_names_tex = char(M_.endo_names_tex, 'w');
M_.endo_names_long = char(M_.endo_names_long, 'w');
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names_long = char(M_.endo_names_long, 'y');
M_.endo_names = char(M_.endo_names, 'a');
M_.endo_names_tex = char(M_.endo_names_tex, 'a');
M_.endo_names_long = char(M_.endo_names_long, 'a');
M_.endo_names = char(M_.endo_names, 'm');
M_.endo_names_tex = char(M_.endo_names_tex, 'm');
M_.endo_names_long = char(M_.endo_names_long, 'm');
M_.endo_names = char(M_.endo_names, 'nu');
M_.endo_names_tex = char(M_.endo_names_tex, 'nu');
M_.endo_names_long = char(M_.endo_names_long, 'nu');
M_.endo_partitions = struct();
M_.param_names = 'sigma';
M_.param_names_tex = 'sigma';
M_.param_names_long = 'sigma';
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'varphi');
M_.param_names_tex = char(M_.param_names_tex, 'varphi');
M_.param_names_long = char(M_.param_names_long, 'varphi');
M_.param_names = char(M_.param_names, 'alpha');
M_.param_names_tex = char(M_.param_names_tex, 'alpha');
M_.param_names_long = char(M_.param_names_long, 'alpha');
M_.param_names = char(M_.param_names, 'phi_pi');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_pi');
M_.param_names_long = char(M_.param_names_long, 'phi_pi');
M_.param_names = char(M_.param_names, 'eta');
M_.param_names_tex = char(M_.param_names_tex, 'eta');
M_.param_names_long = char(M_.param_names_long, 'eta');
M_.param_names = char(M_.param_names, 'rho_a');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_a');
M_.param_names_long = char(M_.param_names_long, 'rho_a');
M_.param_names = char(M_.param_names, 'rho_nu');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_nu');
M_.param_names_long = char(M_.param_names_long, 'rho_nu');
M_.param_names = char(M_.param_names, 'y_ss');
M_.param_names_tex = char(M_.param_names_tex, 'y\_ss');
M_.param_names_long = char(M_.param_names_long, 'y_ss');
M_.param_names = char(M_.param_names, 'n_ss');
M_.param_names_tex = char(M_.param_names_tex, 'n\_ss');
M_.param_names_long = char(M_.param_names_long, 'n_ss');
M_.param_names = char(M_.param_names, 'c_ss');
M_.param_names_tex = char(M_.param_names_tex, 'c\_ss');
M_.param_names_long = char(M_.param_names_long, 'c_ss');
M_.param_names = char(M_.param_names, 'w_ss');
M_.param_names_tex = char(M_.param_names_tex, 'w\_ss');
M_.param_names_long = char(M_.param_names_long, 'w_ss');
M_.param_names = char(M_.param_names, 'r_ss');
M_.param_names_tex = char(M_.param_names_tex, 'r\_ss');
M_.param_names_long = char(M_.param_names_long, 'r_ss');
M_.param_names = char(M_.param_names, 'pi_ss');
M_.param_names_tex = char(M_.param_names_tex, 'pi\_ss');
M_.param_names_long = char(M_.param_names_long, 'pi_ss');
M_.param_names = char(M_.param_names, 'a_ss');
M_.param_names_tex = char(M_.param_names_tex, 'a\_ss');
M_.param_names_long = char(M_.param_names_long, 'a_ss');
M_.param_names = char(M_.param_names, 'm_ss');
M_.param_names_tex = char(M_.param_names_tex, 'm\_ss');
M_.param_names_long = char(M_.param_names_long, 'm_ss');
M_.param_names = char(M_.param_names, 'nu_ss');
M_.param_names_tex = char(M_.param_names_tex, 'nu\_ss');
M_.param_names_long = char(M_.param_names_long, 'nu_ss');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 10;
M_.param_nbr = 17;
M_.orig_endo_nbr = 10;
M_.aux_vars = [];
M_.Sigma_e = zeros(2, 2);
M_.Correlation_matrix = eye(2, 2);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('Q4_h_static');
erase_compiled_function('Q4_h_dynamic');
M_.orig_eq_nbr = 10;
M_.eq_nbr = 10;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 3 13;
 0 4 0;
 0 5 0;
 0 6 14;
 0 7 0;
 0 8 0;
 0 9 0;
 1 10 0;
 0 11 0;
 2 12 0;]';
M_.nstatic = 6;
M_.nfwrd   = 2;
M_.npred   = 2;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 2;
M_.ndynamic   = 4;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(10, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(17, 1);
M_.NNZDerivatives = [29; -1; -1];
M_.params( 1 ) = 1;
sigma = M_.params( 1 );
M_.params( 2 ) = 0.99;
beta = M_.params( 2 );
M_.params( 3 ) = 5;
varphi = M_.params( 3 );
M_.params( 4 ) = 0.25;
alpha = M_.params( 4 );
M_.params( 5 ) = 1.5;
phi_pi = M_.params( 5 );
M_.params( 6 ) = 3.77;
eta = M_.params( 6 );
M_.params( 7 ) = 0.9;
rho_a = M_.params( 7 );
M_.params( 8 ) = 0.5;
rho_nu = M_.params( 8 );
M_.params( 13 ) = 1/M_.params(2);
r_ss = M_.params( 13 );
M_.params( 10 ) = (1-M_.params(4))^(M_.params(4)+1/M_.params(3)+(1-M_.params(4))*M_.params(1));
n_ss = M_.params( 10 );
M_.params( 11 ) = M_.params(10)^(1-M_.params(4));
c_ss = M_.params( 11 );
M_.params( 9 ) = M_.params(11);
y_ss = M_.params( 9 );
M_.params( 12 ) = exp(M_.params(11))^M_.params(1)*exp(M_.params(10))^M_.params(3);
w_ss = M_.params( 12 );
M_.params( 14 ) = 0;
pi_ss = M_.params( 14 );
M_.params( 15 ) = 1;
a_ss = M_.params( 15 );
M_.params( 16 ) = exp(M_.params(9))*exp(M_.params(13))^M_.params(6);
m_ss = M_.params( 16 );
M_.params( 17 ) = 1;
nu_ss = M_.params( 17 );
i_ss = r_ss;
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 2 ) = log(M_.params(13));
oo_.steady_state( 5 ) = log(M_.params(10));
oo_.steady_state( 1 ) = log(M_.params(11));
oo_.steady_state( 7 ) = log(M_.params(9));
oo_.steady_state( 6 ) = log(M_.params(12));
oo_.steady_state( 9 ) = log(M_.params(16));
oo_.steady_state( 4 ) = M_.params(14);
oo_.steady_state( 8 ) = M_.params(15);
oo_.steady_state( 10 ) = log(M_.params(17));
oo_.steady_state( 3 ) = log(i_ss);
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
oo_.dr.eigval = check(M_,options_,oo_);
steady;
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = 0.0001;
M_.Sigma_e(2, 2) = 0.01;
options_.irf = 40;
options_.order = 1;
var_list_ = char();
info = stoch_simul(var_list_);
save('Q4_h_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('Q4_h_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('Q4_h_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('Q4_h_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('Q4_h_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('Q4_h_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('Q4_h_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off

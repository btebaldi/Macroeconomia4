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
M_.fname = 'Q3_Itens_bcd';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('Q3_Itens_bcd.log');
M_.exo_names = 'eps_m';
M_.exo_names_tex = 'eps\_m';
M_.exo_names_long = 'eps_m';
M_.exo_names = char(M_.exo_names, 'eps_a');
M_.exo_names_tex = char(M_.exo_names_tex, 'eps\_a');
M_.exo_names_long = char(M_.exo_names_long, 'eps_a');
M_.endo_names = 'A';
M_.endo_names_tex = 'A';
M_.endo_names_long = 'A';
M_.endo_names = char(M_.endo_names, 'Pi');
M_.endo_names_tex = char(M_.endo_names_tex, 'Pi');
M_.endo_names_long = char(M_.endo_names_long, 'Pi');
M_.endo_names = char(M_.endo_names, 'Pi_star');
M_.endo_names_tex = char(M_.endo_names_tex, 'Pi\_star');
M_.endo_names_long = char(M_.endo_names_long, 'Pi_star');
M_.endo_names = char(M_.endo_names, 'R');
M_.endo_names_tex = char(M_.endo_names_tex, 'R');
M_.endo_names_long = char(M_.endo_names_long, 'R');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'N');
M_.endo_names_tex = char(M_.endo_names_tex, 'N');
M_.endo_names_long = char(M_.endo_names_long, 'N');
M_.endo_names = char(M_.endo_names, 'Y');
M_.endo_names_tex = char(M_.endo_names_tex, 'Y');
M_.endo_names_long = char(M_.endo_names_long, 'Y');
M_.endo_names = char(M_.endo_names, 'C');
M_.endo_names_tex = char(M_.endo_names_tex, 'C');
M_.endo_names_long = char(M_.endo_names_long, 'C');
M_.endo_names = char(M_.endo_names, 'W');
M_.endo_names_tex = char(M_.endo_names_tex, 'W');
M_.endo_names_long = char(M_.endo_names_long, 'W');
M_.endo_names = char(M_.endo_names, 'M');
M_.endo_names_tex = char(M_.endo_names_tex, 'M');
M_.endo_names_long = char(M_.endo_names_long, 'M');
M_.endo_names = char(M_.endo_names, 'D');
M_.endo_names_tex = char(M_.endo_names_tex, 'D');
M_.endo_names_long = char(M_.endo_names_long, 'D');
M_.endo_names = char(M_.endo_names, 'MC');
M_.endo_names_tex = char(M_.endo_names_tex, 'MC');
M_.endo_names_long = char(M_.endo_names_long, 'MC');
M_.endo_names = char(M_.endo_names, 'x_one');
M_.endo_names_tex = char(M_.endo_names_tex, 'x\_one');
M_.endo_names_long = char(M_.endo_names_long, 'x_one');
M_.endo_names = char(M_.endo_names, 'x_two');
M_.endo_names_tex = char(M_.endo_names_tex, 'x\_two');
M_.endo_names_long = char(M_.endo_names_long, 'x_two');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_9_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_9\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_9_1');
M_.endo_partitions = struct();
M_.param_names = 'alpha';
M_.param_names_tex = 'alpha';
M_.param_names_long = 'alpha';
M_.param_names = char(M_.param_names, 'epsilon');
M_.param_names_tex = char(M_.param_names_tex, 'epsilon');
M_.param_names_long = char(M_.param_names_long, 'epsilon');
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names_long = char(M_.param_names_long, 'sigma');
M_.param_names = char(M_.param_names, 'phi');
M_.param_names_tex = char(M_.param_names_tex, 'phi');
M_.param_names_long = char(M_.param_names_long, 'phi');
M_.param_names = char(M_.param_names, 'theta');
M_.param_names_tex = char(M_.param_names_tex, 'theta');
M_.param_names_long = char(M_.param_names_long, 'theta');
M_.param_names = char(M_.param_names, 'eta');
M_.param_names_tex = char(M_.param_names_tex, 'eta');
M_.param_names_long = char(M_.param_names_long, 'eta');
M_.param_names = char(M_.param_names, 'rho_a');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_a');
M_.param_names_long = char(M_.param_names_long, 'rho_a');
M_.param_names = char(M_.param_names, 'rho_m');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_m');
M_.param_names_long = char(M_.param_names_long, 'rho_m');
M_.param_names = char(M_.param_names, 'phi_pi');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_pi');
M_.param_names_long = char(M_.param_names_long, 'phi_pi');
M_.param_names = char(M_.param_names, 'phi_y');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_y');
M_.param_names_long = char(M_.param_names_long, 'phi_y');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 15;
M_.param_nbr = 11;
M_.orig_endo_nbr = 14;
M_.aux_vars(1).endo_index = 15;
M_.aux_vars(1).type = 1;
M_.aux_vars(1).orig_index = 10;
M_.aux_vars(1).orig_lead_lag = -1;
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
erase_compiled_function('Q3_Itens_bcd_static');
erase_compiled_function('Q3_Itens_bcd_dynamic');
M_.orig_eq_nbr = 14;
M_.eq_nbr = 15;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 1 6 0;
 2 7 21;
 0 8 0;
 0 9 0;
 0 10 0;
 0 11 0;
 0 12 0;
 0 13 22;
 0 14 0;
 3 15 0;
 4 16 0;
 0 17 0;
 0 18 23;
 0 19 24;
 5 20 0;]';
M_.nstatic = 7;
M_.nfwrd   = 3;
M_.npred   = 4;
M_.nboth   = 1;
M_.nsfwrd   = 4;
M_.nspred   = 5;
M_.ndynamic   = 8;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(15, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(11, 1);
M_.NNZDerivatives = [54; -1; -1];
M_.params( 1 ) = 0.3333333333333333;
alpha = M_.params( 1 );
M_.params( 2 ) = 6;
epsilon = M_.params( 2 );
M_.params( 3 ) = 0.99;
beta = M_.params( 3 );
M_.params( 4 ) = 1;
sigma = M_.params( 4 );
M_.params( 5 ) = 1;
phi = M_.params( 5 );
M_.params( 6 ) = 0.6666666666666666;
theta = M_.params( 6 );
M_.params( 7 ) = 4;
eta = M_.params( 7 );
M_.params( 8 ) = 0.5;
rho_a = M_.params( 8 );
M_.params( 9 ) = 0.5;
rho_m = M_.params( 9 );
M_.params( 10 ) = 1.5;
phi_pi = M_.params( 10 );
M_.params( 11 ) = 0.125;
phi_y = M_.params( 11 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 1 ) = 1;
oo_.steady_state( 2 ) = 1;
oo_.steady_state( 4 ) = 1;
oo_.steady_state( 5 ) = 1;
oo_.steady_state( 11 ) = 1;
oo_.steady_state( 3 ) = 1;
oo_.steady_state( 6 ) = 0.5;
oo_.steady_state( 7 ) = 1;
oo_.steady_state( 8 ) = 1;
oo_.steady_state( 9 ) = 0.5;
oo_.steady_state( 10 ) = 1;
oo_.steady_state( 12 ) = 1;
oo_.steady_state( 13 ) = 1;
oo_.steady_state( 14 ) = 1;
oo_.steady_state(15)=oo_.steady_state(10);
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
steady;
oo_.dr.eigval = check(M_,options_,oo_);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = 0.01;
M_.Sigma_e(2, 2) = 0.01;
options_.drop = 0;
options_.irf = 25;
options_.noprint = 1;
options_.order = 1;
options_.periods = 100;
var_list_ = char();
info = stoch_simul(var_list_);
save('Q3_Itens_bcd_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('Q3_Itens_bcd_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('Q3_Itens_bcd_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('Q3_Itens_bcd_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('Q3_Itens_bcd_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('Q3_Itens_bcd_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('Q3_Itens_bcd_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off

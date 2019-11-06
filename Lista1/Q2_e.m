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
M_.fname = 'Q2_e';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('Q2_e.log');
M_.exo_names = 'ez';
M_.exo_names_tex = 'ez';
M_.exo_names_long = 'ez';
M_.endo_names = 'c';
M_.endo_names_tex = 'c';
M_.endo_names_long = 'c';
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names_long = char(M_.endo_names_long, 'y');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names_long = char(M_.endo_names_long, 'i');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names_long = char(M_.endo_names_long, 'z');
M_.endo_names = char(M_.endo_names, 'AUX_ENDO_LAG_4_1');
M_.endo_names_tex = char(M_.endo_names_tex, 'AUX\_ENDO\_LAG\_4\_1');
M_.endo_names_long = char(M_.endo_names_long, 'AUX_ENDO_LAG_4_1');
M_.endo_partitions = struct();
M_.param_names = 'alpha';
M_.param_names_tex = 'alpha';
M_.param_names_long = 'alpha';
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names_long = char(M_.param_names_long, 'sigma');
M_.param_names = char(M_.param_names, 'phi_1');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_1');
M_.param_names_long = char(M_.param_names_long, 'phi_1');
M_.param_names = char(M_.param_names, 'phi_2');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_2');
M_.param_names_long = char(M_.param_names_long, 'phi_2');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 6;
M_.param_nbr = 6;
M_.orig_endo_nbr = 5;
M_.aux_vars(1).endo_index = 6;
M_.aux_vars(1).type = 1;
M_.aux_vars(1).orig_index = 5;
M_.aux_vars(1).orig_lead_lag = -1;
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('Q2_e_static');
erase_compiled_function('Q2_e_dynamic');
M_.orig_eq_nbr = 5;
M_.eq_nbr = 6;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 4 10;
 1 5 0;
 0 6 0;
 0 7 0;
 2 8 11;
 3 9 0;]';
M_.nstatic = 2;
M_.nfwrd   = 1;
M_.npred   = 2;
M_.nboth   = 1;
M_.nsfwrd   = 2;
M_.nspred   = 3;
M_.ndynamic   = 4;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(6, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(6, 1);
M_.NNZDerivatives = [20; -1; -1];
M_.params( 1 ) = 0.3;
alpha = M_.params( 1 );
M_.params( 2 ) = 0.95;
beta = M_.params( 2 );
M_.params( 3 ) = 0.05;
delta = M_.params( 3 );
M_.params( 4 ) = 1;
sigma = M_.params( 4 );
M_.params( 5 ) = 0.94;
phi_1 = M_.params( 5 );
M_.params( 6 ) = 0;
phi_2 = M_.params( 6 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 2 ) = 3;
oo_.steady_state( 1 ) = 0.75;
oo_.steady_state( 5 ) = 0;
oo_.steady_state( 3 ) = 0.5;
oo_.steady_state( 4 ) = 1;
oo_.exo_steady_state( 1 ) = 0;
oo_.steady_state(6)=oo_.steady_state(5);
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
M_.Sigma_e(1, 1) = 0.0001;
options_.irf = 30;
options_.order = 1;
var_list_ = char();
info = stoch_simul(var_list_);
save('Q2_e_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('Q2_e_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('Q2_e_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('Q2_e_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('Q2_e_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('Q2_e_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('Q2_e_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off

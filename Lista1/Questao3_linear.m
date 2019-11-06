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
M_.fname = 'Questao3_linear';
M_.dynare_version = '4.5.7';
oo_.dynare_version = '4.5.7';
options_.dynare_version = '4.5.7';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('Questao3_linear.log');
M_.exo_names = 'eps';
M_.exo_names_tex = 'eps';
M_.exo_names_long = 'eps';
M_.endo_names = 'y';
M_.endo_names_tex = 'y';
M_.endo_names_long = 'y';
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 'h');
M_.endo_names_tex = char(M_.endo_names_tex, 'h');
M_.endo_names_long = char(M_.endo_names_long, 'h');
M_.endo_names = char(M_.endo_names, 'i');
M_.endo_names_tex = char(M_.endo_names_tex, 'i');
M_.endo_names_long = char(M_.endo_names_long, 'i');
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'w');
M_.endo_names_tex = char(M_.endo_names_tex, 'w');
M_.endo_names_long = char(M_.endo_names_long, 'w');
M_.endo_names = char(M_.endo_names, 'A');
M_.endo_names_tex = char(M_.endo_names_tex, 'A');
M_.endo_names_long = char(M_.endo_names_long, 'A');
M_.endo_partitions = struct();
M_.param_names = 'be';
M_.param_names_tex = 'be';
M_.param_names_long = 'be';
M_.param_names = char(M_.param_names, 'theta');
M_.param_names_tex = char(M_.param_names_tex, 'theta');
M_.param_names_long = char(M_.param_names_long, 'theta');
M_.param_names = char(M_.param_names, 'beta');
M_.param_names_tex = char(M_.param_names_tex, 'beta');
M_.param_names_long = char(M_.param_names_long, 'beta');
M_.param_names = char(M_.param_names, 'delta');
M_.param_names_tex = char(M_.param_names_tex, 'delta');
M_.param_names_long = char(M_.param_names_long, 'delta');
M_.param_names = char(M_.param_names, 'rho_a');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_a');
M_.param_names_long = char(M_.param_names_long, 'rho_a');
M_.param_names = char(M_.param_names, 'sigma');
M_.param_names_tex = char(M_.param_names_tex, 'sigma');
M_.param_names_long = char(M_.param_names_long, 'sigma');
M_.param_names = char(M_.param_names, 'kss');
M_.param_names_tex = char(M_.param_names_tex, 'kss');
M_.param_names_long = char(M_.param_names_long, 'kss');
M_.param_names = char(M_.param_names, 'css');
M_.param_names_tex = char(M_.param_names_tex, 'css');
M_.param_names_long = char(M_.param_names_long, 'css');
M_.param_names = char(M_.param_names, 'hss');
M_.param_names_tex = char(M_.param_names_tex, 'hss');
M_.param_names_long = char(M_.param_names_long, 'hss');
M_.param_names = char(M_.param_names, 'rss');
M_.param_names_tex = char(M_.param_names_tex, 'rss');
M_.param_names_long = char(M_.param_names_long, 'rss');
M_.param_names = char(M_.param_names, 'yss');
M_.param_names_tex = char(M_.param_names_tex, 'yss');
M_.param_names_long = char(M_.param_names_long, 'yss');
M_.param_names = char(M_.param_names, 'iss');
M_.param_names_tex = char(M_.param_names_tex, 'iss');
M_.param_names_long = char(M_.param_names_long, 'iss');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 1;
M_.endo_nbr = 8;
M_.param_nbr = 12;
M_.orig_endo_nbr = 8;
M_.aux_vars = [];
M_.Sigma_e = zeros(1, 1);
M_.Correlation_matrix = eye(1, 1);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.linear = 1;
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 1;
erase_compiled_function('Questao3_linear_static');
erase_compiled_function('Questao3_linear_dynamic');
M_.orig_eq_nbr = 8;
M_.eq_nbr = 8;
M_.ramsey_eq_nbr = 0;
M_.set_auxiliary_variables = exist(['./' M_.fname '_set_auxiliary_variables.m'], 'file') == 2;
M_.lead_lag_incidence = [
 0 4 0;
 1 5 0;
 0 6 0;
 2 7 0;
 0 8 12;
 0 9 13;
 0 10 0;
 3 11 0;]';
M_.nstatic = 3;
M_.nfwrd   = 2;
M_.npred   = 3;
M_.nboth   = 0;
M_.nsfwrd   = 2;
M_.nspred   = 3;
M_.ndynamic   = 5;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:1];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(8, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(1, 1);
M_.params = NaN(12, 1);
M_.NNZDerivatives = [26; -1; -1];
B = 1.72;
M_.params( 2 ) = 0.36;
theta = M_.params( 2 );
M_.params( 3 ) = 0.99;
beta = M_.params( 3 );
M_.params( 4 ) = 0.025;
delta = M_.params( 4 );
M_.params( 5 ) = 0.95;
rho_a = M_.params( 5 );
M_.params( 6 ) = 0.01;
sigma = M_.params( 6 );
M_.params( 7 ) = 12.6698;
kss = M_.params( 7 );
M_.params( 8 ) = 3.3873;
css = M_.params( 8 );
M_.params( 9 ) = 0.3335;
hss = M_.params( 9 );
M_.params( 10 ) = 0.0351;
rss = M_.params( 10 );
M_.params( 11 ) = 3.7041;
yss = M_.params( 11 );
M_.params( 12 ) = 0.3167;
iss = M_.params( 12 );
steady;
oo_.dr.eigval = check(M_,options_,oo_);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = M_.params(6)^2;
options_.irf = 25;
options_.order = 1;
options_.periods = 2100;
var_list_ = char();
info = stoch_simul(var_list_);
save('Questao3_linear_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('Questao3_linear_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('Questao3_linear_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('Questao3_linear_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('Questao3_linear_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('Questao3_linear_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('Questao3_linear_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off

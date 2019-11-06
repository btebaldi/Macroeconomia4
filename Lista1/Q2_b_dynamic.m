function [residual, g1, g2, g3] = Q2_b_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(6, 1);
T17 = params(2)*exp(y(10))^(-params(4));
T26 = params(1)*exp(y(11))*exp(y(5))^(params(1)-1);
T29 = T26+1-params(3);
T37 = exp(y(8))*exp(y(1))^params(1);
lhs =exp(y(4))^(-params(4));
rhs =T17*T29;
residual(1)= lhs-rhs;
lhs =exp(y(5));
rhs =T37-exp(y(4))+(1-params(3))*exp(y(1));
residual(2)= lhs-rhs;
lhs =exp(y(6));
rhs =T37;
residual(3)= lhs-rhs;
lhs =exp(y(7));
rhs =exp(y(6))-exp(y(4));
residual(4)= lhs-rhs;
lhs =y(8);
rhs =x(it_, 1)+params(5)*y(2)+params(6)*y(3);
residual(5)= lhs-rhs;
lhs =y(9);
rhs =y(2);
residual(6)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(6, 12);

  %
  % Jacobian matrix
  %

T77 = exp(y(8))*exp(y(1))*getPowerDeriv(exp(y(1)),params(1),1);
  g1(1,4)=exp(y(4))*getPowerDeriv(exp(y(4)),(-params(4)),1);
  g1(1,10)=(-(T29*params(2)*exp(y(10))*getPowerDeriv(exp(y(10)),(-params(4)),1)));
  g1(1,5)=(-(T17*params(1)*exp(y(11))*exp(y(5))*getPowerDeriv(exp(y(5)),params(1)-1,1)));
  g1(1,11)=(-(T17*T26));
  g1(2,4)=exp(y(4));
  g1(2,1)=(-((1-params(3))*exp(y(1))+T77));
  g1(2,5)=exp(y(5));
  g1(2,8)=(-T37);
  g1(3,1)=(-T77);
  g1(3,6)=exp(y(6));
  g1(3,8)=(-T37);
  g1(4,4)=exp(y(4));
  g1(4,6)=(-exp(y(6)));
  g1(4,7)=exp(y(7));
  g1(5,2)=(-params(5));
  g1(5,8)=1;
  g1(5,12)=(-1);
  g1(5,3)=(-params(6));
  g1(6,2)=(-1);
  g1(6,9)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],6,144);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],6,1728);
end
end
end
end

function [residual, g1, g2, g3] = Questao4_j_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(10, 1);
lhs =y(4);
rhs =y(13)-1/params(1)*y(5);
residual(1)= lhs-rhs;
lhs =y(5);
rhs =y(9)-y(14);
residual(2)= lhs-rhs;
lhs =y(6);
rhs =y(4)*params(1)+params(3)*y(7);
residual(3)= lhs-rhs;
lhs =y(3);
rhs =y(4);
residual(4)= lhs-rhs;
lhs =y(3);
rhs =y(11)+y(7)*(1-params(4));
residual(5)= lhs-rhs;
lhs =y(6);
rhs =y(11)-y(7)*params(4);
residual(6)= lhs-rhs;
lhs =y(8);
rhs =y(3)-y(9)*params(6);
residual(7)= lhs-rhs;
lhs =y(9);
rhs =params(7)*y(10)+y(12);
residual(8)= lhs-rhs;
lhs =y(11);
rhs =params(9)*y(1)-x(it_, 1);
residual(9)= lhs-rhs;
lhs =y(12);
rhs =params(8)*y(2)+x(it_, 2);
residual(10)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(10, 16);

  %
  % Jacobian matrix
  %

  g1(1,4)=1;
  g1(1,13)=(-1);
  g1(1,5)=1/params(1);
  g1(2,5)=1;
  g1(2,9)=(-1);
  g1(2,14)=1;
  g1(3,4)=(-params(1));
  g1(3,6)=1;
  g1(3,7)=(-params(3));
  g1(4,3)=1;
  g1(4,4)=(-1);
  g1(5,3)=1;
  g1(5,7)=(-(1-params(4)));
  g1(5,11)=(-1);
  g1(6,6)=1;
  g1(6,7)=params(4);
  g1(6,11)=(-1);
  g1(7,3)=(-1);
  g1(7,8)=1;
  g1(7,9)=params(6);
  g1(8,9)=1;
  g1(8,10)=(-params(7));
  g1(8,12)=(-1);
  g1(9,1)=(-params(9));
  g1(9,11)=1;
  g1(9,15)=1;
  g1(10,2)=(-params(8));
  g1(10,12)=1;
  g1(10,16)=(-1);

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],10,256);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],10,4096);
end
end
end
end

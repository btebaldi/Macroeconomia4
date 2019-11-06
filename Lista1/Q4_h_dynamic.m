function [residual, g1, g2, g3] = Q4_h_dynamic(y, x, params, steady_state, it_)
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
T20 = params(2)*exp(y(13))^(-params(1))*exp(y(4));
T25 = exp(y(7))^params(3);
T26 = exp(y(3))^params(1);
T39 = exp(y(10))*exp(y(7))^(1-params(4));
T44 = exp(y(10))*(1-params(4))*exp(y(7))^(-params(4));
T53 = exp(y(9))*exp(y(5))^(-params(6));
T63 = 1/params(2)*exp(y(6))^params(5)*exp(y(12));
lhs =exp(y(3))^(-params(1));
rhs =T20;
residual(1)= lhs-rhs;
lhs =T25*T26;
rhs =exp(y(8));
residual(2)= lhs-rhs;
lhs =exp(y(9));
rhs =exp(y(3));
residual(3)= lhs-rhs;
lhs =exp(y(9));
rhs =T39;
residual(4)= lhs-rhs;
lhs =exp(y(8));
rhs =T44;
residual(5)= lhs-rhs;
lhs =exp(y(11));
rhs =T53;
residual(6)= lhs-rhs;
lhs =exp(y(5));
rhs =T63;
residual(7)= lhs-rhs;
lhs =exp(y(4));
rhs =exp(y(5))/exp(y(14));
residual(8)= lhs-rhs;
lhs =log(y(10));
rhs =params(7)*log(y(1))-x(it_, 1);
residual(9)= lhs-rhs;
lhs =y(12);
rhs =params(8)*y(2)+x(it_, 2);
residual(10)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(10, 16);

  %
  % Jacobian matrix
  %

  g1(1,3)=exp(y(3))*getPowerDeriv(exp(y(3)),(-params(1)),1);
  g1(1,13)=(-(exp(y(4))*params(2)*exp(y(13))*getPowerDeriv(exp(y(13)),(-params(1)),1)));
  g1(1,4)=(-T20);
  g1(2,3)=T25*exp(y(3))*getPowerDeriv(exp(y(3)),params(1),1);
  g1(2,7)=T26*exp(y(7))*getPowerDeriv(exp(y(7)),params(3),1);
  g1(2,8)=(-exp(y(8)));
  g1(3,3)=(-exp(y(3)));
  g1(3,9)=exp(y(9));
  g1(4,7)=(-(exp(y(10))*exp(y(7))*getPowerDeriv(exp(y(7)),1-params(4),1)));
  g1(4,9)=exp(y(9));
  g1(4,10)=(-T39);
  g1(5,7)=(-(exp(y(10))*(1-params(4))*exp(y(7))*getPowerDeriv(exp(y(7)),(-params(4)),1)));
  g1(5,8)=exp(y(8));
  g1(5,10)=(-T44);
  g1(6,5)=(-(exp(y(9))*exp(y(5))*getPowerDeriv(exp(y(5)),(-params(6)),1)));
  g1(6,9)=(-T53);
  g1(6,11)=exp(y(11));
  g1(7,5)=exp(y(5));
  g1(7,6)=(-(exp(y(12))*1/params(2)*exp(y(6))*getPowerDeriv(exp(y(6)),params(5),1)));
  g1(7,12)=(-T63);
  g1(8,4)=exp(y(4));
  g1(8,5)=(-(exp(y(5))/exp(y(14))));
  g1(8,14)=(-((-(exp(y(5))*exp(y(14))))/(exp(y(14))*exp(y(14)))));
  g1(9,1)=(-(params(7)*1/y(1)));
  g1(9,10)=1/y(10);
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

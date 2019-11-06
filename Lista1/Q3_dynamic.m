function [residual, g1, g2, g3] = Q3_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(8, 1);
T34 = y(1)^params(2);
T37 = y(5)^(1-params(2));
T43 = y(5)^(-params(2));
T49 = y(1)^(params(2)-1);
T50 = y(10)*params(2)*T49;
lhs =1/y(7);
rhs =params(3)*1/y(11)*(1+y(12)-params(4));
residual(1)= lhs-rhs;
lhs =y(7)*params(1)/(1-y(5));
rhs =y(9);
residual(2)= lhs-rhs;
lhs =y(3);
rhs =y(7)+y(6);
residual(3)= lhs-rhs;
lhs =y(3);
rhs =y(10)*T34*T37;
residual(4)= lhs-rhs;
lhs =y(9);
rhs =T34*y(10)*(1-params(2))*T43;
residual(5)= lhs-rhs;
lhs =y(8);
rhs =T37*T50;
residual(6)= lhs-rhs;
lhs =y(6);
rhs =y(4)-y(1)*(1-params(4));
residual(7)= lhs-rhs;
lhs =log(y(10));
rhs =params(5)*log(y(2))-x(it_, 1);
residual(8)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(8, 13);

  %
  % Jacobian matrix
  %

T66 = getPowerDeriv(y(1),params(2),1);
T81 = getPowerDeriv(y(5),1-params(2),1);
  g1(1,7)=(-1)/(y(7)*y(7));
  g1(1,11)=(-((1+y(12)-params(4))*params(3)*(-1)/(y(11)*y(11))));
  g1(1,12)=(-(params(3)*1/y(11)));
  g1(2,5)=y(7)*params(1)/((1-y(5))*(1-y(5)));
  g1(2,7)=params(1)/(1-y(5));
  g1(2,9)=(-1);
  g1(3,3)=1;
  g1(3,6)=(-1);
  g1(3,7)=(-1);
  g1(4,3)=1;
  g1(4,1)=(-(T37*y(10)*T66));
  g1(4,5)=(-(y(10)*T34*T81));
  g1(4,10)=(-(T34*T37));
  g1(5,1)=(-(T43*y(10)*(1-params(2))*T66));
  g1(5,5)=(-(T34*y(10)*(1-params(2))*getPowerDeriv(y(5),(-params(2)),1)));
  g1(5,9)=1;
  g1(5,10)=(-(T43*T34*(1-params(2))));
  g1(6,1)=(-(T37*y(10)*params(2)*getPowerDeriv(y(1),params(2)-1,1)));
  g1(6,5)=(-(T50*T81));
  g1(6,8)=1;
  g1(6,10)=(-(T37*params(2)*T49));
  g1(7,1)=1-params(4);
  g1(7,4)=(-1);
  g1(7,6)=1;
  g1(8,2)=(-(params(5)*1/y(2)));
  g1(8,10)=1/y(10);
  g1(8,13)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],8,169);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],8,2197);
end
end
end
end

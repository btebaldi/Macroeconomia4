function [residual, g1, g2, g3] = Q3_linear_dynamic(y, x, params, steady_state, it_)
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
lhs =y(12);
rhs =y(8)+params(10)*1/(params(10)+1-params(4))*y(13);
residual(1)= lhs-rhs;
lhs =y(9);
rhs =y(4)-y(1);
residual(2)= lhs-rhs;
lhs =y(2);
rhs =1/params(4)*(y(5)-(1-params(4))*y(1));
residual(3)= lhs-rhs;
lhs =y(10)-y(8);
rhs =params(9)/(1-params(9))*y(6);
residual(4)= lhs-rhs;
lhs =y(10);
rhs =y(11)+params(2)*(y(1)-y(6));
residual(5)= lhs-rhs;
lhs =y(4);
rhs =y(11)+y(1)*params(2)+y(6)*(1-params(2));
residual(6)= lhs-rhs;
lhs =y(4);
rhs =params(12)/params(11)*y(7)+y(8)*params(8)/params(11);
residual(7)= lhs-rhs;
lhs =y(11);
rhs =params(5)*y(3)-x(it_, 1);
residual(8)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(8, 14);

  %
  % Jacobian matrix
  %

  g1(1,8)=(-1);
  g1(1,12)=1;
  g1(1,13)=(-(params(10)*1/(params(10)+1-params(4))));
  g1(2,4)=(-1);
  g1(2,1)=1;
  g1(2,9)=1;
  g1(3,1)=(-(1/params(4)*(-(1-params(4)))));
  g1(3,5)=(-(1/params(4)));
  g1(3,2)=1;
  g1(4,6)=(-(params(9)/(1-params(9))));
  g1(4,8)=(-1);
  g1(4,10)=1;
  g1(5,1)=(-params(2));
  g1(5,6)=params(2);
  g1(5,10)=1;
  g1(5,11)=(-1);
  g1(6,4)=1;
  g1(6,1)=(-params(2));
  g1(6,6)=(-(1-params(2)));
  g1(6,11)=(-1);
  g1(7,4)=1;
  g1(7,7)=(-(params(12)/params(11)));
  g1(7,8)=(-(params(8)/params(11)));
  g1(8,3)=(-params(5));
  g1(8,11)=1;
  g1(8,14)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],8,196);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],8,2744);
end
end
end
end

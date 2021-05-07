function [residual, g1, g2, g3] = Q3_Itens_efg_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(14, 1);
lhs =y(13);
rhs =y(10)-params(7)*y(7);
residual(1)= lhs-rhs;
lhs =y(10);
rhs =y(11);
residual(2)= lhs-rhs;
lhs =y(12);
rhs =params(5)*y(9)+params(4)*y(11);
residual(3)= lhs-rhs;
lhs =y(7);
rhs =params(4)*(y(19)-y(11))+y(18);
residual(4)= lhs-rhs;
lhs =y(10);
rhs =y(4)+(1-params(1))*y(9)+(params(1)-1)*y(14);
residual(5)= lhs-rhs;
lhs =y(14);
rhs =params(6)*y(3);
residual(6)= lhs-rhs;
lhs =y(6);
rhs =params(6)/(1-params(6))*y(5);
residual(7)= lhs-rhs;
lhs =y(15);
rhs =y(12)+y(9)-y(10);
residual(8)= lhs-rhs;
lhs =y(6)*(1+params(1)*params(2)/(1-params(1)))+y(17);
rhs =y(16);
residual(9)= lhs-rhs;
lhs =y(16);
rhs =(1-params(6)*params(3))*(y(10)+y(15)+y(11)*(-params(4)))+params(6)*params(3)*(y(18)+params(2)/(1-params(1))-1+y(20));
residual(10)= lhs-rhs;
lhs =y(17);
rhs =(1-params(6)*params(3))*(y(10)+y(11)*(-params(4)))+params(6)*params(3)*(y(18)*(params(2)-2)+y(21));
residual(11)= lhs-rhs;
lhs =y(4);
rhs =params(8)*y(1)+x(it_, 2);
residual(12)= lhs-rhs;
lhs =y(7);
rhs =y(18)+y(8);
residual(13)= lhs-rhs;
lhs =y(13)+y(5);
rhs =params(8)*y(2)-x(it_, 1);
residual(14)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(14, 23);

  %
  % Jacobian matrix
  %

  g1(1,7)=params(7);
  g1(1,10)=(-1);
  g1(1,13)=1;
  g1(2,10)=1;
  g1(2,11)=(-1);
  g1(3,9)=(-params(5));
  g1(3,11)=(-params(4));
  g1(3,12)=1;
  g1(4,18)=(-1);
  g1(4,7)=1;
  g1(4,11)=params(4);
  g1(4,19)=(-params(4));
  g1(5,4)=(-1);
  g1(5,9)=(-(1-params(1)));
  g1(5,10)=1;
  g1(5,14)=(-(params(1)-1));
  g1(6,3)=(-params(6));
  g1(6,14)=1;
  g1(7,5)=(-(params(6)/(1-params(6))));
  g1(7,6)=1;
  g1(8,9)=(-1);
  g1(8,10)=1;
  g1(8,12)=(-1);
  g1(8,15)=1;
  g1(9,6)=1+params(1)*params(2)/(1-params(1));
  g1(9,16)=(-1);
  g1(9,17)=1;
  g1(10,18)=(-(params(6)*params(3)));
  g1(10,10)=(-(1-params(6)*params(3)));
  g1(10,11)=(-((1-params(6)*params(3))*(-params(4))));
  g1(10,15)=(-(1-params(6)*params(3)));
  g1(10,16)=1;
  g1(10,20)=(-(params(6)*params(3)));
  g1(11,18)=(-(params(6)*params(3)*(params(2)-2)));
  g1(11,10)=(-(1-params(6)*params(3)));
  g1(11,11)=(-((1-params(6)*params(3))*(-params(4))));
  g1(11,17)=1;
  g1(11,21)=(-(params(6)*params(3)));
  g1(12,1)=(-params(8));
  g1(12,4)=1;
  g1(12,23)=(-1);
  g1(13,18)=(-1);
  g1(13,7)=1;
  g1(13,8)=(-1);
  g1(14,5)=1;
  g1(14,2)=(-params(8));
  g1(14,13)=1;
  g1(14,22)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],14,529);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],14,12167);
end
end
end
end

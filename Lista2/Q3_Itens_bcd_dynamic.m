function [residual, g1, g2, g3] = Q3_Itens_bcd_dynamic(y, x, params, steady_state, it_)
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

residual = zeros(15, 1);
T27 = y(9)^(-params(7));
T34 = y(11)^params(5);
T35 = y(13)^params(4);
T44 = params(3)*(y(22)/y(13))^(-params(4));
T52 = (y(11)/y(16))^(1-params(1));
T65 = params(6)*y(7)^(params(2)/(1-params(1)));
T85 = y(8)^((1+params(1)*params(2))/(1-params(1)));
T92 = y(13)^(-params(4));
T98 = params(3)*params(6)*y(21)^(params(2)/(1-params(1))-1);
T106 = params(3)*params(6)*y(21)^(params(2)-2);
lhs =y(15);
rhs =y(12)*T27;
residual(1)= lhs-rhs;
lhs =y(12);
rhs =y(13);
residual(2)= lhs-rhs;
lhs =y(14);
rhs =T34*T35;
residual(3)= lhs-rhs;
lhs =1/y(9);
rhs =T44*1/y(21);
residual(4)= lhs-rhs;
lhs =y(12);
rhs =y(6)*T52;
residual(5)= lhs-rhs;
lhs =y(16);
rhs =(1-params(6))*y(8)^((-params(2))/(1-params(1)))+T65*y(4);
residual(6)= lhs-rhs;
lhs =1;
rhs =params(6)*y(7)^(params(2)-1)+(1-params(6))*y(8)^(1-params(2));
residual(7)= lhs-rhs;
lhs =y(17);
rhs =y(14)*y(11)/((1-params(1))*y(12));
residual(8)= lhs-rhs;
lhs =T85*y(19);
rhs =params(2)/(params(2)-1)*y(18);
residual(9)= lhs-rhs;
lhs =y(18);
rhs =y(12)*y(17)*T92+T98*y(23);
residual(10)= lhs-rhs;
lhs =y(19);
rhs =y(12)*T92+T106*y(24);
residual(11)= lhs-rhs;
lhs =log(y(6));
rhs =params(8)*log(y(1))-x(it_, 2);
residual(12)= lhs-rhs;
lhs =y(9);
rhs =y(21)*y(10);
residual(13)= lhs-rhs;
lhs =log(y(15))-log(y(3))+log(y(7));
rhs =params(8)*(log(y(2))+log(y(3))-log(y(5)))-x(it_, 1);
residual(14)= lhs-rhs;
lhs =y(20);
rhs =y(3);
residual(15)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(15, 26);

  %
  % Jacobian matrix
  %

T195 = getPowerDeriv(y(11)/y(16),1-params(1),1);
T215 = getPowerDeriv(y(22)/y(13),(-params(4)),1);
T220 = getPowerDeriv(y(13),(-params(4)),1);
  g1(1,9)=(-(y(12)*getPowerDeriv(y(9),(-params(7)),1)));
  g1(1,12)=(-T27);
  g1(1,15)=1;
  g1(2,12)=1;
  g1(2,13)=(-1);
  g1(3,11)=(-(T35*getPowerDeriv(y(11),params(5),1)));
  g1(3,13)=(-(T34*getPowerDeriv(y(13),params(4),1)));
  g1(3,14)=1;
  g1(4,21)=(-(T44*(-1)/(y(21)*y(21))));
  g1(4,9)=(-1)/(y(9)*y(9));
  g1(4,13)=(-(1/y(21)*params(3)*(-y(22))/(y(13)*y(13))*T215));
  g1(4,22)=(-(1/y(21)*params(3)*T215*1/y(13)));
  g1(5,6)=(-T52);
  g1(5,11)=(-(y(6)*1/y(16)*T195));
  g1(5,12)=1;
  g1(5,16)=(-(y(6)*T195*(-y(11))/(y(16)*y(16))));
  g1(6,7)=(-(y(4)*params(6)*getPowerDeriv(y(7),params(2)/(1-params(1)),1)));
  g1(6,8)=(-((1-params(6))*getPowerDeriv(y(8),(-params(2))/(1-params(1)),1)));
  g1(6,4)=(-T65);
  g1(6,16)=1;
  g1(7,7)=(-(params(6)*getPowerDeriv(y(7),params(2)-1,1)));
  g1(7,8)=(-((1-params(6))*getPowerDeriv(y(8),1-params(2),1)));
  g1(8,11)=(-(y(14)/((1-params(1))*y(12))));
  g1(8,12)=(-((-((1-params(1))*y(14)*y(11)))/((1-params(1))*y(12)*(1-params(1))*y(12))));
  g1(8,14)=(-(y(11)/((1-params(1))*y(12))));
  g1(8,17)=1;
  g1(9,8)=y(19)*getPowerDeriv(y(8),(1+params(1)*params(2))/(1-params(1)),1);
  g1(9,18)=(-(params(2)/(params(2)-1)));
  g1(9,19)=T85;
  g1(10,21)=(-(y(23)*params(3)*params(6)*getPowerDeriv(y(21),params(2)/(1-params(1))-1,1)));
  g1(10,12)=(-(y(17)*T92));
  g1(10,13)=(-(y(12)*y(17)*T220));
  g1(10,17)=(-(y(12)*T92));
  g1(10,18)=1;
  g1(10,23)=(-T98);
  g1(11,21)=(-(y(24)*params(3)*params(6)*getPowerDeriv(y(21),params(2)-2,1)));
  g1(11,12)=(-T92);
  g1(11,13)=(-(y(12)*T220));
  g1(11,19)=1;
  g1(11,24)=(-T106);
  g1(12,1)=(-(params(8)*1/y(1)));
  g1(12,6)=1/y(6);
  g1(12,26)=1;
  g1(13,21)=(-y(10));
  g1(13,9)=1;
  g1(13,10)=(-y(21));
  g1(14,2)=(-(params(8)*1/y(2)));
  g1(14,7)=1/y(7);
  g1(14,3)=(-(1/y(3)))-params(8)*1/y(3);
  g1(14,15)=1/y(15);
  g1(14,25)=1;
  g1(14,5)=(-(params(8)*(-(1/y(5)))));
  g1(15,3)=(-1);
  g1(15,20)=1;

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],15,676);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],15,17576);
end
end
end
end

function [residual, g1, g2, g3] = Q3_Itens_bcd_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations.
%                                          Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g3        [M_.endo_nbr by (M_.endo_nbr)^3] double   Third derivatives matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 15, 1);

%
% Model equations
%

T27 = y(4)^(-params(7));
T34 = y(6)^params(5);
T35 = y(8)^params(4);
T48 = (y(6)/y(11))^(1-params(1));
T60 = params(6)*y(2)^(params(2)/(1-params(1)));
T79 = y(3)^((1+params(1)*params(2))/(1-params(1)));
T86 = y(8)^(-params(4));
T92 = params(3)*params(6)*y(2)^(params(2)/(1-params(1))-1);
T99 = params(3)*params(6)*y(2)^(params(2)-2);
lhs =y(10);
rhs =y(7)*T27;
residual(1)= lhs-rhs;
lhs =y(7);
rhs =y(8);
residual(2)= lhs-rhs;
lhs =y(9);
rhs =T34*T35;
residual(3)= lhs-rhs;
lhs =1/y(4);
rhs =params(3)*1/y(2);
residual(4)= lhs-rhs;
lhs =y(7);
rhs =y(1)*T48;
residual(5)= lhs-rhs;
lhs =y(11);
rhs =(1-params(6))*y(3)^((-params(2))/(1-params(1)))+y(11)*T60;
residual(6)= lhs-rhs;
lhs =1;
rhs =params(6)*y(2)^(params(2)-1)+(1-params(6))*y(3)^(1-params(2));
residual(7)= lhs-rhs;
lhs =y(12);
rhs =y(9)*y(6)/((1-params(1))*y(7));
residual(8)= lhs-rhs;
lhs =T79*y(14);
rhs =params(2)/(params(2)-1)*y(13);
residual(9)= lhs-rhs;
lhs =y(13);
rhs =y(7)*y(12)*T86+y(13)*T92;
residual(10)= lhs-rhs;
lhs =y(14);
rhs =y(7)*T86+y(14)*T99;
residual(11)= lhs-rhs;
lhs =log(y(1));
rhs =log(y(1))*params(8)-x(2);
residual(12)= lhs-rhs;
lhs =y(4);
rhs =y(2)*y(5);
residual(13)= lhs-rhs;
lhs =log(y(2));
rhs =params(8)*log(y(2))-x(1);
residual(14)= lhs-rhs;
lhs =y(15);
rhs =y(10);
residual(15)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(15, 15);

  %
  % Jacobian matrix
  %

T176 = getPowerDeriv(y(6)/y(11),1-params(1),1);
T193 = getPowerDeriv(y(8),(-params(4)),1);
  g1(1,4)=(-(y(7)*getPowerDeriv(y(4),(-params(7)),1)));
  g1(1,7)=(-T27);
  g1(1,10)=1;
  g1(2,7)=1;
  g1(2,8)=(-1);
  g1(3,6)=(-(T35*getPowerDeriv(y(6),params(5),1)));
  g1(3,8)=(-(T34*getPowerDeriv(y(8),params(4),1)));
  g1(3,9)=1;
  g1(4,2)=(-(params(3)*(-1)/(y(2)*y(2))));
  g1(4,4)=(-1)/(y(4)*y(4));
  g1(5,1)=(-T48);
  g1(5,6)=(-(y(1)*1/y(11)*T176));
  g1(5,7)=1;
  g1(5,11)=(-(y(1)*T176*(-y(6))/(y(11)*y(11))));
  g1(6,2)=(-(y(11)*params(6)*getPowerDeriv(y(2),params(2)/(1-params(1)),1)));
  g1(6,3)=(-((1-params(6))*getPowerDeriv(y(3),(-params(2))/(1-params(1)),1)));
  g1(6,11)=1-T60;
  g1(7,2)=(-(params(6)*getPowerDeriv(y(2),params(2)-1,1)));
  g1(7,3)=(-((1-params(6))*getPowerDeriv(y(3),1-params(2),1)));
  g1(8,6)=(-(y(9)/((1-params(1))*y(7))));
  g1(8,7)=(-((-((1-params(1))*y(9)*y(6)))/((1-params(1))*y(7)*(1-params(1))*y(7))));
  g1(8,9)=(-(y(6)/((1-params(1))*y(7))));
  g1(8,12)=1;
  g1(9,3)=y(14)*getPowerDeriv(y(3),(1+params(1)*params(2))/(1-params(1)),1);
  g1(9,13)=(-(params(2)/(params(2)-1)));
  g1(9,14)=T79;
  g1(10,2)=(-(y(13)*params(3)*params(6)*getPowerDeriv(y(2),params(2)/(1-params(1))-1,1)));
  g1(10,7)=(-(y(12)*T86));
  g1(10,8)=(-(y(7)*y(12)*T193));
  g1(10,12)=(-(y(7)*T86));
  g1(10,13)=1-T92;
  g1(11,2)=(-(y(14)*params(3)*params(6)*getPowerDeriv(y(2),params(2)-2,1)));
  g1(11,7)=(-T86);
  g1(11,8)=(-(y(7)*T193));
  g1(11,14)=1-T99;
  g1(12,1)=1/y(1)-params(8)*1/y(1);
  g1(13,2)=(-y(5));
  g1(13,4)=1;
  g1(13,5)=(-y(2));
  g1(14,2)=1/y(2)-1/y(2)*params(8);
  g1(15,10)=(-1);
  g1(15,15)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],15,225);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],15,3375);
end
end
end
end

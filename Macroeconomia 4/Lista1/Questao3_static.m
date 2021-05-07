function [residual, g1, g2, g3] = Questao3_static(y, x, params)
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

residual = zeros( 8, 1);

%
% Model equations
%

T32 = y(2)^params(2);
T35 = y(3)^(1-params(2));
T41 = y(3)^(-params(2));
T46 = y(2)^(params(2)-1);
T47 = y(8)*params(2)*T46;
lhs =1/y(5);
rhs =1/y(5)*params(3)*(1+y(6)-params(4));
residual(1)= lhs-rhs;
lhs =y(5)*params(1)/(1-y(3));
rhs =y(7);
residual(2)= lhs-rhs;
lhs =y(1);
rhs =y(5)+y(4);
residual(3)= lhs-rhs;
lhs =y(1);
rhs =y(8)*T32*T35;
residual(4)= lhs-rhs;
lhs =y(7);
rhs =T32*y(8)*(1-params(2))*T41;
residual(5)= lhs-rhs;
lhs =y(6);
rhs =T35*T47;
residual(6)= lhs-rhs;
lhs =y(4);
rhs =y(2)-y(2)*(1-params(4));
residual(7)= lhs-rhs;
lhs =log(y(8));
rhs =log(y(8))*params(5)-x(1);
residual(8)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(8, 8);

  %
  % Jacobian matrix
  %

T60 = getPowerDeriv(y(2),params(2),1);
T76 = getPowerDeriv(y(3),1-params(2),1);
  g1(1,5)=(-1)/(y(5)*y(5))-(1+y(6)-params(4))*params(3)*(-1)/(y(5)*y(5));
  g1(1,6)=(-(1/y(5)*params(3)));
  g1(2,3)=y(5)*params(1)/((1-y(3))*(1-y(3)));
  g1(2,5)=params(1)/(1-y(3));
  g1(2,7)=(-1);
  g1(3,1)=1;
  g1(3,4)=(-1);
  g1(3,5)=(-1);
  g1(4,1)=1;
  g1(4,2)=(-(T35*y(8)*T60));
  g1(4,3)=(-(y(8)*T32*T76));
  g1(4,8)=(-(T32*T35));
  g1(5,2)=(-(T41*y(8)*(1-params(2))*T60));
  g1(5,3)=(-(T32*y(8)*(1-params(2))*getPowerDeriv(y(3),(-params(2)),1)));
  g1(5,7)=1;
  g1(5,8)=(-(T41*T32*(1-params(2))));
  g1(6,2)=(-(T35*y(8)*params(2)*getPowerDeriv(y(2),params(2)-1,1)));
  g1(6,3)=(-(T47*T76));
  g1(6,6)=1;
  g1(6,8)=(-(T35*params(2)*T46));
  g1(7,2)=(-(1-(1-params(4))));
  g1(7,4)=1;
  g1(8,8)=1/y(8)-params(5)*1/y(8);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],8,64);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],8,512);
end
end
end
end

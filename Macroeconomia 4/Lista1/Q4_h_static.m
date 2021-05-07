function [residual, g1, g2, g3] = Q4_h_static(y, x, params)
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

residual = zeros( 10, 1);

%
% Model equations
%

T12 = exp(y(1))^(-params(1));
T22 = exp(y(5))^params(3);
T23 = exp(y(1))^params(1);
T36 = exp(y(8))*exp(y(5))^(1-params(4));
T41 = exp(y(8))*(1-params(4))*exp(y(5))^(-params(4));
T50 = exp(y(7))*exp(y(3))^(-params(6));
T60 = 1/params(2)*exp(y(4))^params(5)*exp(y(10));
lhs =T12;
rhs =T12*params(2)*exp(y(2));
residual(1)= lhs-rhs;
lhs =T22*T23;
rhs =exp(y(6));
residual(2)= lhs-rhs;
lhs =exp(y(7));
rhs =exp(y(1));
residual(3)= lhs-rhs;
lhs =exp(y(7));
rhs =T36;
residual(4)= lhs-rhs;
lhs =exp(y(6));
rhs =T41;
residual(5)= lhs-rhs;
lhs =exp(y(9));
rhs =T50;
residual(6)= lhs-rhs;
lhs =exp(y(3));
rhs =T60;
residual(7)= lhs-rhs;
lhs =exp(y(2));
rhs =exp(y(3))/exp(y(4));
residual(8)= lhs-rhs;
lhs =log(y(8));
rhs =log(y(8))*params(7)-x(1);
residual(9)= lhs-rhs;
lhs =y(10);
rhs =y(10)*params(8)+x(2);
residual(10)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(10, 10);

  %
  % Jacobian matrix
  %

T76 = exp(y(1))*getPowerDeriv(exp(y(1)),(-params(1)),1);
  g1(1,1)=T76-exp(y(2))*params(2)*T76;
  g1(1,2)=(-(T12*params(2)*exp(y(2))));
  g1(2,1)=T22*exp(y(1))*getPowerDeriv(exp(y(1)),params(1),1);
  g1(2,5)=T23*exp(y(5))*getPowerDeriv(exp(y(5)),params(3),1);
  g1(2,6)=(-exp(y(6)));
  g1(3,1)=(-exp(y(1)));
  g1(3,7)=exp(y(7));
  g1(4,5)=(-(exp(y(8))*exp(y(5))*getPowerDeriv(exp(y(5)),1-params(4),1)));
  g1(4,7)=exp(y(7));
  g1(4,8)=(-T36);
  g1(5,5)=(-(exp(y(8))*(1-params(4))*exp(y(5))*getPowerDeriv(exp(y(5)),(-params(4)),1)));
  g1(5,6)=exp(y(6));
  g1(5,8)=(-T41);
  g1(6,3)=(-(exp(y(7))*exp(y(3))*getPowerDeriv(exp(y(3)),(-params(6)),1)));
  g1(6,7)=(-T50);
  g1(6,9)=exp(y(9));
  g1(7,3)=exp(y(3));
  g1(7,4)=(-(exp(y(10))*1/params(2)*exp(y(4))*getPowerDeriv(exp(y(4)),params(5),1)));
  g1(7,10)=(-T60);
  g1(8,2)=exp(y(2));
  g1(8,3)=(-(exp(y(3))/exp(y(4))));
  g1(8,4)=(-((-(exp(y(3))*exp(y(4))))/(exp(y(4))*exp(y(4)))));
  g1(9,8)=1/y(8)-params(7)*1/y(8);
  g1(10,10)=1-params(8);
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],10,100);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],10,1000);
end
end
end
end

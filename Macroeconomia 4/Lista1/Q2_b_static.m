function [residual, g1, g2, g3] = Q2_b_static(y, x, params)
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

residual = zeros( 6, 1);

%
% Model equations
%

T12 = exp(y(1))^(-params(4));
T23 = params(1)*exp(y(5))*exp(y(2))^(params(1)-1);
T26 = T23+1-params(3);
T30 = exp(y(5))*exp(y(2))^params(1);
lhs =T12;
rhs =T12*params(2)*T26;
residual(1)= lhs-rhs;
lhs =exp(y(2));
rhs =T30-exp(y(1))+exp(y(2))*(1-params(3));
residual(2)= lhs-rhs;
lhs =exp(y(3));
rhs =T30;
residual(3)= lhs-rhs;
lhs =exp(y(4));
rhs =exp(y(3))-exp(y(1));
residual(4)= lhs-rhs;
lhs =y(5);
rhs =x(1)+y(5)*params(5)+y(5)*params(6);
residual(5)= lhs-rhs;
lhs =y(6);
rhs =y(5);
residual(6)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(6, 6);

  %
  % Jacobian matrix
  %

T61 = exp(y(1))*getPowerDeriv(exp(y(1)),(-params(4)),1);
T73 = exp(y(5))*exp(y(2))*getPowerDeriv(exp(y(2)),params(1),1);
  g1(1,1)=T61-T26*params(2)*T61;
  g1(1,2)=(-(T12*params(2)*params(1)*exp(y(5))*exp(y(2))*getPowerDeriv(exp(y(2)),params(1)-1,1)));
  g1(1,5)=(-(T12*params(2)*T23));
  g1(2,1)=exp(y(1));
  g1(2,2)=exp(y(2))-(exp(y(2))*(1-params(3))+T73);
  g1(2,5)=(-T30);
  g1(3,2)=(-T73);
  g1(3,3)=exp(y(3));
  g1(3,5)=(-T30);
  g1(4,1)=exp(y(1));
  g1(4,3)=(-exp(y(3)));
  g1(4,4)=exp(y(4));
  g1(5,5)=1-(params(5)+params(6));
  g1(6,5)=(-1);
  g1(6,6)=1;
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],6,36);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],6,216);
end
end
end
end

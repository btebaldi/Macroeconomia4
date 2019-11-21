function pltt(imp,z,Ghat,g)
tt=1:imp;
n1=2;
n2=3;
subplot(n1,n2,1)
plot(tt,100*z(1,:))
title('output')
ylabel('%deviation from ss')
axis tight
subplot(n1,n2,2)
plot(tt,400*z(2,:))
title('inflation')
ylabel('APR')
axis tight
subplot(n1,n2,3)
plot(tt,400*z(3,:))
title('interest rate')
ylabel('APR')
axis tight
subplot(n1,n2,4)
plot(tt,100*Ghat*g)
ylabel('% of gdp')
title('Ghat')
axis tight
subplot(n1,n2,5)
plot(tt,z(1,:)./(g*Ghat))
ylabel('multiplier')
title('dY/dG')
axis tight
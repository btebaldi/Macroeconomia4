function pltt1(imp,z,z1,Ghat,g)
tt=1:imp;
subplot(2,2,1)
plot(tt,100*z(1,:),tt,100*z1(1,:),'*-')
% legend('KPR','CGG')
title('output')
ylabel('%deviation from ss')
axis tight
subplot(2,2,2)
plot(tt,400*z(2,:),tt,400*z1(2,:),'*-')
title('inflation')
ylabel('APR')
axis tight
subplot(2,2,3)
plot(tt,400*z(3,:),tt,400*z1(3,:),'*-')
title('interest rate')
ylabel('APR')
axis tight
subplot(2,2,4)
plot(tt,100*Ghat*g,tt,100*Ghat*g,'*-')
ylabel('% of gdp')
title('Ghat')
axis tight

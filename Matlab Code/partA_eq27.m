%
% By Weiming Ma, Qiang Li, Zhao Yu
%

%%%%%%%%%%% calculate CEO analytic solution in typo corrected version%%%%%
function [ CEO ] = partA_eq27( V,D,Pstar, tao_c,tao_s,q,rho,sigma_v,sigma_d)
P=V./D;
sigma=sqrt(sigma_v.^2+sigma_d.^2-2*rho*sigma_v.*sigma_d);
a=V*mvncdf([(log(P./Pstar)+sigma.^2*tao_c./2)/sigma./sqrt(tao_c),(log(P)+sigma.^2*tao_s./2)/sigma./sqrt(tao_s)],...
    [0,0],[1,sqrt(tao_c./tao_s);sqrt(tao_c./tao_s),1]);
b=D*mvncdf([(log(P./Pstar)+sigma.^2*tao_c./2)/sigma./sqrt(tao_c)-sigma*sqrt(tao_c),...
    (log(P)+sigma.^2*tao_s./2)/sigma./sqrt(tao_s)-sigma*sqrt(tao_s)],[0,0],...
    [1,sqrt(tao_c./tao_s);sqrt(tao_c./tao_s),1]);
c=q*D*normcdf((log(P/Pstar)+sigma.^2*tao_c./2)/sigma./sqrt(tao_c)-sigma*sqrt(tao_c),0,1);
CEO=a-b-c;
end
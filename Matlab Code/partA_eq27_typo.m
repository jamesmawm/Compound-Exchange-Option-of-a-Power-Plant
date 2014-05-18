%
% By Weiming Ma, Qiang Li, Zhao Yu
%

%%%%%%%%%%%%%%%%%5 CEO in anlytic solution in typo version  %%%%%%%%%%%%%

function [ CEO ] = partA_eq27_typo( V,D,Pstar, tao_c,tao_s,q,rho,sigma_v,sigma_d)
%EQ27_TYPO Summary of this function goes here
%   Detailed explanation goes here
P=V./D;
sigma=sqrt(sigma_v.^2+sigma_d.^2-2*rho*sigma_v.*sigma_d);
a=V*mvncdf([(log(P./Pstar)+sigma.^2*tao_c)/sigma./sqrt(tao_c),(log(P)+sigma.^2*tao_s)/sigma./sqrt(tao_s)],...
    [0,0],[1,sqrt(tao_c./tao_s);sqrt(tao_c./tao_s),1]);
b=D*mvncdf([(log(P./Pstar)+sigma.^2*tao_c)/sigma./sqrt(tao_c)-sigma*sqrt(tao_c),...
    (log(P)+sigma.^2*tao_s)/sigma./sqrt(tao_s)-sigma*sqrt(tao_s)],[0,0],...
    [1,sqrt(tao_c./tao_s);sqrt(tao_c./tao_s),1]);
c=q*D*normcdf((log(P/Pstar)+sigma.^2*tao_c)/sigma./sqrt(tao_c)-sigma*sqrt(tao_c),0,1);
CEO=a-b-c;
end
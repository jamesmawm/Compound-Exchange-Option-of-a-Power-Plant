%
% By James Ma, Qiang Li, Zhao Yu
%

%%%%%%%%%%%%%%%%%% calculate P* in typo version  %%%%%%%%%%%%%%%%%%%%%

function [ Pstar] = partA_eq26_typo(P, tao_c,tao_s,q,rho,sigma_v,sigma_d )
tao=tao_s-tao_c;
sigma=sqrt(sigma_v.^2+sigma_d.^2-2*rho*sigma_v.*sigma_d);
d1= (log(P)+sigma^2*tao)/sigma/sqrt(tao);
d2= d1-sigma*sqrt(tao);
Pstar = P*normcdf(d1,0,1)-normcdf(d2,0,1)-q ;

end


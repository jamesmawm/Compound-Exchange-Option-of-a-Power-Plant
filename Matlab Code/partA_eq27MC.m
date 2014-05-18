%
% By James Ma, Qiang Li, Zhao Yu
%

%%%%%%%%%% calculate CEO in MC simulation %%%%%%%%%%%%%

function [ CEO, CI ] = partA_eq27MC( V, D,tao_c,tao_s, q,rho,sigma_v,sigma_d,N,r)
%EQ27_TYPO Summary of this function goes here
rng(777);
%% get dz1 and dz2 %%%
dz1 = randn(1,N);
dz2 = rho.*dz1 + sqrt(1-rho.^2).*randn(1,N);
T=tao_s-tao_c;

%%%%% Simulate many Vc, Dc and anti variates at time tau_c %%%%
Vc(1:N, 1) = V * exp((r-sigma_v.^2./2).*tao_c + sigma_v.*sqrt(tao_c).*dz1);
Vc(N+1:2*N, 1) = V * exp((r-sigma_v.^2./2).*tao_c + sigma_v.*sqrt(tao_c).*-dz1);
Dc(1:N, 1) = D * exp((r-sigma_d.^2./2).*tao_c + sigma_d.*sqrt(tao_c).*dz2);
Dc(N+1:2*N, 1) = D * exp((r-sigma_d.^2./2).*tao_c + sigma_d.*sqrt(tao_c).*-dz2);
sigma=sqrt(sigma_v.^2+sigma_d.^2-2*rho*sigma_v.*sigma_d);

%%%%%%% calculate seo by using closed form %%%%%%
d1=(log(Vc./Dc)+sigma^2*T/2)/sigma/sqrt(T);
d2=d1-sigma*sqrt(T);
seo=max(Vc.*normcdf(d1,0,1)-Dc.*normcdf(d2,0,1),0);

%%%%%%%% discounted expectation of CEO %%%%%%%%%%%
CVal= exp(-r.*tao_c) .* max(seo-q*Dc, 0);
c=(CVal(1:N,1)+CVal(N+1:2*N,1))./2;
CEO=mean(c);
end


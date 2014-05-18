%
% By Weiming Ma, Qiang Li, Zhao Yu
%

function ceo = partB_CEOMC(e0, sigmaElec, f0, sigmaFuel, corr, heatRate, r, tc, ts, emitRate, emitCost, capitalCost, N)
rng(777);
q = capitalCost ./ (heatRate .* (f0 + emitRate .* emitCost));
rho = sqrt(tc./ts);
dz1 = randn(1,N);
dz2 = rho.*dz1 + sqrt(1-rho.^2).*randn(1,N);
sigmaPortfolio = getSigmaPortfolio(sigmaFuel, sigmaElec, corr);

%%%%%%%%%%% Simulate many Vc, Fc and Dc %%%%%%%%%%%
Vc= e0*exp((r-sigmaElec.^2./2).*tc + sigmaElec.*sqrt(tc).*dz1);
Fc = f0*exp((r-sigmaFuel.^2./2).*tc + sigmaFuel.*sqrt(tc).*dz2);
Dc = heatRate.*(Fc + emitRate.*emitCost);
Y = Vc/Dc;
d1 = getD1(Y, ts-tc, sigmaPortfolio);
d2 = getD2(Y, ts-tc, sigmaPortfolio);

%%%%%%%%%% get SEO in closed form %%%%%%%%%%%
seo = max(Vc.*normcdf(d1,0,1) - Dc.*normcdf(d2,0,1), 0);
K = q*Dc;

%%%%%%%%%% get CEO %%%%%%%%%%%%%%
cT1 = exp(-r.*tc) .* max(seo-capitalCost, 0);
ceo = mean(cT1);

end

function sigmaPortfolio = getSigmaPortfolio(sigma1, sigma2, corr)
sigmaPortfolio = sqrt(sigma1.^2 + sigma2.^2 - 2.*corr.*sigma1.*sigma2);
end

function d1 = getD1(y, tau, sigma)
d1 = (log(y) + 0.5.*(sigma.^2).*tau) ./ (sigma.*sqrt(tau));
end

function d2 = getD2(y, tau, sigma)
d2 = getD1(y, tau, sigma) - sigma.*sqrt(tau);
end

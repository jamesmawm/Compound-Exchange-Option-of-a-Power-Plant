%
% By Weiming Ma, Qiang Li, Zhao Yu
%



function  ceo = partB_CEOAnalytical(e0, K, heatRate, ...
                            fuelCost, emitRate, emitCost, ...
                            tc, ts, sigma1, sigma2, corr )

tau = ts - tc;
sigmaHat = getSigmaPortfolio(sigma1, sigma2, corr);

%%%% get Y* %%%%%%%%
yStar = getYStar(K, heatRate, fuelCost, emitRate, emitCost, tau, sigmaHat);
Y = e0 ./ (heatRate .* (fuelCost + emitRate .* emitCost));

d1YStar = getD1(Y/yStar, tc, sigmaHat);
d1Y = getD1(Y, ts, sigmaHat);
d2YStar = getD2(Y/yStar, tc, sigmaHat);
d2Y = getD2(Y, ts, sigmaHat);
n1d2 = normcdf(d2YStar, 0, 1);

biCorr = sqrt(tc./ts);
n2term1 = mvncdf([d1YStar d1Y], [0 0], [1 biCorr; biCorr 1]);
n2term2 = mvncdf([d2YStar d2Y], [0 0], [1 biCorr; biCorr 1]);

%%%% get CEO in analytic solution %%%%%
ceo =  e0.*n2term1 ...
       - heatRate.*(fuelCost + emitRate.*emitCost).*n2term2 ...
       - K.*n1d2;
end


function sigmaPortfolio = getSigmaPortfolio(sigma1, sigma2, corr)
sigmaPortfolio = sqrt(sigma1^2 + sigma2^2 - 2*corr*sigma1*sigma2);
end

% get Y*:
function yStar = getYStar(K, heatRate, fuelCost, ...
                        emitRate, emitCost, tau, sigma)
ratio = K ./ (heatRate.*(fuelCost + emitRate .* emitCost));
yStar = fsolve(@(x) x.*normcdf( getD1(x, tau, sigma), 0, 1 ) ...
                - normcdf( getD2(x, tau, sigma), 0, 1 ) ...
                - ratio, ...
                1, ...
                optimoptions('fsolve','Display','off'));
end

function d1 = getD1(y, tau, sigma)
d1 = (log(y) + 0.5.*(sigma^2).*tau) ./ (sigma.*sqrt(tau));
end

function d2 = getD2(y, tau, sigma)
d2 = getD1(y, tau, sigma) - sigma.*sqrt(tau);
end
%
% By Weiming Ma, Qiang Li, Zhao Yu
%

tic;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Part A %%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Calculate right version of P* and typo version of P* 
Pstar1 = fsolve(@(x) partA_eq26(x,1,13.5730,0.5555,0.6386,0.5862,0.4790),0.5);
Pstar2 = fsolve(@(x) partA_eq26_typo(x,1,13.5730,0.5555,0.6386,0.5862,0.4790),0.5);
 
% Calculate CEO premium with 'typo' in Carr
disp('Part 1: Calculate CEO premium using analytic solution with typo')
ceoTypo = partA_eq27_typo(51.8195, 34.5303, Pstar2, 1, 13.5730, 0.5555, 0.6386, 0.5862, 0.4790)
 
%Calculate CEO premium in with 'typo' corrected
disp('Part 1: Calculate CEO premium using analytic solution with typo corrected')
ceoAnalytical  = partA_eq27(51.8195, 34.5303, Pstar1, 1, 13.5730, 0.5555, 0.6386, 0.5862, 0.4790)
 
%Calculate CEO premium using the MC simulation
disp('Part 1: Calculate CEO premium using the MC simulation')
ceoMC = partA_eq27MC(51.8195, 34.5303, 1, 13.5730, 0.5555, 0.6386, 0.5862, 0.4790,100000,0.04)
 
 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Part B%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
% Variables for Electricity.
E = 51.8195;
sigmaE = 0.5862;
 
% Variables for Nat Gas.
HNatGas = 7.223;
FNatGas = 4.7806;
MNatGas = 118.00;
KNatGas = 19.18;
sigmaNatGas = 0.4790;
 
% Variables for Coal.
HCoal = 8.732;
FCoal = 0.5;
MCoal = 205.35;
KCoal = 36.06;
sigmaCoal = 0;
 
% Correlations
corrNatGasAndElec = 0.6386;
corrCoalAndElec = 0;
 
r = 0.04;
 
% Times
tc = 1;
ts = 13.5730;
 
% Plot Settings
N = 21;
i=0;
poundsPerTon = 2000;
maxPInTon = 35;
maxPInPounds = maxPInTon / poundsPerTon;
step = maxPInPounds / N;
Ps = 0:step:maxPInPounds;
 
% Init data arrays.
natGasCEOs = zeros(1, N);
coalCEOs = zeros(1, N);
 
    % Get CEOs of Nat Gas.
    for P=Ps
        CEO = partB_CEOAnalytical(E, KNatGas, HNatGas, ...
            FNatGas, MNatGas, P, ...
            tc, ts, sigmaE, sigmaNatGas, corrNatGasAndElec);
        natGasCEOs(1, i+1) = CEO;
        i = i + 1;
    end
    
    % Get CEOs of Coal.
    i=0;
    for P=Ps
        CEO = partB_CEOAnalytical(E, KCoal, HCoal, ...
            FCoal, MCoal, P, ...
            tc, ts, sigmaE, sigmaCoal, corrCoalAndElec);
        coalCEOs(1, i+1) = CEO;
        i = i + 1;
    end
    
 % Plot the data using analytic solution
    figure('name','Part B: replicate figure 2')
    subplot(1,2,1);
    plot(Ps.*poundsPerTon, coalCEOs,  'rs:' ...
        , Ps*poundsPerTon, natGasCEOs, 'bo-', 'LineWidth', 1.05);
    title('CEO Analytic Solution');
    axis([0 35 12 19]);
    ylabel('The value of investment opportunity ($/MWh)');
    xlabel('Emission Permit Cost ($/ton)');
    legend('Coal Plant', 'NG Plant');
    hold on;
    
% Init data arrays.
natGasCEOs = zeros(1, N);
coalCEOs = zeros(1, N);
    M = 10000;
    P = 0;
    % Get CEOs of Nat Gas.
    i=0;
    for P=Ps
        CEO = partB_CEOMC(E, sigmaE, FNatGas, sigmaNatGas, corrNatGasAndElec, HNatGas, r, tc, ts, MNatGas, P, KNatGas, M);
        natGasCEOs(1, i+1) = CEO;
        i = i + 1;
    end
    
    % Get CEOs of Coal.
    i=0;
    for P=Ps
        CEO = partB_CEOMC(E, sigmaE, FCoal, sigmaCoal, corrCoalAndElec, HCoal, r, tc, ts, MCoal, P, KCoal, M);
        coalCEOs(1, i+1) = CEO;
        i = i + 1;
    end
    
  % Plot the data using MC simulation
    subplot(1,2,2);
    plot(Ps.*poundsPerTon, coalCEOs,  'rs:' ...
        , Ps*poundsPerTon, natGasCEOs, 'bo-', 'LineWidth', 1.05);
    title('CEO MC simulation');
    axis([0 35 12 19]);
    ylabel('The value of investment opportunity ($/MWh)');
    xlabel('Emission Permit Cost ($/ton)');
    legend('Coal Plant', 'NG Plant');
 
   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%% Part C%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
load data.mat
 
%
r = 0.04;
poundsPerTon = 2000;
 
% Times
tc = 1;
ts = 13.5730;
 
% Define columns.
col_E=1;
col_H=2;
col_F=3;
col_M=4;
col_P=5;
col_K=6;
col_r = 7;
col_tc = 8;
col_ts = 9;
col_sigmaE = 10;
col_sigmaF = 11;
col_corr = 12;
 
disp('Pre-start simulation...')    
 
% Generate random variables for reuse.        
rng(777);
pilotN = 5000;
N1 = 10000;
pilotDz1 = randn(1,pilotN);
pilotDz2 = randn(1,pilotN);
RN1 = randn(1, N1);
RN2 = randn(1, N1);
 
% Pre-generate random numbers.
biggestN2 = 20000000;
DZ1 = randn(1,biggestN2);
DZ2 = randn(1,biggestN2);
 
absErrorPostTerm = 1.96.^2 ./ 0.005.^2;
 
disp('Starting simulation...')    
NoOfRows = 120;
 
 
for i=1:NoOfRows;
    disp(sprintf('%d result. ',i));
    
    E = data(i, col_E);
    H = data(i, col_H);
    F = data(i, col_F);
    M = data(i, col_M);
    P = data(i, col_P)./poundsPerTon;
    K = data(i, col_K);
    r = data(i, col_r);
    tc = data(i, col_tc);
    ts = data(i, col_ts);
    sigmaE = data(i, col_sigmaE);
    sigmaF = data(i, col_sigmaF);
    corr = data(i, col_corr);
 
    % Pre-compute invariant variables.
    tau = ts - tc;
    sqrtTc = sqrt(tc);
    rtc = r.*tc;
    rho = sqrt(tc./ts);     
    MP = M.*P;
    nudcElec = (r-sigmaE.^2./2).*tc;
    nudcFuel = (r-sigmaF.^2./2).*tc;
    sigmaSqrtTcElec = sigmaE.*sqrtTc;
    sigmaSqrtTcFuel = sigmaF.*sqrtTc;
    q = K ./ (H .* (F + MP));
    sigmaPortfolio = sqrt(sigmaE.^2 + sigmaF.^2 - 2.*corr.*sigmaE.*sigmaF);
    halfSigmaPortfolioSqTau = 0.5.*(sigmaPortfolio^2).*tau;
    sigmaPortfolioSqrtTau = sigmaPortfolio*sqrt(tau);
    sqrtOf1MinusRhoSq = sqrt(1-rho.^2);
              
    % Load in the set of pre-generated random numbers.       
    pdz1 = pilotDz1;
    pdz2 = rho.*pdz1 + sqrtOf1MinusRhoSq.*pilotDz2;
    dz1 = RN1;
    dz2 = rho.*dz1 + sqrtOf1MinusRhoSq.*RN2;  
             
    [ceo, CI, c, exerciseFrequency ] = partC_CEOPremia(E, sigmaE, F, sigmaF, ...
         corr, H, r, tc, ts, pdz1, pdz2, dz1, dz2, ...
        tau, sqrtTc, rtc, MP, nudcElec, nudcFuel, ...
        sigmaSqrtTcElec, sigmaSqrtTcFuel, sigmaPortfolio, ...
        halfSigmaPortfolioSqTau, sigmaPortfolioSqrtTau ...        
        );    
   
    if (CI(2)-CI(1) > 0.01)         
        % Control the absolute error to $0.01 with 95% confidence.
        N2 = floor(std(c).^2.*absErrorPostTerm);  
        if (N2 > biggestN2)            
            % Generate a new set of random nos to fit the bigger size.
            rng(777);
            biggestN2 = N2;
            DZ1 = randn(1,N2);
            DZ2 = randn(1,N2); 
        end
        
        % Load in the set of pre-generated random numbers.
        dz1 = DZ1(1:N2);
        dz2 = rho.*dz1 + sqrtOf1MinusRhoSq.*DZ2(1:N2);
        
        [ceo, CI, c, exerciseFrequency ] = partC_CEOPremia(E, sigmaE, F, sigmaF, ...
             corr, H, r, tc, ts, pdz1, pdz2, dz1, dz2, ...
            tau, sqrtTc, rtc, MP, nudcElec, nudcFuel, ...
            sigmaSqrtTcElec, sigmaSqrtTcFuel, sigmaPortfolio, ...
            halfSigmaPortfolioSqTau, sigmaPortfolioSqrtTau ...
            );
    else
        % Use the first MC result if absolute error is relatively small.
        N2 = N1;
        
    end       
    confidenceInterval = CI(2)-CI(1);
    
    result(i,1) = ceo;
    result(i,2) = confidenceInterval;
    result(i,3) = exerciseFrequency;
    result(i,4) = N2;
      
end
toc;
 

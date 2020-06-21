function [U,hasFinished] = controller(X)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% function [U] = controller(X)
%
% controller for the single-track model
%
% inputs: x (x position), y (y position), v (velocity), beta
% (side slip angle), psi (yaw angle), omega (yaw rate), x_dot (longitudinal
% velocity), y_dot (lateral velocity), psi_dot (yaw rate (redundant)), 
% varphi_dot (wheel rotary frequency)
%
% external inputs (from 'racetrack.mat'): t_r_x (x coordinate of right 
% racetrack boundary), t_r_y (y coordinate of right racetrack boundary),
% t_l_x (x coordinate of left racetrack boundary), t_l_y (y coordinate of
% left racetrack boundary)
%
% outputs: delta (steering angle ), G (gear 1 ... 5), F_b (braking
% force), zeta (braking force distribution), phi (gas pedal position)
%
% files requested: racetrack.mat
%
% This file is for use within the "Project Competition" of the "Concepts of
% Automatic Control" course at the University of Stuttgart, held by F.
% Allgoewer.
%
% prepared by J. M. Montenbruck, Dec. 2013 
% mailto:jan-maximilian.montenbruck@ist.uni-stuttgart.de
%
% written by *STUDENT*, *DATE*
% mailto:*MAILADDRESS*


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INITIALIZATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% state vector
x=X(1); % x position
y=X(2); % y position
v=X(3); % velocity (strictly positive)
beta=X(4); % side slip angle
psi=X(5); % yaw angle
omega=X(6); % yaw rate
x_dot=X(7); % longitudinal velocity
y_dot=X(8); % lateral velocity
psi_dot=X(9); % yaw rate (redundant)
varphi_dot=X(10); % wheel rotary frequency (strictly positive)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STATE FEEDBACK %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
persistent i states precomputedLine vBreak g k

%% Init
v_0 = 5;
% Persistent variables
if(~exist('i','var') || isempty(i))   
    i = 1;
    states = zeros(4,1);
    
    % Load precomputed line determined by solving corresponding NLP

    % Fudge v to get some safety margin
    precomputedLine = safetyMargin(precomputedLine);
    
    % Get Torque curve and gear selection
    [vBreak,M,g] = powerCurve();
    
    % K Gains
    k = struct(); k.vkbreak = reshape([5;15;35], [1 3]); k.betakbreak = reshape([-0.0872664625997165;-0.0598508948189127;-0.0324353270381089;-0.00501975925730515;0.0223958085234986;0.0498113763043024;0.0772269440851062], [1 7]); k.nkbreak = reshape(0, [1 1]); k.xikbreak = reshape([-0.523598775598299;0;0.523598775598299], [1 3]); k.deltakbreak = reshape(0, [1 1]); k.ckbreak = reshape(0, [1 1]); k.kV = reshape([0.236522292553059;0.115467919207129;0.0606443310022578;0.097361364247487;0.0463615057201077;0.0250162849771945;0.0373325470419756;0.0179750565454808;0.00994874006641954;0.00504569626997402;0.00244560906201422;0.00136934408153748;-0.0239676257760472;-0.011539004759492;-0.00641106222123404;-0.0700309018723845;-0.0331096033227541;-0.0179357951281544;-0.173222346996829;-0.0816496648986549;-0.0427976262002096;0.240907088970923;0.121040859902587;0.0632312282675261;0.098197604236825;0.0480434521077918;0.0259842444690297;0.037443345644994;0.0184849096854353;0.0103000887303547;0.005050406033531;0.00250942953468295;0.00141766390026866;-0.0239860004322023;-0.011881760898791;-0.00666942061644664;-0.0701834876168853;-0.0344101664456529;-0.0188369584409334;-0.173687250520689;-0.0856938647100575;-0.0453366810885708;0.240598175164001;0.11516450660576;0.0596214433608714;0.0979250584182612;0.0460396807266235;0.0246488566420982;0.0374014794456511;0.0179013793781221;0.00987066381705594;0.00504690000880945;0.00244411928740173;0.00136774750913704;-0.0239400468088696;-0.0115711846752445;-0.00644529114740348;-0.0697652010972957;-0.0333168257988791;-0.0181599930190777;-0.171197251857813;-0.0821233231646521;-0.0435433843568406], [3 7 3]); k.kBeta = reshape([-3.85849916572238;-18.1854023443561;-52.0252182161846;-2.40264758555507;-11.7707134137605;-35.1660579087882;-1.70254934355357;-8.71894020590786;-27.0046902176996;-1.48188220704124;-7.72835743927009;-24.3241453958071;-1.58707262781936;-8.21697736026096;-25.677762805157;-2.08727036484801;-10.4569853752796;-31.7886113956141;-3.18987559070969;-15.3678070445656;-45.1355647495371;-3.4528211077821;-17.1009757958633;-49.7728326524021;-2.16068161930347;-11.0164427473202;-33.4750001045913;-1.52915497930868;-8.08795042114068;-25.4999415716444;-1.32648775828033;-7.11793431931446;-22.812358224696;-1.41596379052614;-7.54924344035258;-24.011505689716;-1.8655344763143;-9.65753723868445;-29.7930397082483;-2.88787835514131;-14.3882535921661;-42.5327082171004;-3.78572915497621;-18.14494865741;-52.7102068255492;-2.40953014996295;-11.8790386792792;-35.6515804698179;-1.71451552329864;-8.7957023017186;-27.2631583899699;-1.48393790612711;-7.74062576631005;-24.363512078871;-1.57823551497272;-8.16282483626469;-25.5006728253291;-2.07458282153954;-10.3513725522159;-31.3864033185909;-3.21749021324651;-15.3125407532942;-44.5136873513334], [3 7 3]); k.kPsi_dot = reshape([0.105384403042474;-0.093796039348179;-0.292671566679923;0.152187221964376;0.05804252604807;-0.0915403258166557;0.169295673276116;0.126357619354614;0.00764365824041627;0.173129030689171;0.14840301510033;0.0411667825618691;0.171363557367527;0.137898197270246;0.0245595688628706;0.160721600362688;0.0896885562759912;-0.0487935493723107;0.131830402422669;-0.0140776194348063;-0.200875473463304;0.130412713961576;-0.064537733017348;-0.262266410210282;0.165910127585083;0.0789327141871389;-0.0676152687380723;0.17764880292064;0.144563151993158;0.0305596355912734;0.179861724612713;0.166080589584855;0.0647272071661536;0.179046035898732;0.156579269762193;0.049458264183973;0.172008129982282;0.109397417640593;-0.0229157638329009;0.147737193259411;0.00163110688246883;-0.17554835655505;0.113640245805287;-0.0757387381313747;-0.28712242199194;0.152817324217017;0.0597011352205967;-0.0934737209171195;0.168956504464507;0.125338704604653;0.0051760848172162;0.173064869157863;0.14817814243303;0.0407216704204519;0.171633610681938;0.138779049451313;0.0264251736503971;0.160800471687616;0.089821580519764;-0.0461445972192766;0.127725769054848;-0.0233175716773516;-0.202468918164817], [3 7 3]); k.kN = reshape([7.07106781186548;7.07106781186555;7.07106781186536;7.07106781186547;7.0710678118655;7.07106781186524;7.07106781186548;7.07106781186545;7.07106781186512;7.07106781186548;7.07106781186544;7.07106781186548;7.07106781186548;7.0710678118655;7.07106781186546;7.07106781186547;7.07106781186548;7.07106781186549;7.07106781186547;7.07106781186546;7.07106781186548;7.07106781186547;7.07106781186551;7.07106781186522;7.07106781186549;7.07106781186534;7.07106781186571;7.07106781186548;7.07106781186548;7.07106781186559;7.07106781186547;7.07106781186546;7.07106781186529;7.07106781186547;7.07106781186544;7.07106781186546;7.07106781186546;7.07106781186545;7.07106781186548;7.07106781186549;7.07106781186541;7.07106781186537;7.07106781186547;7.07106781186548;7.07106781186557;7.07106781186548;7.0710678118655;7.07106781186556;7.07106781186547;7.07106781186548;7.07106781186542;7.07106781186548;7.07106781186547;7.0710678118657;7.07106781186547;7.07106781186547;7.07106781186544;7.07106781186549;7.07106781186545;7.07106781186536;7.07106781186548;7.07106781186544;7.07106781186578], [3 7 3]); k.kXi = reshape([6.68254838494355;21.5529391029015;56.0157136011682;5.14067973526473;15.2607732169464;39.4908757415162;4.40823961996642;12.3542223500768;31.6802111317898;4.17570767362695;11.4277735453805;29.1609279312695;4.28576757683898;11.877452431256;30.416199046871;4.81185936996464;13.9824487520442;36.1965857911824;5.99642737017911;18.756034972157;49.1696196939518;6.37671364209036;20.6332796667177;53.9305555113239;4.95438527196473;14.6340087830219;37.9657838253866;4.27177913996239;11.8294338803083;30.3425245986606;4.05211547008788;10.917885818197;27.8233369185988;4.14930929444588;11.3222802578719;28.943990084606;4.63487584219588;13.322888036386;34.4219489803417;5.75010806922318;17.9402350108378;46.7996735177842;6.65378570493752;21.5118225024483;56.6378802414973;5.15374309994503;15.3460437008896;39.9141313055737;4.41958584424087;12.4158634048012;31.9017264326368;4.17754260652655;11.4377142185309;29.1945562898745;4.27769219399299;11.8337633729105;30.2647343198055;4.79725364398085;13.8985411840509;35.8490206999745;6.00022162467379;18.7161761888618;48.6148168662795], [3 7 3]);
end

% Vehicle Parameter
m = 1239; % vehicle mass
R = 0.302; % wheel radius
I_R = 1.5; % wheel moment of inertia
i_g = [3.91 2.002 1.33 1 0.805]; % transmissions of the 1st ... 5th gear
i_0 = 3.91; % motor transmission


%% Internal track position and precalculation
ds = 0.1; % Preview distance

C = interp1(precomputedLine.sOpt,precomputedLine.CTrack,states(1));
vTarget = interp1(precomputedLine.sOpt,precomputedLine.vOpt,states(1)+ds);
nTarget = interp1(precomputedLine.sOpt,precomputedLine.nOpt,states(1));
xiTarget = interp1(precomputedLine.sOpt,precomputedLine.xiOpt,states(1));
deltaFF = interp1(precomputedLine.sOpt,precomputedLine.deltaOpt,states(1));
psi_dotTarget = interp1(precomputedLine.sOpt,precomputedLine.psi_dotOpt,states(1));
betaTarget = interp1(precomputedLine.sOpt,precomputedLine.betaOpt,states(1));
zetaFF = interp1(precomputedLine.sOpt,precomputedLine.zetaOpt,states(1));

%% Longitudinal Control

% Time/distance scaling for correct acceleration calculation
s_dot = v .* cos(-beta + states(3)) ./ (1 - states(2) .* C);
if(v < v_0)
    % fudging s_dot until we reached precalculated start velocity
    s_dot = 1;
end
a_x_target = 1.*s_dot*(vTarget-v)./ds;

% Calculate Wheeltorque Target for Acceleration
[~,idxV] = min(abs(vBreak(:)-v));
G = g(idxV);
MTargetAcc = min(max(a_x_target.*(m+I_R/R^2)*R,0),15000);

% Calculate torque for all possible phi and choose phi to match MTarget
S = 0;
phiBreak = 0:0.01:1;
n = v .* i_g(G) * i_0 * (1./(1 - S))/R; % motor rotary frequency
T_M = 200 .* phiBreak .* (15 - 14 .* phiBreak) .* (1 - (n * 30 / (pi * 4800 * 2)).^(5 .* phiBreak)); % Same as the above, just simpler
M_wheel = i_g(G) .* i_0 .* T_M; % wheel torque

[~,idxM_wheelMax] = max(M_wheel);
M_wheel = M_wheel(1:idxM_wheelMax);
phiBreak = phiBreak(1:idxM_wheelMax);

[~,idxPhiBreak] = min(abs(M_wheel(:)-MTargetAcc));
phi = phiBreak(idxPhiBreak);

% Calculate Brakeforce Target for Deceleration
FTargetDec = min(-min(a_x_target.*(m+I_R/R^2),0),15000);
Fb = FTargetDec;
zeta = zetaFF;


%% Lateral LQR Controller
vInterp = max(min(v,max(k.vkbreak)),min(k.vkbreak));
betaInterp = max(min(beta,max(k.betakbreak)),min(k.betakbreak));
xiInterp = max(min(states(3),max(k.xikbreak)),min(k.xikbreak));

kCurrent = [
    interpn(k.vkbreak,k.betakbreak,k.xikbreak,k.kV,vInterp,betaInterp,xiInterp)...
    interpn(k.vkbreak,k.betakbreak,k.xikbreak,k.kPsi_dot,vInterp,betaInterp,xiInterp)...
    interpn(k.vkbreak,k.betakbreak,k.xikbreak,k.kBeta,vInterp,betaInterp,xiInterp)...
    interpn(k.vkbreak,k.betakbreak,k.xikbreak,k.kN,vInterp,betaInterp,xiInterp)...
    interpn(k.vkbreak,k.betakbreak,k.xikbreak,k.kXi,vInterp,betaInterp,xiInterp)...
];
deltaFB = kCurrent*[0; (psi_dot-psi_dotTarget); (beta-betaTarget); (states(2)-nTarget); (states(3)-xiTarget)]; % Use beta and xi as states

if isnan(deltaFB)
    deltaFF = precomputedLine.deltaOpt(end);
end

delta = max(min(deltaFF - deltaFB,0.51),-0.51);

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
U=[delta G Fb zeta phi]; % input vector
hasFinished = x > -5 && x < 0 && y > 0 && y < 5 && states(1) > 1000;

%% Logging
log = [v; psi_dot; beta; states(2); states(3); delta; Fb; zeta; phi; deltaFF; deltaFB; states(1); C; hasFinished];

%% Internal integration
h = 0.001;
states = states+h*dModel(states,v,beta,psi_dot,C,nTarget);
i = i+1;

if(hasFinished)
    disp('And across the line!')
end

end

function dx = dModel(x,v,beta,psi_dot,C,nTarget)
    s_dot = v .* cos(-beta + x(3)) ./ (1 - x(2) .* C);
    n_dot = v .* sin(-beta + x(3));
    xi_dot = psi_dot - C .* s_dot;
    dn_dot = nTarget-x(2);
    
    dx = [s_dot; n_dot; xi_dot; dn_dot];
end

function pre = safetyMargin(pre)
%SAFETYMARGIN Summary of this function goes here
%   Detailed explanation goes here
sStart = [246  442  623   889];
sEnd = [302  539  652 1.0298e+03];

factorY = [0.95 0.93 0.95 0.85];

[~,idxMax] = findpeaks(pre.vOpt);

dsIn = 5;
dsOut = 2;
factor = ones(1,length(pre.CTrack));
for i=1:length(sStart)
    [~,idxStart] = min(abs(pre.sOpt-sStart(i)));
    [~,idxEnd] = min(abs(pre.sOpt-sEnd(i)));
    
    
    factor(idxStart:idxEnd) = factorY(i);
    idxPrevMax = max(idxMax(idxMax < idxStart));
    
    [~,idxPrevMaxDsIn] = min(abs(pre.sOpt-(pre.sOpt(idxPrevMax)-dsIn)));
    [~,idxPrevMaxDsOut] = min(abs(pre.sOpt-(pre.sOpt(idxEnd)+dsOut)));
    factor(idxPrevMaxDsIn:idxStart) = linspace(1,factor(idxStart), idxStart-idxPrevMaxDsIn+1);
    factor(idxEnd:idxPrevMaxDsOut) = linspace(factor(idxEnd), 1, idxPrevMaxDsOut-idxEnd+1);
end

pre.vOpt = factor.*pre.vOpt;
end

function [v,M,g] = powerCurve()
%POWERCURVE Summary of this function goes here
%   Detailed explanation goes here

R = 0.302; % wheel radius
i_g = [3.91 2.002 1.33 1 0.805]; % transmissions of the 1st ... 5th gear
i_0 = 3.91; % motor transmission
G = 1:5;
v = 0:0.1:50;

% figure;
% hold on;
S = 0;

M = zeros(1,length(v));
g = zeros(1,length(v));
phi = 0:0.01:1;
[V,PHI] = meshgrid(v,phi);

for i=length(G):-1:1
    n = V .* i_g(G(i)) * i_0 * (1./(1 - S))/R; % motor rotary frequency
    T_M = 200 * PHI .* (15 - 14 * PHI) ...
        - 200 * PHI .* (15 - 14 * PHI) .* (((n * (30 / pi)).^(5 * PHI)) ./ (4800.^(5 * PHI))); % motor torque
    M_wheel = i_g(G(i)) .* i_0 .* T_M; % wheel torque
    
    Mmax= max(M_wheel);
    
    idx = Mmax > M;
    M(idx) = Mmax(idx);
    g(idx) = G(i);    
end

noGear = g == 0;
v(noGear) = [];
M(noGear) = [];
g(noGear) = [];


end



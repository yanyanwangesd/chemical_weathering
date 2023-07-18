
% Calculate weathering indices from measured elemental data
% Yanyan Wang (wangyanyan0607@hotmail.com)

% Check the example excel file, make sure your excel file has the same
% header as the example. 

% Last update on Feb.7th, 2023

%% 1) read in table of basins
txt = 'example_chemical_elements.xlsx';
T = readtable(txt,'Sheet',1);


%% 2) define constants of molar mass
molar_SiO2 = 28.09+16*2; % g/mol
molar_Al2O3 = 26.98*2+16*3; % g/mol
molar_Na2O = 22.99*2+16; % g/mol
molar_K2O = 39.1*2+16; % g/mol
molar_CaO = 40.08+16; % g/mol
molar_P2O5 = 141.95;% g/mol
molar_CO2 = 44.01; % g/mol
molar_MgO = 24.31+16; % g/mol
molar_Rb = 85.47; % g/mol
molar_Sr = 87.62; % g/mol
molar_Sc = 44.96; % g/mol
molar_Th = 232.04; % g/mol
molar_Sm = 150.35; % g/mol
molar_P = 30.97; % g/mol
molar_Ba = 137.33; % g/mol
molar_Cs = 132.91;% g/mol
molar_Fe = 55.84; % g/mol
molar_Fe2O3 = molar_Fe*2+16*3;

%% 3) load data

% %%%%%%%%%  load in unit in weight(%) variables, convert into molars
SiO2 = T.SiO2/molar_SiO2;
Al2O3 = T.Al2O3/molar_Al2O3;
CaO = T.CaO/molar_CaO;
Na2O = T.Na2O/molar_Na2O;
K2O = T.K2O/molar_K2O;
MgO = T.MgO/molar_MgO;
Fe2O3 = T.Fe2O3/molar_Fe2O3;

% %%%%%%%%%  load in unit in ppm variables, convert into molars
Sm = T.Sm/molar_Sm/1e6;
Sr = T.Sr/molar_Sr/1e6;
Rb = T.Rb/molar_Rb/1e6;
Sc = T.Sc/molar_Sc/1e6;
Th = T.Th/molar_Th/1e6;
Ba = T.Ba/molar_Ba/1e6;
Cs = T.Cs/molar_Cs/1e6;

%% 4) calculate CaO_star (following CaO_star definition of McLennan 1993)
P = T.P;
P2O5 = P*1e-6/molar_P/2; % in mol
CaOstar = CaO- 10/3*P2O5;
id = CaO<Na2O;
CaO(~id) = CaOstar(~id);
CaO(~id) = Na2O(~id);


%% 5) calculate weathering indices (note CaO_star is used for all relevent indices)
R = Al2O3./SiO2; % grain size 
CIA = Al2O3./(Al2O3+CaO+Na2O+K2O)*100; % chemical index of alteration, mol
CIW = Al2O3./(Al2O3+CaO+Na2O)*100; % chemical index of weaterhing, use mol
PIA = (Al2O3-K2O)./(Al2O3+CaO+Na2O-K2O)*100; % Plagioclase index of alteration, use mol
WIP = (2*Na2O/0.35 + MgO/0.9 + 2*K2O/0.25 + CaO/0.7)*100; % weathering index of Parker, use mol

%% 5) calculate mean weathering conditions of upper continental crust, for comparing purpose, not necessary

% UCC talbe of values, mass weight ratio, from Rudnick and Gao 2003
UCC_SiO2 = 66.62/molar_SiO2;% mol
UCC_Al2O3 = 15.4/molar_Al2O3;% mol
UCC_CaO = 3.59/molar_CaO; % mol
UCC_Na2O =3.27/molar_Na2O; % mol
UCC_K2O = 2.8/molar_K2O;% mol
UCC_MgO =2.48/molar_MgO;% mol
UCC_Sm = 4.7/molar_Sm/1e6; % mol
UCC_Ba = 628/molar_Ba/1e6; % mol
UCC_Rb = 84/molar_Rb/1e6; % mol
UCC_Cs = 4.9/molar_Cs/1e6; % mol
UCC_Sr = 320/molar_Sr/1e6; % mol

% UCC mean weathering indices
UCC_R = UCC_Al2O3./UCC_SiO2; % grain size proxy
UCC_CIA = UCC_Al2O3./(UCC_Al2O3+UCC_CaO+UCC_Na2O+UCC_K2O)*100; % chemical index of alteration 
UCC_WIP = (2*UCC_Na2O/0.35 + UCC_MgO/0.9 + 2*UCC_K2O/0.25 + UCC_CaO/0.7)*100;
UCC_CIW = UCC_Al2O3./(UCC_Al2O3+UCC_CaO+UCC_Na2O)*100; % chemical index of weaterhing 
UCC_PIA = (UCC_Al2O3-UCC_K2O)./(UCC_Al2O3+UCC_CaO+UCC_Na2O-UCC_K2O)*100;

UCC_alphaNa = UCC_Sm/UCC_Na2O*2;
UCC_alphaCa = UCC_Sm/UCC_CaO;
UCC_alphaK = UCC_Sm/UCC_K2O*2;

UCC_alpha_AlNa = UCC_Al2O3/UCC_Na2O;% mol/mol
UCC_alpha_AlCa = UCC_Al2O3/UCC_CaO*2;% mol/mol
UCC_alpha_AlMg = UCC_Al2O3/UCC_MgO*2;% mol/mol
UCC_alpha_AlK =  UCC_Al2O3/UCC_K2O;% mol/mol
UCC_alpha_AlBa = UCC_Al2O3/UCC_Ba*2;% mol/mol
UCC_alpha_AlCs = UCC_Al2O3/UCC_Cs*2; % mol/mol
UCC_alpha_AlRb = UCC_Al2O3/UCC_Rb*2;% mol/mol
UCC_alpha_AlSr = UCC_Al2O3/UCC_Sr*2;% mol/mol

UCC_Rb_Sr = 84/320; % ppm/ppm,  ppm=(ug/g)
UCC_Sc_Th = 14/10.5; % ppm/ppm,  ppm=(ug/g)

%% 6) Other weathering indices
% other indices
alpha_AlCa = (Al2O3./CaO*2)/UCC_alpha_AlCa;
alpha_AlNa = (Al2O3./Na2O)/UCC_alpha_AlNa;
alpha_AlMg = (Al2O3./MgO*2)/UCC_alpha_AlMg;
alpha_AlK =  (Al2O3./K2O)/UCC_alpha_AlK;

alpha_AlSr = (Al2O3./Sr*2)/UCC_alpha_AlSr;
alpha_AlBa = (Al2O3./Ba*2)/UCC_alpha_AlBa;
alpha_AlRb = (Al2O3./Rb*2)/UCC_alpha_AlRb;
alpha_AlCs = (Al2O3./Cs*2)/UCC_alpha_AlCs;

Rb_Sr = Rb*molar_Rb./Sr/molar_Sr; % ppm/ppm
Sc_Th = Sc*molar_Sc./Th/molar_Th; % ppm/ppm

Na_Si = Na2O./SiO2;
Fe_Si = Fe2O3./SiO2;



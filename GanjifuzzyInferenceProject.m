clc;
clear;
close all;
fisName = 'Ganji FIS';
fisType = 'mamdani';
andMethod = 'min';
orMethod = 'max';
impMethod = 'min';
aggMethod = 'max';
defuzzMethod = 'centroid';
fis = newfis(fisName,fisType,andMethod,orMethod,impMethod,aggMethod,defuzzMethod);

inf=99999;

%% adding variables
fis = addvar(fis,'input','Velocity_Soraat',[0 180]);
fis = addmf(fis,'input',1,'LVelocity','trapmf', [-inf -inf 30 50]);
fis = addmf(fis,'input',1,'MVelocity','trapmf', [30 50 70 90]);
fis = addmf(fis,'input',1,'HVelocity','trapmf', [70 90 inf inf]);

fis = addvar(fis,'input','Distance_fasele', [0 50]);
fis = addmf(fis,'input',2,'LDistance','trapmf', [-inf -inf 10 20]);
fis = addmf(fis,'input',2,'MDistance','trapmf', [10 20 30 40]);
fis = addmf(fis,'input',2,'HDistance','trapmf', [30 40 inf inf]);


fis = addvar(fis,'output','Acceleration', [-1 1]);
fis = addmf(fis,'output',1,'NL','trapmf', [-inf -inf -0.6 -0.2]);
fis = addmf(fis,'output',1,'NS','trimf', [-0.6 -0.2 0]);
fis = addmf(fis,'output',1,'Zero','trimf', [-0.2 0 0.2]);
fis = addmf(fis,'output',1,'PS','trimf', [0 0.2 0.6]);
fis = addmf(fis,'output',1,'PL','trapmf', [0.2 0.6 inf inf]);


%% add rules
Rules = [1 1 3 1 1
    1 2 4 1 1
    1 3 5 1 1
    2 1 2 1 1
    2 2 3 1 1
    2 3 4 1 1
    3 1 1 1 1
    3 2 2 1 1
    3 3 3 1 1];

fis = addrule(fis,Rules);
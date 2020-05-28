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
fis = addmf(fis,'input',1,'LVelocity','trimf', [-inf 30 70]);
fis = addmf(fis,'input',1,'HVelocity','trimf', [30 70 inf]);


fis = addvar(fis,'input','Distance_fasele', [0 50]);
fis = addmf(fis,'input',2,'LDistance','trimf', [-inf 10 30]);
fis = addmf(fis,'input',2,'HDistance','trimf', [10 30 inf]);



fis = addvar(fis,'output','Acceleration', [-30 30]);

fis = addmf(fis,'output',1,'NS','trimf', [-inf -10 0]);
fis = addmf(fis,'output',1,'Zero','trimf', [-10 0 10]);
fis = addmf(fis,'output',1,'PS','trimf', [0 10 inf]);



%% add rules
Rules = [1 1 2 1 1
    1 2 1 1 1
    2 1 3 1 1
    2 2 2 1 1];

fis = addrule(fis,Rules);
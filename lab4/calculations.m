clear all;
close all;
clc;

%%Data and equations
l = 0.3*10^(-6);
width = 4*l;
Rs = 2.1;
Cpf = 84*10^(-12);
Cmf = 26*10^(-12);

Trd1 = 0.501954*10^(-9);
Tfd1 = 0.412984*10^(-9);
Trd2 = 1.34632*10^(-9);
Trd3 = 1.86160*10^(-9);

%%Calculations
Cm1 = 30*Cmf*l;
Cm2 = 100*Cmf*l;

syms Rp Cg Cd Rn
Eq1 = Trd1 == Rp*Cd;
Eq2 = Trd2 == Rp*(Cd+Cm1+Cg) + Rp*Cd;
Eq3 = Trd3 == Rp*(Cd+Cm2+Cg) + Rp*Cd;
Eq4 = Tfd1 == Rn*Cd;
sol = solve([Eq1, Eq2, Eq3, Eq4], [Rp, Cg, Cd, Rn]);
Rp = double(sol.Rp);
Cg = double(sol.Cg);
Cd = double(sol.Cd);
Rn = double(sol.Rn);

%%Calculations for 43500l
C = Cpf*43500*l;
R = (Rs*43500*l)/width;

n = 2:2:60;

for i=1:length(n)
    R = R/(n(i)-1);
    C = C/(n(i)-1);
    trd(i) = (n(i)-1)*((Rp*(Cd+(C/6)))+((Rp+(R/3))*(C/3))+((Rp+((2*R)/3))*(C/3))+((Rp+((3*R)/3))*((C/6)+Cg)))+Rp*Cd;
    tfd(i) = (n(i)-1)*((Rn*(Cd+(C/6)))+((Rn+(R/3))*(C/3))+((Rn+((2*R)/3))*(C/3))+((Rn+((3*R)/3))*((C/6)+Cg)))+Rn*Cd;
    td(i) = (trd(i)+tfd(i))/2;
end

m = [2,4,6,8,10,12,14,16,18,20,26,36,38,40];
tdex=[(7.01821*10^-6)/2, (3.45757*10^-7)/2, (2.81622*10^-7)/2, (2.65236*10^-7)/2, (2.41698*10^-7)/2, (2.35967*10^-7)/2, (2.35521*10^-7)/2, (2.34171*10^-7)/2, (2.34147*10^-7)/2, (2.32847*10^-7)/2, (2.31438*10^-7)/2, (2.23712*10^-7)/2, (2.45344*10^-7)/2, (2.51063*10^-7)/2];

figure (1)
plot (n,td)
title ('Θεωρητικός Υπολογισμός Καθυστερήσεων')
xlabel('Αριθμός Αντιστροφέων')
ylabel('Συνολική Μέση Καθυστέρηση')

figure (2)
plot (m,tdex)
title ('Πειραματικός Υπολογισμός Καθυστερήσεων')
xlabel('Αριθμός Αντιστροφέων')
ylabel('Συνολική Μέση Καθυστέρηση')
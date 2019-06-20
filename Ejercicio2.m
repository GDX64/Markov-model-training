%Punto 2

close all
clear all
clc

format short
format compact

load data;
load datosE2;
colordef white;

%cargando modelo
modelo=hmmE2;
%Generando sequencia de observaciones
X=xgen(hmmE2);

plot(X(:,1),X(:,2))
title('Muestras X')

[st, Pxvit]=logvit(X,modelo);
Px=logfwd(X,modelo);

figure
plot(st)
title('Evolucion de los estados')

disp(['Viterbi= ' num2str(Pxvit)])
disp(['P(X)= ' num2str(Px)])
modelo.trans
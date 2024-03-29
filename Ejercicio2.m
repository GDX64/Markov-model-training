%Punto 2

close all
clear all
clc

format compact

load data;
load datosE2;
colordef white;

%cargando modelo
modelo=hmmE2;
%Generando sequencia de observaciones
X=xgen(hmmE2);

[st, Pxvit]=logvit(X,modelo);
plotseq2(X,st,hmmE2);
Px=logfwd(X,modelo);

[decode, lx,ly]=states_decode(st);

figure
plot(st)
title('Evolucion de los estados')
text(lx,ly-0.2,decode,'Color', 'r', 'FontWeight','bold','FontSize',7)

disp(['Viterbi= ' num2str(Pxvit)])
disp(['P(X)= ' num2str(Px)])
modelo.trans


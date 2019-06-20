%% EM
clear all
close all
clc

%setting things
load('data.mat','hmm4');
%funcion que genera las observaciones X dado un modelo
[X,st]=xgen(hmm4);
%funcion que genera el modelo h de entreinamiento
modelo=traingen(X);
nStates=size(modelo.trans,1)-2;


%%

figure
plotseq2(X,st,modelo);

l(1)=-1e6;
l(2)=-1e5;
n=2;
while abs(l(n-1)-l(n))>0.001  
%Paso E
    n=n+1;
    alphaT=alphaRec(X,modelo);
    betaT=betaRec(X,modelo);
    gm=gammaRec(alphaT,betaT);
    l(n)=logfwd(X,modelo);
    xi=xiRec(X,modelo,alphaT,betaT);
    xi(xi>0)=0;
    
%Paso M

%a
    a=sum(exp(xi));
    a=reshape(a,3,3);
    den=sum(exp(gm(1:end,:)));
    for i=1:nStates
       a(i,:)=a(i,:)/den(i);
    end
    falta=1-sum(a(end,:));
    modelo.trans(2:4,2:4)=a;
    modelo.trans(4,5)=falta;

    
    %mu e var
    for j=1:nStates
       modelo.means{j+1}=X'*exp(gm(:,j))/sum(exp(gm(:,j)));
       media=modelo.means{j+1};
       
       var=0;
       for t=1:length(X)
          var=var+exp(gm(t,j))*(X(t,:)'-modelo.means{j+1})*(X(t,:)-modelo.means{j+1}'); 
       end
       modelo.vars{j+1}=var/sum(exp(gm(:,j)));
    end
    
    try
        figure
        plotseq2(X,st,modelo);
        title(['iteracion ', num2str(n-1)])
    catch
        disp('error')
    end
end

%% Resultados finales
format short
disp('Nova matriz a')
modelo.trans

figure
plotseq2(X,st,hmm4);
title('modelo original')

colordef white;

figure
plot(l)
title('Evolucion del Log LK')
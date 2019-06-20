function hmm=traingen(X)

hmm.trans=[0 1   0   0    0;
              0 0.5 0.5 0    0;
              0 0   0.5 0.5  0;
              0 0   0   0.5  0.5;
              0 0   0   0    1;];
for i=1:5
    hmm.means{i}=mean(X)';
    hmm.vars{i}=cov(X);
end
end
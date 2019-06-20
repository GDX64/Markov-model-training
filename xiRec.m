function csiT = xiRec(x,model,alpha,beta)

means = model.means;
vars = model.vars;
model.trans(model.trans<1e-100) = 1e-100;
logTrans = log(model.trans);


numStates = length(means);
nMin = numStates - 2;
[numPts,dim] = size(x);

log2pi = log(2*pi);
for i=1:nMin,
  invSig{i} = inv(vars{i+1});
  logDetVars2(i) = - 0.5 * log(det(vars{i+1})) - log2pi;
end;


for t=1:numPts-1
    for i=1:nMin
       for j=1:nMin
          X = x(t+1,:)-means{j+1}';
          csiT(t,i,j)=alpha(t,i)+logTrans(i+1,j+1)...
              +beta(t+1,j)- 0.5 * (X * invSig{j}) * X' + logDetVars2(j)...
              -logsum(beta(t,:)+alpha(t,:));
       end
    end
end

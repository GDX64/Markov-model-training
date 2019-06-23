function betaT = betaRec(x,means,vars,transitions)

% LOGFWD Log version of the forward procedure
%
%    LOGPROB = LOGFWD(X,MEANS,VARS,TRANSITIONS) returns the likelihood of
%    the 2-dimensional sequence X (one observation per row) with respect to
%    a Markov model with N states having means MEANS and variances VARS
%    (stored in N elements lists with empty matrices as first and last
%    elements to symbolize the entry and exit states) and transition matrix
%    TRANSITIONS.
%      Alternately, LOGFWD(X,HMM) can be used, where HMM is an object of the
%    form:
%       HMM.means = MEANS;
%       HMM.vars = VARS;
%       HMM.trans = TRANSITIONS
%

if nargin == 2,
  model = means;
  means = model.means;
  vars = model.vars;
  model.trans(model.trans<1e-100) = 1e-100;
  logTrans = log(model.trans);
end;

numStates = length(means);
nMinOne = numStates - 1;
[numPts,dim] = size(x);

log2pi = log(2*pi);
for i=2:nMinOne,
  invSig{i} = inv(vars{i});
  logDetVars2(i) = - 0.5 * log(det(vars{i})) - log2pi;
end;

% Initialize the beta vector for the emitting states
beta_ant=[0; logTrans(2:end-1,end)]; %adicionando una dimencion auxiliar
betaT=zeros(nMinOne,numPts);
betaT(:,end)=beta_ant;

% Do the backrward recursion
for t = numPts-1:-1:1
    for i=2:nMinOne
        for j=2:nMinOne
            X = x(t+1,:)-means{j}';
            somatorio(j-1)=logTrans(i,j)+beta_ant(j) ...
            - 0.5 * (X * invSig{j}) * X' + logDetVars2(j);
        end
        betaT(i,t)=logsum(somatorio);
    end
    beta_ant=betaT(:,t);
end;
betaT=betaT(2:end,:)';

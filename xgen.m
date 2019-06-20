function [X,st]=xgen(hmm)

N=size(hmm.trans,1);
st=1;
st(2)=randsample(1:N,1,true,hmm.trans(1,:));
i=2;


while st(i)<N
   X(i-1,:)= mvnrnd(hmm.means{st(i)},hmm.vars{st(i)});
   i=i+1;
   st(i)=randsample(1:N,1,true,hmm.trans(st(i-1),:));       
end

end
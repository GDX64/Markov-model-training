function [decode, lx, ly]=states_decode(st)
decode={};
lx=[]; %legenda x
ly=[]; %legenda y
for i=1:length(st)
    
    switch st(i)
        case 2
            if~(st(i-1)==2)
               decode{end+1}='model 1';
               lx=[lx i];
               ly(end+1)=2;
            end
        case 5
            if~(st(i-1)==5)
               decode{end+1}='model 2';
               lx=[lx i];
               ly(end+1)=5;
            end
    end
end

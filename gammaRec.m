function gammaT = gammaRec(alphaT, betaT)

    numStates = size(alphaT, 2);
    nMinOne = numStates - 1;
    [numPts, h] = size(alphaT);

    for t = 1:numPts
       gammaT(t, :) = (alphaT(t, :) + betaT(t, :)) - logsum(alphaT(t, :) + betaT(t, :));   
    end
end


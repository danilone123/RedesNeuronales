function[deltaW] = CalculateDeltaW(sD,sR, Xi)%CalculateDeltaW(sD,sR, Xi, wOld, index)
    k =1;
    deltaW = k * (sD - sR) * Xi;
end 


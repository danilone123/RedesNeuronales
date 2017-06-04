function[deltai] = calculateDeltaLastLayer(ci, vi, hi)
deltai = gDerivadaTanh(hi) * (ci - vi);
end
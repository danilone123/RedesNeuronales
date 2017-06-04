function[sr] = CalculateSr(w,P)
% width = size(P,2);
% P(width) = [];
% P = [1, P];
sr =  dot(w, P);
sr = sign(sr);
if sr == 0
        sr = -1;
end
end
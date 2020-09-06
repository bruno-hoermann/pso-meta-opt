% load hospital;
% X = [hospital.Age hospital.Weight];
% Y = [20 162; 30 169; 40 168; 50 170; 60 171];
% 
% scale = quantile(X,0.75) - quantile(X,0.25);
% idx = knnsearch(X,X,'K',10,'Distance','seuclidean','Scale', scale);
% 
% bound(X,47,49)

memory = struct('positions',{},'velocities',{},'scores',{})

% memory(1).positions = rand(4,4)
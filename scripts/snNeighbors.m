function neighbors = snNeighbors (positions, xBounds, k)

n = length(positions);

neighbors =zeros(n,k);
for idx = [1:n]
    
 validNeighbors = setdiff(1:n, idx); % exclude self
 neighbors(idx,:) = validNeighbors( randi(length(validNeighbors), 1, k));
end


end
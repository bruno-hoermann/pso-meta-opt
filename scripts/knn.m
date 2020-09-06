function neighbors = knn(positions, xBounds, k)

scale = xBounds(2,:)-xBounds(1,:);%scale = quantile(xBounds,0.75) - quantile(xBounds,0.25);
neighbors = knnsearch(positions,positions,'K',k,'Distance','seuclidean','Scale', scale);
       
end
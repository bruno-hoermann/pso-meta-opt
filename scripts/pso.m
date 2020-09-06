function r = pso(popSize, xBounds, dxBounds, opt)
   
    % population size, number of parameters, bounds (2 x numParams)
    numParams = 3;
    
    %% initialize positions and velocities

    xLowerBounds = xBounds(1,:) .* ones(popSize, numParams);
    xUpperBounds = xBounds(2,:) .* ones(popSize, numParams);
    positions = xLowerBounds + (xUpperBounds-xLowerBounds).*rand(popSize, numParams);
    
    % choose initialization methods
    switch opt.velocityInit
    case 'zero'
        velocities = zeros(popSize, numParams);
    case 'rand'
        dxLowerBounds = dxBounds(1,:) .* ones(popSize, numParams);
        dxUpperBounds = dxBounds(2,:) .* ones(popSize, numParams);
        velocities = dxLowerBounds + (dxUpperBounds-dxLowerBounds).*rand(popSize, numParams);
    end
    
    switch opt.topology
    case 'k-nearest'
        neighborsFun = @knn;
    case 'static_random'
        neighborsFun = @srNeighbors
    end
    
    

    % initially the first positions are the best positions
    bestOwnPositions = positions;
    bestOwnScores = inf(popSize,1);
    
    % remember results after each iteration
    memory = struct('positions',{},'velocities',{},'scores',{});
    
    for iteration = [1:opt.iterations]
       
       % compute objective function values for all
       F = zeros(popSize,2);
       for idx = [1:popSize] %TODO: later use parfor
            %F(idx,:)= simFox(positions(idx,:));
            [v,d] = testFun(positions(idx,:));
            F(idx,:)= [v,d];
       end
       
       % find neighbors
       neighbors = neighborsFun(positions, xBounds, opt.topologySize);
       %TODO: clear douples
       
       % compute best neighbors values
       scores = F(:,1);
       neighScores = scores(neighbors); % scores of neighbors
       
       [bestNeighborsValue,bestNeighborsIdx] = min(neighScores,[],2);
       
       temp =neighbors';
       bestIdx = temp(bestNeighborsIdx); %indices refer to individual numbering
       posBestNeighbors = positions(bestIdx,:);
 
       %compute random vector phi
       phi = [opt.phiLocalMax, opt.phiGlobalMax].*rand(popSize,2);
       
       %update velocities
       velocities = velocities +phi(1).*(bestOwnPositions-positions)+phi(2).*(posBestNeighbors-positions);
       
       %limit velocities
       velocities = bound(velocities,dxBounds);
       
       % update position
       positions = positions + velocities;
       
       
       [bestOwnScores,impr] = min([scores,bestOwnScores], [], 2);
       
       bestOwnPositions = diag(impr == 1)*positions + diag(impr ==2)*bestOwnPositions;
       
       %save results
       memory(iteration).positions = positions;
       memory(iteration).velocities = velocities;
       memory(iteration).scores = scores;
    end
    
    optimum = [0,0,0];
    r = memory;%[optimum, memory];
end
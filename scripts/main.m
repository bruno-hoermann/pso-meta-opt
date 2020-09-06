popSize = 20;
opt.velocityInit = 'rand';
opt.topology = 'k-nearest';%fixed,
opt.topologySize = 5;
opt.phiLocalMax = 0.1;
opt.phiGlobalMax = 0.05; 
opt.iterations = 100;

xBounds = [-3, -3, -70;
           3, 3,-60];
dxBounds = [-0.3, -0.3, -30;
           0.3, 0.3,30];


r = pso(popSize, xBounds, dxBounds, opt)
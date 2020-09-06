% v, gm_h, AEP, PEP

gm_h = rand(10000,1);
AEP =  rand(10000,1);
PEP = rand(10000,1);
score= peaks(gm_h,AEP);
%%Create Scatter3 plot with CDATA value Z
scatter3(gm_h(:),AEP(:),PEP(:),'CData',score)
colorbar

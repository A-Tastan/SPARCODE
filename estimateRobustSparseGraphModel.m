%% This function estimates a robust sparse graph model W_tilde
% 
% For details see:
% [1] A. Tastan, Michael Muma, and Abdelhak M. Zoubir,"Sparsity-aware
%     Robust Community Detection (SPARCODE).", Signal Processing.(accepted)
%
% 
% Copyright (C) 2021  Aylin Tastan. All rights reserved.
% 
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <https://www.gnu.org/licenses/>.
% 
% Inputs:
%       W               : An affinity matrix of size n x n
%       rho_hat         : A real number, estimated penalty parameter 
%       maxIt           : Maximum number of iterations for Lasso
%                         regularization
%       Tol             : Tolerance level for Lasso regularization
%       plotting        : Plotting option
% Outputs:
%       W_tilde         : Estimated robust sparse graph model of size
%                         n_tilde x n_tilde
%       degrees_W_tilde : Degrees of the estimated robust sparse affinity 
%                         of size n_tilde x 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [W_tilde,degrees_W_tilde]=estimateRobustSparseGraphModel(W,rho_hat,maxIt,Tol,plotting)

%% Estimate the sparse affinity matrix for the estimated penalty parameter
W_hat=estimateSparseAffinityMatrix(W,rho_hat,maxIt,Tol);
 
%% Find a Threshold to eliminate the negligible similarity coefficients from the model
sorted_W_hat=sort(W_hat);
u=mean(sorted_W_hat,2); %Simplified similarity coefficients vector
GMModel = fitgmdist(u,2,'CovarianceType','diagonal');
est_prob = posterior(GMModel,u);
[~,ind_thr]=min(abs((est_prob(:,1)-est_prob(:,2)))); %T=argmin|v_i,2-v_i,1|
Thr=u(ind_thr);

%% Cut the edges in the estimated sparse graph model whose edge weight are smaller than the threshold
indices = find(W_hat(:)<Thr);
W_hat(indices) = 0;

%% Detect outliers and form the affinity using estimated outlier-free feature vectors
degrees=sum(W_hat~=0,2);
[ind_outlierfree,~]=find(degrees);
degrees_W_tilde=degrees(ind_outlierfree);
W_tilde=W_hat(ind_outlierfree,ind_outlierfree);

%Plot estimated robust sparse graph model
if(plotting==1)
    figure(2);
    G=graph(W_hat);
    p=plot(G,'layout','force3');
    p.MarkerSize=4.5;
    p.LineWidth=0.0001;
    ind_est_outliers=find(degrees==0);
    p.EdgeColor=[0.5843    0.6000    0.7804];
    highlight(p,ind_est_outliers,'NodeColor','r','Marker','x');
    box off
    axis off   
end%endif

end%endfunction
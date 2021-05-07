%%The demo file implements 100 Monte Carlo experiments for SPARCODE.
% 
%  The source codes can be freely used for non-commercial use only. 
%  Please make appropriate references to our article:
% 
% [1] A. Tastan, Michael Muma, and Abdelhak M. Zoubir,"Sparsity-aware
%     Robust Community Detection (SPARCODE).", Signal Processing.(accepted)
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
% !NOTE : This code uses an additional function that is named "LassoShooting". 
%         The implementations use the same default parameters as follows: 
%         maxIt=100,Tol=1e-3,standardize=false. The "LassoShooting" code
%         is available in:
% 
%         http://publish.illinois.edu/xiaohuichen/code/graphical-lasso/
% 
%         or explicitly :
% 
%         https://sourceforge.net/projects/sparsemodels/files/Group%20Lasso%20Shooting/
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

close all;
clear all;
warning off;

%% User inputs
N_rho_initial=5; 
N_rho=5; 
rho_initial_min=0.1;
rho_initial_max=0.99; 
maxIt=10; 
Tol=1e-3; 
W_opt='Scenario1'; 
plotting=0; 
  

for iter=1:100
%%Generate a synthetic affinity matrix
[W, num_nodes_total, num_communities]=generateAffinity(W_opt,plotting);

%%Perform Sparsity-aware Robust Community Detection(SPARCODE)
[est_num_com, est_com_mod]=performSparsityAwareRobustCommunityDetection(W,N_rho_initial,N_rho,rho_initial_min,rho_initial_max,maxIt,Tol,plotting);
%To evaluate conductance (optional)
% [est_num_com, est_com_mod,est_com_cond]=performSparsityAwareRobustCommunityDetection(W,N_rho_initial,N_rho,rho_initial_min,rho_initial_max,maxIt,Tol,plotting);

K_hat_cand(iter)=est_num_com;
Q_hat_cand(iter)=est_com_mod;
end

K_hat=mode(K_hat_cand); %estimated community number
Q_hat=mean(Q_hat_cand(find(K_hat_cand==K_hat))); %modularity score

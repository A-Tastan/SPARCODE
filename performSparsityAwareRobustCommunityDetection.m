%% Sparsity-aware Robust Community Detection(SPARCODE)
% 
%  The source codes can be freely used for non-commercial use only. 
%  Please make appropriate references to our article:
%  [1] A. Tastan, Michael Muma, and Abdelhak M. Zoubir,"Sparsity-aware
%      Robust Community Detection (SPARCODE).", Signal Processing.(accepted)
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
%
% !NOTE : This function uses an additional function "LassoShooting". 
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
% Inputs:
%       W               : An affinity/similarity matrix of size n x n
%       N_rho_initial   : Positive scalar, number of the penalty parameter 
%                         samples for the initialization (default=5)
%       N_rho           : Positive scalar, number of the penalty parameter                   
%                         samples for the second step (default=5)
%       rho_initial_min : Minimum value of the penalty parameter for
%                         the initialization (default=0.1)
%       rho_initial_max : Maximum value of the penalty parameter for the
%                         initialization (default=0.99)
%       maxIt           : Maximum number of iterations for the Lasso
%                         regularization (default=100)
%       Tol             : Tolerance level for the Lasso regularization
%                         (default=1e-3)
%       plotting        : Plotting option (default=0)
%       
% Outputs:
%        est_num_com: Estimated number of communities
%        est_com_mod: Modularity score of the partition
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [est_num_com, est_com_mod]=performSparsityAwareRobustCommunityDetection(W,N_rho_initial,N_rho,rho_initial_min,rho_initial_max,maxIt,Tol,plotting)
%function [est_num_com, est_com_mod,est_com_cond]=performSparsityAwareRobustCommunityDetection(W,N_rho_initial,N_rho,rho_initial_min,rho_initial_max,maxIt,Tol,plotting)
if(nargin<8)
    plotting=0;
end
if(nargin<7 || isempty(Tol))
    Tol=1e-3;
end
if(nargin<6 || isempty(maxIt))
    maxIt=100;
end
if(nargin<5 || isempty(rho_initial_max))
    rho_initial_max=0.99;
end
if(nargin<4 || isempty(rho_initial_min))
    rho_initial_min=0.1;
end
if(nargin<3 || isempty(N_rho))
    N_rho=5;
end
if(nargin<2 || isempty(N_rho_initial))
    N_rho_initial=5;
end
if(nargin<1 || isempty(W))
   error('Not enough input arguments...\n');
end


%% STEP 1 : ESTIMATING ROBUST SPARSE GRAPH MODEL
%% Step 1.1: Sparsity Optimization

%% Step 1.1.1: Initialization
%Define an initial penalty parameter set
increasement=(rho_initial_max-rho_initial_min)/(N_rho_initial-1);
initial_rho_set=rho_initial_min:increasement:rho_initial_max;

%Calculate polarization scores for the initial penalty parameter set
initial_polarization_vec=calculatePolarizationScoreSet(W,initial_rho_set,maxIt,Tol);

%Regenerate the penalty parameter set
rho_set=regeneratePenaltySet(initial_rho_set,initial_polarization_vec,N_rho);

%% Step 1.1.2: Penalty Parameter Selection
%Recalculate polarization scores for the regenerated penalty parameter set
polarization_vec=calculatePolarizationScoreSet(W,rho_set,maxIt,Tol);

%Apply spline interpolation and estimate the penalty parameter
rho_hat=estimatePenaltyParameter(rho_set,polarization_vec);

%% Step 1.2: Robustness and Outlier Detection
[W_tilde,degrees_W_tilde]=estimateRobustSparseGraphModel(W,rho_hat,maxIt,Tol,plotting);

%% STEP 2: FAST SPECTRAL PARTITION
[est_num_com,est_com_mod]=FastSpectralPartitioning(W_tilde,degrees_W_tilde);
%[est_num_com,est_com_mod,est_com_cond]=FastSpectralPartitioning(W_tilde,degrees_W_tilde);


end%functionend
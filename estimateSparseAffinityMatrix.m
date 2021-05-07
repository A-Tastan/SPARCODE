%% This function estimates a sparse affinity matrix using Graphical Lasso
% 
% For details see:
% [1] A. Tastan, Michael Muma, and Abdelhak M. Zoubir,"Sparsity-aware
%     Robust Community Detection (SPARCODE).", Signal Processing.(accepted)
% [2] J. Friedman, T. Hastie and R. Tibshirani, "Sparse inverse covariance
%     matrix estimation with the graphical lasso", Biostat. vol. 9, 
%     pp. 432-441, 2008.
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
%        W        : An affinity matrix of size n x n
%        rho      : A positive real number, penalty parameter
%        maxIt    : A positive integer, maximum number of iterations
%        Tol      : A positive integer, convergence tolerance level
%
% Output:
%         W_hat   : An estimated sparse affinity matrix of size n x n
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function W_hat=estimateSparseAffinityMatrix(W,rho,maxIt,Tol)

%% Initialization
S=cov(W); 
p = size(S,1);
S_hat = S + rho * eye(p);  
S_hat_old = S_hat;
i=0;

%% Apply Lasso Regularization
while i < maxIt
    i = i+1;
    for j=p:-1:1
        jminus = setdiff(1:p,j);
        [V D] = eig(S_hat(jminus,jminus)); %eigenvalue decomposition where V:eigenvectors matrix, D:diagonal matrix of eigenvalues
        d = diag(D); 
        X = V * diag(sqrt(d)) * V'; % S_hat_11^(1/2)
        Y = V * diag(1./sqrt(d)) * V' * S(jminus,j);    % S_hat_11^(-1/2) * s_12
        %beta_hat = performLassoShooting(X, Y, rho, maxIt, Tol); 
        beta_hat = lassoShooting(X, Y, rho, maxIt, Tol,false); 
        S_hat(jminus,j) = S_hat(jminus,jminus) * beta_hat; %s_hat_12 = S_hat_11 * beta_hat
        S_hat(j,jminus) = S_hat(jminus,j)';
        
        %Stopping criteria 1: Continue algorithm until edges are cut down
        %in the estimated sparse affinity matrix
        Theta = S_hat^-1;
        Theta=Theta-diag(diag(Theta));
        [tf,~]=find(~any(Theta));
        if~(isempty(tf))
          Theta = S_hat_old^-1; 
          W_hat=abs(Theta); %W_hat=|Theta|
          W_hat=W_hat-diag(diag(W_hat)); %zero diagonal
          W_hat=(W_hat+W_hat.')/2; %symmetric
          return;
        end%endif
        
    end%endfor
    
    %Stopping criteria 2: Continue algorithm until converge
    if norm(S_hat-S_hat_old,1) < Tol
        break; 
    end%endif
    
    S_hat_old = S_hat;
    
end%endwhile
    
Theta = S_hat^-1;

%Sign operator does not considered in the estimated sparse graph model, W_hat=|Theta|
W_hat=abs(Theta);

%A zero diagonal and symmetric sparse affinity matrix
W_hat=W_hat-diag(diag(W_hat));
W_hat=(W_hat+W_hat.')/2;
 

end%endfunction
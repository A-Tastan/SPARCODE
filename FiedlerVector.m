%% This function estimates the Fiedler vector
% 
% For details see:
% [1] M. Belkin and P. Niyogi, “Laplacian eigenmaps for dimensionality
%     reduction and data representation,” Neural Comput., vol. 15, 
%     pp. 1373-1396, 2003
% [2] A. Tastan, Michael Muma, and Abdelhak M. Zoubir,"Sparsity-aware
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
% Fiedler vector :eigenvector associated with second smallest eigenvalue
% Input:
%      W : An affinity matrix of size n x n
% Output:
%      fiedler_vec : an estimated Fiedler vector of size n x 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function fiedler_vec=FiedlerVector(W)

%% Get diagonal weight matrix D
D=diag(sum(W));

%% Compute associated Laplacian matrix
L=D-W;

%% Perform the Fiedler vector estimation for SPARCODE or SPARCODE_F
%Run SPARCODE for small scale networks
if(size(W,1)<=1000)
    [eigenvector_mat,diag_eigenvalue_mat]=eig(L);
    [sorted_eigenvalues,ind_sorted_eigenvalues]=sort(diag(diag_eigenvalue_mat));
    fiedler_vec=eigenvector_mat(:,ind_sorted_eigenvalues(2));
%Run SPARCODE_F for large scale networks    
else 
    [eigenvector_mat,~]=eigs(L,2,'smallestreal');
    fiedler_vec=eigenvector_mat(:,2);
end%endif

end%endfunction
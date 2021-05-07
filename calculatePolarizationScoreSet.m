%%This function calculates the polarization scores
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
%       W           : An affinity matrix of size n x n
%       rho_set     : A set of real numbers of size N_rho x 1
%       maxIt       : A positive integer, maximum number of iterations
%       Tol         : A positive integer, convergence tolerance level
%
% Output:
%       polarization_vec: A vector of polarization scores for the given 
%                         penalty parameter set of size N_rho x 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function polarization_vec=calculatePolarizationScoreSet(W,rho_set,maxIt,Tol)


%% Calculate polarization scores and stack into a vector
for i=1:length(rho_set)
    
    %Estimate sparse affinity matrix for the ith penalty parameter
     W_hat=estimateSparseAffinityMatrix(W,rho_set(i),maxIt,Tol);
     
    %Polarization score of the ith estimate, the coefficients must be normalized
     polarization_vec(i)=calculatePolarizationScore(normc(W_hat));

end%endfor


end%endfunction

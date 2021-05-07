%%This function calculates the polarization score for W_hat
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
% Input:  
%       W_hat : An estimated affinity matrix of size n x n
% 
% Output:
%       polarization_score: A real number, polarization score for W_hat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function polarization_score=calculatePolarizationScore(W_hat)

%%Estimate the Fiedler vector 
y_hat=FiedlerVector(W_hat);

%%Generate two subsets
[sorted_y_hat,~]=sort(y_hat);
subspace_1=sorted_y_hat(sorted_y_hat<0);
subspace_2=sorted_y_hat(sorted_y_hat>0);

%%Calculate polarization of the partition
polarization_score=median(subspace_2)-median(subspace_1);

end

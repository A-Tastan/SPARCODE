%% This function calculates the modularity of the partition
% 
% For details, see:
% [1] A. Clauset, M. E. J. Newman, and C. Moore, "Finding community
%     structure in very large networks," Physc. Rev. E., vol.70,pp.066111,
%     2004.
% [2] A. Tastan, Michael Muma, and Abdelhak M. Zoubir,"Sparsity-aware
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
% Inputs:
%       C_hat           : estimated label vector of size n_tilde x 1
%       W_tilde         : Estimated robust sparse graph model of size
%                         n_tilde x n_tilde
% Outputs:
%       Q               : A real number, modularity of the partition 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Q = calculate_Modularity(C_hat,W_tilde)

m = sum(sum(W_tilde));
Q = 0;
communities = unique(C_hat);
for j=1:length(communities)
    Cj = find(C_hat==communities(j));
    Ec = sum(sum(W_tilde(Cj,Cj)));
    Et = sum(sum(W_tilde(Cj,:)));
    if Et>0
        Q = Q + Ec/m-(Et/m)^2;
    end
end

end

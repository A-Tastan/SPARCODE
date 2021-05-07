%%This function calculates the conductance of the partition
% 
% For details see
% [1] Shi, Jianbo, and Jitendra Malik. "Normalized cuts and image 
%     segmentation." IEEE Trans. Pattern Anal. Mach. Intell.22.8 (2000:888-905.
% [2] J. J. Yang and J. Leskovec, “Defining and evaluating network 
%     communities based on groundtruth,”Knowledge and Information Systems,
%     vol. 42, no. 1, pp. 181–213, 2015.
% [3] A. Tastan, Michael Muma, and Abdelhak M. Zoubir,"Sparsity-aware
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
% Conductance=c_s/(2m_s+c_s)
% c_s :  total connection from nodes in a cluster to other clusters
% m_s :  total connection between nodes of a cluster
% 
% Inputs:
%       C_hat           : estimated label vector of size n_tilde x 1
%       W_tilde         : Estimated robust sparse graph model of size
%                         n_tilde x n_tilde
% Outputs:
%       Conductance     : a real number, conductance score of the partition 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Conductance=calculateConductance(C_hat,W_tilde)

totaledgesum = sum(sum(W_tilde));
c_s_sum=0;
m_s_sum=0;
COMu = unique(C_hat);
for j=1:length(COMu)
    Cj = find(C_hat==COMu(j));
    not_Cj=find(C_hat~=COMu(j));
    m_s = sum(sum(W_tilde(Cj,Cj))); %edges within the communities
    c_s = sum(sum(W_tilde(Cj,not_Cj))); %edges between different communities
    m_s_sum=m_s+m_s_sum;
    c_s_sum=c_s+c_s_sum;
end

Conductance=c_s_sum/totaledgesum;

end

            
            

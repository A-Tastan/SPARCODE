%% This function creates an affinity matrix based on the selected scenario.
% 
% For details about the synthetic data sets :
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
%       W_opt    : A string for the selected scenario option
%       plotting : Plotting option
% 
% Outputs:
%        W               : An affinity matrix of size n x n for the
%                          selected scenario option
%        num_nodes_total : Number of nodes for the designed graph
%        num_communities : Number of communities hidden in the designed graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [W, num_nodes_total, num_communities]=generateAffinity(W_opt,plotting)

%% Generation of the affinity matrix for the selected scenario
if(W_opt=='Scenario1')
     
     [W, num_nodes_total, num_communities]=generateAffinityScenario1(plotting);
    
else if(W_opt=='Scenario2')
        
     [W, num_nodes_total, num_communities]=generateAffinityScenario2(plotting);
    
    end%endelseif
end%endif

end%functionend
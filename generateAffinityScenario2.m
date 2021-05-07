%% This function generates an affinity matrix for Scenario 2.
% 
% For details about Scenario 2, see:
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
% An undirected weighted graph consisting of three communities in the 
% presence of outliers is created by using the community block density-based 
% variant of the SBM for Scenario 2. The communities are correlated with 
% each other in addition to exhibiting strong correlations within. The 
% outliers correlate equally with all communities with negligibly small 
% correlation coefficients.
% Number of nodes for three object communities:
%   Community 1: 66 
%   Community 2: 102 
%   Community 3: 90
% Number of outliers : 42
%
% Input:
%       plotting : Plotting option
% 
% Outputs:
%        W               : An affinity matrix of size n x n
%        num_nodes_total : Number of nodes for the designed graph
%        num_communities : Number of communities hidden in the designed graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [W, num_nodes_total, num_communities]=generateAffinityScenario2(plotting)


%% Define communities and outliers
community_1=66;
community_2=community_1+102;
community_3=community_2+90;
outliers=community_3+42;

%% Define similarities
W=[];
rng('shuffle');

%Similarities for the Community 1
for j=1:community_1
    %Similarity within the community
    for i=1:community_1 
        W(i,j)=0.7+0.29*rand; 
    end
    %Similarity with Community 2
    for i=(community_1+1):community_2
        W(i,j)=0.01+0.29*rand;
    end
    %Similarity with Community 3
    for i=(community_2+1):community_3 
        W(i,j)=0;  
    end
    %Similarity with outliers
    for i=(community_3+1):outliers
        W(i,j)=0;  
    end     
end

%Similarities for the Community 2
for j=(community_1+1):community_2
    %Similarity with Community 1
    for i=1:community_1
        W(i,j)=0.01+0.29*rand;
    end
    %Similarity within the community
    for i=(community_1+1):community_2
        W(i,j)=0.8+0.19*rand;
    end
    %Similarity with Community 3
    for i=(community_2+1):community_3
        W(i,j)=0.27+0.10*rand;
    end
    %Similarity with outliers
    for i=(community_3+1):outliers
        W(i,j)=0;
    end
end

%Similarities for the Community 3
for j=(community_2+1):community_3
    %Similarity with Community 1
    for i=1:community_1 
        W(i,j)=0;
    end
    %Similarity with Community 2
    for i=(community_1+1):community_2
        W(i,j)=0.27+0.10*rand;
    end
    %Similarity within the community
    for i=(community_2+1):community_3
        W(i,j)=0.7+0.24*rand;
    end
    %Similarity with outliers
    for i=(community_3+1):outliers
        W(i,j)=0; 
    end    
end

%Similarities for the outliers
for j=(community_3+1):outliers
    %Similarity with Community 1,2,3 
        for i=1:outliers
        W(i,j)=0.01+0.05*rand;
        end 
end

%Make the affinity matrix symmetric, zero diagonal
  W=(W+W.')/2;
  W=W-diag(diag(W));
  
%% Define the number of nodes and communities
  num_nodes_total=size(W,1);
  num_communities=3;
  
%Plot the designed graph
if(plotting==1)
   ind_clust1=1:66;
    ind_clust2=67:169;
    ind_clust3=170:260;
    ind_outliers=261:300;
    figure(1);
    G=graph(W);
    p=plot(G,'layout','force3');
    p.MarkerSize=4.5;
    p.LineWidth=0.0001;
    p.EdgeColor=[0.5843    0.6000    0.7804]; %op3
    highlight(p,ind_clust1,'NodeColor',[0 .75 1],'Marker','p');
    highlight(p,ind_clust2,'NodeColor',[0.73 1 0.6],'Marker','s');
    highlight(p,ind_clust3,'NodeColor',[0.9290 0.6940 0.1250],'Marker','d');
    highlight(p,ind_outliers,'NodeColor','r','Marker','x');
    box off
    axis off
end

end%endfunction


%%This function generates an affinity matrix for Scenario 1.
% 
% For details about Scenario 1, see:
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
% An undirected weighted graph model is considered. It is a variant of the 
% stochastic block model (SBM) with constant densities within and between 
% communities, respectively, where the nodes belonging to the same community
% are more densely connected. In the designed undirected weighted graph 
% model, the first six communities inhibit correlation between communities 
% in addition to correlations within the community. In contrast,the seventh
% community only has correlations within the community. Moreover, the density 
% of the seventh community is assumed to be higher compared to that of the 
% other six.
% Number of nodes for seven object communities:
%   Community 1: 45 
%   Community 2: 40 
%   Community 3: 55 
%   Community 4: 42 
%   Community 5: 37 
%   Community 6: 46 
%   Community 7: 35 
% Input:
%       plotting : Plotting option
% 
% Outputs:
%        W               : An affinity matrix of size n x n
%        num_nodes_total : Number of nodes for the designed graph
%        num_communities : Number of communities hidden in the designed graph
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [W, num_nodes_total, num_communities]=generateAffinityScenario1(plotting)

%%Define communities
community_1=45;
community_2=community_1+40;
community_3=community_2+55;
community_4=community_3+42;
community_5=community_4+37;
community_6=community_5+46;
community_7=community_6+35;

%%Define similarities
W=[];
rng('shuffle');
%Similarities for the Community 1
for j=1:community_1
    %Similarity within the community
    for i=1:community_1
        W(i,j)=0.8+0.19*rand;  
    end
    %Similarity with Community 2
    for i=(community_1+1):community_2
        W(i,j)=0.005+0.0045*rand; 
    end
    %Similarity with Community 3
    for i=(community_2+1):community_3
        W(i,j)=0.35+0.10*rand;
    end
    %Similarity with Community 4
    for i=(community_3+1):community_4
        W(i,j)=0;  
    end  
    %Similarity with Community 5
    for i=(community_4+1):community_5
        W(i,j)=0;
    end
    %Similarity with Community 6
    for i=(community_5+1):community_6
        W(i,j)=0.25+0.05*rand;
    end
    %Similarity with Community 7
    for i=(community_6+1):community_7
        W(i,j)=0;
    end
end

%Similarities for the Community 2
for j=(community_1+1):community_2
    %%Similarity with Community 1
    for i=1:community_1
        W(i,j)=0.005+0.0045*rand; 
    end
    %Similarity within the community
    for i=(community_1+1):community_2
        W(i,j)=0.7+0.10*rand;
    end
    %Similarity with Community 3
    for i=(community_2+1):community_3 
        W(i,j)=0;
    end
    %Similarity with Community 4
    for i=(community_3+1):community_4
        W(i,j)=0.35+0.10*rand;  
    end
    %Similarity with Community 5
    for i=(community_4+1):community_5 
        W(i,j)=0.19+0.15*rand; 
    end
    %Similarity with Community 6
    for i=(community_5+1):community_6
        W(i,j)=0; 
    end
    %Similarity with Community 7
    for i=(community_6+1):community_7  
        W(i,j)=0;  
    end   
end

%Similarities for the Community 3
for j=(community_2+1):community_3
    %Similarity with Community 1
    for i=1:community_1
        W(i,j)=0.35+0.10*rand;
    end
    %Similarity with Community 2
    for i=(community_1+1):community_2
        W(i,j)=0; 
    end
    %Similarity within the community
    for i=(community_2+1):community_3
        W(i,j)=0.9+0.09*rand;  
    end
    %Similarity with Community 4
    for i=(community_3+1):community_4
        W(i,j)=0;  
    end  
    %Similarity with Community 5
    for i=(community_4+1):community_5  
        W(i,j)=0;  
    end
    %Similarity with Community 6
    for i=(community_5+1):community_6  
        W(i,j)=0;
    end
    %Similarity with Community 7
    for i=(community_6+1):community_7
        W(i,j)=0;   
    end       
end

%Similarities for the Community 4
for j=(community_3+1):community_4
    %Similarity with Community 1
    for i=1:community_1  
        W(i,j)=0; 
    end
    %Similarity with Community 2
    for i=(community_1+1):community_2   
        W(i,j)=0.35+0.10*rand;  
    end
    %Similarity with Community 3
    for i=(community_2+1):community_3   
        W(i,j)=0; 
    end
    %Similarity within the community
    for i=(community_3+1):community_4  
        W(i,j)=0.85+0.14*rand;      
    end   
    %Similarity with Community 5
    for i=(community_4+1):community_5  
        W(i,j)=0; 
    end
    %Similarity with Community 6
    for i=(community_5+1):community_6  
        W(i,j)=0; 
    end
    %Similarity with Community 7
    for i=(community_6+1):community_7 
        W(i,j)=0;   
    end   
end

%Similarities for the Community 5
for j=(community_4+1):community_5
    %Similarity with Community 1
    for i=1:community_1  
        W(i,j)=0;  
    end
    %Similarity with Community 2
    for i=(community_1+1):community_2 
        W(i,j)=0.19+0.15*rand;  
    end
    %Similarity with Community 3
    for i=(community_2+1):community_3 
        W(i,j)=0; 
    end
    %Similarity with Community 4
    for i=(community_3+1):community_4
        W(i,j)=0; 
    end
    %Similarity within the community
    for i=(community_4+1):community_5
        W(i,j)=0.79+0.15*rand;
    end
    %Similarity with Community 6
     for i=(community_5+1):community_6
        W(i,j)=0;
     end
    %Similarity with Community 7
     for i=(community_6+1):community_7 
        W(i,j)=0;   
     end
end

%Similarities for the Community 6
for j=(community_5+1):community_6
    %Similarity with Community 1
    for i=1:community_1
        W(i,j)=0.25+0.05*rand;  
    end
    %Similarity with Community 2
    for i=(community_1+1):community_2 
        W(i,j)=0; 
    end
    %Similarity with Community 3
    for i=(community_2+1):community_3
        W(i,j)=0; 
    end
    %Similarity with Community 4
    for i=(community_3+1):community_4
        W(i,j)=0;
    end
    %Similarity with Community 5
    for i=(community_4+1):community_5
        W(i,j)=0;
    end
    %Similarity within the community
    for i=(community_5+1):community_6  
        W(i,j)=0.85+0.14*rand;   
    end
    %Similarity with Community 7
    for i=(community_6+1):community_7
        W(i,j)=0;
    end
end
  
%Similarities for the Community 7
for j=(community_6+1):community_7
    %Similarity with Community 1
    for i=1:community_1
        W(i,j)=0; 
    end
    %Similarity with Community 2
    for i=(community_1+1):community_2 
        W(i,j)=0; 
    end
    %Similarity with Community 3
    for i=(community_2+1):community_3
        W(i,j)=0; 
    end
    %Similarity with Community 4
    for i=(community_3+1):community_4  
        W(i,j)=0;   
    end 
    %Similarity with Community 5
    for i=(community_4+1):community_5  
        W(i,j)=0;
    end
    %Similarity with Community 2
    for i=(community_5+1):community_6 
        W(i,j)=0; 
    end
    %Similarity within the community
    for i=(community_6+1):community_7 
        W(i,j)=0.95+0.04*rand; 
     end
end

%Make the affinity matrix symmetric, zero diagonal
  W=(W+W.')/2;
  W=W-diag(diag(W));
  
%%Define number of nodes and communities
  num_nodes_total=size(W,1);
  num_communities=7;
  
%Plot the designed graph
if(plotting==1)
    ind_clust1=1:45;
    ind_clust2=46:85;
    ind_clust3=86:140;
    ind_clust4=141:182;
    ind_clust5=183:219;
    ind_clust6=220:265;
    ind_clust7=266:300;
    figure(1);
    G=graph(W);
    p=plot(G,'layout','force3');
    p.MarkerSize=4.5;
    p.LineWidth=0.0001;
    p.EdgeColor=[0.5843    0.6000    0.7804];
    highlight(p,ind_clust1,'NodeColor',[0 .75 1],'Marker','p');
    highlight(p,ind_clust2,'NodeColor',[0.73 1 0.6],'Marker','s');
    highlight(p,ind_clust3,'NodeColor',[0.9290 0.6940 0.1250],'Marker','d');
    highlight(p,ind_clust4,'NodeColor',[0.56 0.2 0.63],'Marker','h');
    highlight(p,ind_clust5,'NodeColor',[0 0.29 0.25],'Marker','p');
    highlight(p,ind_clust6,'NodeColor',[0.6353   0.0784   0.1843]);
    highlight(p,ind_clust7,'NodeColor',[0.0157    0.4118    0.7804],'Marker','v');
    box off
    axis off
end%endif

end%endfunction








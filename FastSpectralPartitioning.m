%% This function performs a fast spectral partitioning
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
%       W_tilde         : Estimated robust sparse graph model of size
%                         n_tilde x n_tilde
%       degrees_W_tilde : Degrees of the estimated robust sparse affinity 
%                         of size n_tilde x 1
% Outputs:
%        est_num_com    : Estimated number of communities
%        est_com_mod    : Modularity of the partition with respect to the 
%                         estimated community number                   
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [est_num_com,est_com_mod]=FastSpectralPartitioning(W_tilde,degrees_W_tilde)
% function [est_num_com,est_com_mod,est_com_cond]=FastSpectralPartitioning(W_tilde,degrees_W_tilde)

%% Estimate K_min and K_max 
[counts,centers] = histcounts(degrees_W_tilde,max(degrees_W_tilde)-min(degrees_W_tilde));
p = counts / sum(counts);  %probability of occurence of degrees
ind_h=find(p>median(p));
h=centers(ind_h);  %highly probable degrees
K_min=round(length(degrees_W_tilde)/(max(h)+1)); %K_min=n_tilde/(h_max+1)
K_max=round(length(degrees_W_tilde)/(min(h)+1)); %K_max=n_tilde/(h_min+1)
K_set=K_min:1:K_max;

%% Estimate the Fiedler vector associated with the estimated graph model
y_tilde=FiedlerVector(normc(W_tilde));
[sorted_y_tilde,ind_sorted_y_tilde]=sort(y_tilde);

%% Partitioning
for i=1:length(K_set)

q_i=mod(length(degrees_W_tilde),K_set(i)); %number of initially ignored mappings

if(q_i==0)
    
   for j=1:K_set(i)
      samp=fix(length(sorted_y_tilde)/K_set(i));
      C_hat(ind_sorted_y_tilde(((j-1)*samp+1):(j*samp)))=j; %label vector c_hat
      cent(j)=mean(sorted_y_tilde(((j-1)*samp+1):(j*samp))); %centroids
   end
   
else
    %The standard deviation of the set containing its two immediate neighbors 
    Std_y_tilde(1)=std(sorted_y_tilde(1:3)); %first node
    for k=2:(length(sorted_y_tilde)-1)
        Std_y_tilde(k)=std(sorted_y_tilde((k-1):(k+1)));
    end
    Std_y_tilde(length(sorted_y_tilde))=std(sorted_y_tilde((end-2):end)); %last node
    
    %Define initially ignored mapping results
    [~,ind_res]=maxk(Std_y_tilde,q_i); 
    residuals=sorted_y_tilde(ind_res);
    ind_residuals=ind_sorted_y_tilde(ind_res); 
    
    %Apply an initial partition on the complementary vector
    temp_sorted_y_tilde=sorted_y_tilde;
    temp_ind_sorted_y_tilde=ind_sorted_y_tilde;
    temp_sorted_y_tilde(ind_res)=[];  %Remove residuals from sort(y_tilde)
    temp_ind_sorted_y_tilde(ind_res)=[];
    C_hat=zeros(length(degrees_W_tilde),1);
    for j=1:K_set(i)
        samp=fix(length(temp_sorted_y_tilde)/K_set(i));
        C_hat(temp_ind_sorted_y_tilde(((j-1)*samp+1):(j*samp)))=j; %label vector c_hat
        cent(j)=mean(temp_sorted_y_tilde(((j-1)*samp+1):(j*samp))); %centroids
    end
    
    %Assign initially ignored mapping results
    for m=1:q_i
        for n=1:length(cent)
            distances(n)=norm(residuals(m)-cent(n));
        end
        [~,ind_l]=min(distances);
        C_hat(ind_residuals(m))=ind_l;
    end
end

%Calculate modularity of the partition
Q(i) = calculateModularity(C_hat,W_tilde);
% cond(i)=calculateConductance(C_hat,W_tilde); %to evaluate conductance(optional)
end

%% Estimate the community number
[est_com_mod,ind_max_mod]=max(Q);
% est_com_cond=cond(ind_max_mod); %to evaluate conductance(optional)
est_num_com=K_set(ind_max_mod);

end%endfunction
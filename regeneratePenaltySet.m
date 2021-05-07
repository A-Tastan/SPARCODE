%%This function regenerates the set of penalty parameters
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
%       initial_rho_set          : A vector of the penalty parameters of  
%                                  size N_rho_initial x 1
%       initial_polarization_vec : A vector of the polarization scores 
%                                  associated with the initial penalty 
%                                  parameters of size N_rho_initial x 1
%       N_rho                    : Positive scalar, the number of the  
%                                  penalty parameters               
% Output:
%       rho_set                  : A set of regenerated penalty parameters
%                                  of size N_rho x 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rho_set=regeneratePenaltySet(initial_rho_set,initial_polarization_vec,N_rho)

%%Define the minimum and maximum boundaries for the candidate penalty parameters
[~,ind_maxpsc]=max(initial_polarization_vec);
if(ind_maxpsc==length(initial_rho_set))
    rho_min=initial_rho_set(ind_maxpsc-1);
    rho_max=initial_rho_set(ind_maxpsc);
else if(ind_maxpsc==1)
        rho_min=initial_rho_set(ind_maxpsc);
        rho_max=initial_rho_set(ind_maxpsc+1);
    else
        rho_min=initial_rho_set(ind_maxpsc-1);
        rho_max=initial_rho_set(ind_maxpsc+1);
    end
end

%%Define the new penalty parameter set
increasement=(rho_max-rho_min)/(N_rho-1);
rho_set=rho_min:increasement:rho_max;


end%endfunction

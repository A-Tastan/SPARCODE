%% This function performs spline interpolation to estimate the penalty parameter
% 
%  For details see:
% [1] A. Tastan, Michael Muma, and Abdelhak M. Zoubir,"Sparsity-aware
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
%       rho_set          : A set of regenerated penalty parameters
%                          of size N_rho x 1
%       polarization_vec : A vector of polarization scores for given 
%                          penalty parameter set of size N_rho x 1
%       xq               : A scalar for query points (default=1e-3)
%
% Output:
%       rho_hat          : A real number, estimated penalty parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function rho_hat=estimatePenaltyParameter(rho_set,polarization_vec,xq)

if(nargin<3 || isempty(xq))
    xq=1e-3;
end

%% Apply Spline Interpolation
xx = min(rho_set):xq:max(rho_set);
spline_polarization_vec= spline(rho_set,polarization_vec,xx);

%% Estimate penalty parameter
[~,ind_rho_hat]=max(spline_polarization_vec);
rho_hat=xx(ind_rho_hat);

end%endfunction

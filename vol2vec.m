function [data_vec] = vol2vec(data_vol, data_mask, mask_ID)
% [data_vec] = vol2vec(data_vol, data_mask, [mask_ID])
% Utility program to reduce memory usage
% Converts a volume of data into a 'sparse' object of voxel indeces and values
% 
% INPUTS
%   data_vol - data volume (can be 4D)
%   data_mask - Mask, assumed binary unless mask_ID is given a value
%   mask_ID - OPTIONAL, if data_mask is an atlas, use this roi ID number
%
% OUTPUTS
%   data_vec - object with the following 
%       .size - size of data [nx ny nz nt]
%       .values - values in vector format (nt x voxel  )
%       .index - voxel locations in vector format
% 
%  ********* REVISION INFO ************
%  Original Creation Date - May 18, 2012
%  Author - Wayne Lee
%
%  Rev Log
%  12/05/18 - WL - Original Creation

% Check that data and seed volumes are the same size
[nx ny nz nt] = size(data_vol);
[size_data_mask(1) size_data_mask(2) size_data_mask(3) size_data_mask(4)] = size(data_mask);
if [nx ny nz ] ~= [size_data_mask(1) size_data_mask(2) size_data_mask(3)],
    error(['Data ( ' num2str(size(data_vol)) ' ) and mask(' num2str(size(data_mask)) ') have different dimensions'])
end

if ~exist('mask_ID','var') | isempty(mask_ID),
  mask_ID = 1; % default = assume binary mask
end

data_vol_vec = reshape(data_vol,[nx*ny*nz nt])';    % transpose to make [nt x voxel]
data_mask_vec = reshape(data_mask,[nx*ny*nz 1])';   % transpose to make [1 x voxel]

data_vec.index = find(data_mask_vec == mask_ID);
data_vec.size = size(data_vol);
data_vec.values = data_vol_vec(:, data_vec.index);
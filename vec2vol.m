function [data_vol] = vec2vol(data_vec, zero_pad)
% [data_vol] = vec2vol(data_vec)
% Utility program to reduce memory usage, mirror of vol2vec
% Converts a vector object into a volume of data
% 
% INPUTS
%   data_vec - object with the following 
%       .size - size of data [nx ny nz nt]
%       .values - values in vector format (nt x voxel  )
%       .index - voxel locations in vector format
%   zero_pad - OPTIONAL - value of 'blank' voxels (default = 0)
%
% OUTPUTS
%   data_vol - data volume (can be 4D)
% 
%  ********* REVISION INFO ************
%  Original Creation Date - May 18, 2012
%  Author - Wayne Lee
%
%  Rev Log
%  12/05/18 - WL - Original Creation

if length(data_vec.size)==4,
    nt = data_vec.size(4);
else,
    nt = 1;
end

if nargin==1,
    zero_pad = 0;
end

num_vox = prod(data_vec.size(1:3));
data_vec_full = zero_pad * ones([nt num_vox]);   % Create full vector
data_vec_full(:, data_vec.index) = data_vec.values;  % add values
data_vol = reshape (data_vec_full',data_vec.size);    % transpose to get [nx ny nz nt] organization

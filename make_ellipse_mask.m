function [mask] = make_ellipse_mask(rad_x, rad_y, options)
% [mask] = make_ellipse_mask(rad_x, rad_y, options)
%   Makes a binary 2D elliposid mask
%   By default the mask is sized to just contain the ellipse
%   As the mask is constrained by resolution, radius should be in
%   increments of 0.5
% 
%   INPUTS
%       rad_x - radius along the rows
%       rad_y - radius along columns
%       options - possible options
%           .large_grid - [x, y] Make the mask larger than the ellipse
%           .centre - [x,y] Where to center the ellipse (by default it will
%                   be in the centre of large_grid
%           .hollow - make mask hollow
% 
%   OUTPUTS
%       mask - the binary mask, typically just large enough to contain the
%           specified ellipse, different sized if .large_grid is used
% 
%   NOTES
%   Created - 2014 July 8th by Wayne Lee
% 

% Define default options
opt_def = {};
opt_def.large_grid = ceil([2*rad_x, 2*rad_y]);
opt_def.centre = ([rad_x, rad_y])+0.5;
opt_def.hollow = 0;

list_options = fieldnames(opt_def);
num_options = length(list_options);

% if no options are supplied set default options
if nargin < 3,
    options = opt_def;
end

% If options is missing default field, set to default values
for count_opt = 1:num_options,
    opt_name = list_options{count_opt};
    if isfield(options, opt_name) == 0,
        options.(opt_name) = opt_def.(opt_name);
    end
end


mask = zeros(options.large_grid(2), options.large_grid(1));

for count_x = 1:options.large_grid(1),
    for count_y = 1:options.large_grid(2),
%         Current distance
        dist_curr = (abs(count_x - options.centre(1))/rad_x)^2  + ...
            (abs(count_y - options.centre(2))/rad_y)^2;
        if dist_curr <= 1 ,
            mask(count_y, count_x) = 1;
        end
    end
end

if options.hollow
    mask = double(edge(mask));
end
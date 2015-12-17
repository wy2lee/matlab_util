function gen_pretty_pix(fname_subj, afni_ax, afni_sag, afni_cor, options)
% USAGE  gen_pretty_pix(fname_subj, afni_ax, afni_sag, afni_cor, options) 
% Quick program to generate good looking, high resolution pictures
% 
% INPUTS
%   fname_subj - T1 in nifti format
%   afni_ax - Axial slice in Afni
%   afni_sag - Sag slice in Afni
%   afni_cor - Cor slice in Afni
% 
% OUTPUTS
%   Saves a 300dpi uncompressed TIF to disk
% 
% OPTIONS
%   im_range- Image Intensity Range [20 450]
%   resize - Image resizing factor of [4]
%   width - How many slices to average on either side of the target [1]
%   

% OPTIONS - Check if the exist, if not, set default values
if ~exist('options','var') | isempty(options),
   options.im_range = [20 450];   % default = edge connections
end
if ~isfield(options, 'im_range')     %  default connection is edge
    options.im_range = [20 450];     end
if ~isfield(options, 'resize')    
    options.resize = 4;     end
if ~isfield(options,'width')
    options.width = 1; end

slices = [-options.width:options.width];

data =  load_untouch_nii([ fname_subj '.nii']);

[nx ny nz] = size(data.img)

slice_ax = imresize( imrotate(squeeze(mean(data.img(:,:,slices + afni_ax),3)),90),options.resize);
slice_sag = imresize( imrotate(squeeze(mean(data.img(nx-afni_sag + slices,:,:),1)),90),options.resize);
slice_cor = imresize( imrotate(squeeze(mean(data.img(:,ny-afni_cor + slices,:),2)),90),options.resize);

big_img = zeros(nz * options.resize, (2*nx + ny)*options.resize );
big_img(1:(ny*options.resize),1:(nx*options.resize)) = slice_ax;
big_img(1:(nz*options.resize),(nx*options.resize)+[1:(nx*options.resize)]) = slice_cor;
big_img(1:(nz*options.resize),(nx*options.resize)+(nx*options.resize)+[1:(ny*options.resize)]) = slice_sag;

figure, imshow(big_img,options.im_range);

print('-dtiff','-r300',[fname_subj]);

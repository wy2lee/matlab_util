function [poly_coef, stats] = slope_pca(X,Y)
% slope_pca  Uses SVD to calculate the major and minor axis for the 'true'
% correlation and relationship (linear) between two variables. Unlike
% linear regression / correlation which assumes only minimizes fit error
% for the Y-axis, this program calculates the eigenvector which best fits
% the data as a whole

% For example, with linear regression 
%               LINEAR_SLOPE(Y,X) != 1 / LINEAR_SLOPE(X,Y)
% Using SVD/PCA/eigenvectors, 
%               SLOPE_PCA(Y,X) == 1 / SLOPE_PCA(X,Y)
%
% INPUT
%   X - Vector of X-axis data
%   Y - Vector of Y-axis data
%
% OUTPUT
%   eig_vec - 2x2 Matrix, 
%               First row is major axis [slope, intercept]
%               Second row is minor axis
%   stats - structure w/ miscellaneous stats
%       .S - Singluar Values
%       .r2 - % of total variance accounted for by major/minor axis

% Created by - Wayne Lee
% Creation date - 13/11/07

X_mean = mean(X);
Y_mean = mean(Y);

% Remove mean from data before SVD
X_zm = X - X_mean;
Y_zm = Y - Y_mean;

[U , S, V] = svd([X_zm, Y_zm],0);

% Calculate slopes from Eig Vectors
poly_coef = zeros(2,2);
poly_coef(:,1) = V(2,:)./V(1,:);

% Determine X intercepts by projecting mean offsets onto major axis
poly_coef(:,2) = Y_mean - poly_coef(:,1) * X_mean;

% Summary stats for singlar value and % variance
stats.S = max(S,[],2)';
stats.r2 = stats.S.^2 / sum(stats.S.^2 );



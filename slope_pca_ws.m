% Linear regression / correlation typically operates on variable where the
% independent variable (X) is controlled or noise less, and all variance is
% assumed to be in the dependent (Y) variable. IE. the optimization
% criteria is to minimize SSE of Y estimates.

% In cases where X is not a true independent variable (ie. there is
% noise in the X axis as well), linear regression / correlation is the
% incorrect approach for relating two sets of data. In this case, the ideal
% fit is one which minizes by X and Y variance. PCA/SVD to compute the
% major and minor axis is the ideal solution to this problem. A common
% application for this would be to determine the relationship between two
% large sets of 'repeated' data. The choice of what variable is X and which
% variable is Y should have no effect on the calculated slopes.

% percent variance explained is SV^2 / sum(SV^2)

clear all;
close all;

data_A = randn(1000,1);
data_B = data_A + randn(1000,1) ;

data_A = data_A + 5.3;
data_B = data_B + 2.85;
data_A_mean = mean(data_A);
data_B_mean = mean(data_B);

[poly_AB.P , poly_AB.S] = polyfit(data_A, data_B,1);
R_AB = corrcoef(data_A,data_B);
[poly_BA.P , poly_BA.S] = polyfit(data_B, data_A,1);
R_BA = corrcoef(data_B,data_A);

[PCA_AB.poly_coef, PCA_AB.s] = slope_pca(data_A, data_B);
[PCA_BA.poly_coef, PCA_BA.s] = slope_pca(data_B, data_A);

x_range = [floor(min(data_A)) ceil(max(data_A))];
y_range = [floor(min(data_B)) ceil(max(data_B))];
fit_mat = ones(2,2);    fit_mat(:,1) = x_range;

figure, 
subplot(1,2,1)
plot(x_range, fit_mat * poly_AB.P', 'b',...
    x_range, fit_mat * PCA_AB.poly_coef(1,:)' , 'r',...
    x_range, fit_mat * PCA_AB.poly_coef(2,:)' , 'r:',...
    data_A, data_B,'.')
legend(['Linear = ' num2str(poly_AB.P(1),'%4.2f') 'x + ' num2str(poly_AB.P(2),'%4.2f') ...
    '; r2 = ' num2str(R_AB(1,2),'%4.2f')], ...
    ['PCA = ' num2str(PCA_AB.poly_coef(1,1),'%4.2f') 'x + ' num2str(PCA_AB.poly_coef(1,2),'%4.2f') ...
    '; r2 = ' num2str(PCA_AB.s.r2(1),'%4.2f')]);
axis([x_range y_range]); title('Data A vs Data B');
xlabel('Data A'); ylabel('Data B');

x_range = [floor(min(data_B)) ceil(max(data_B))];
y_range = [floor(min(data_A)) ceil(max(data_A))];
fit_mat = ones(2,2);    fit_mat(:,1) = x_range;

subplot(1,2,2)
plot(x_range, fit_mat * poly_BA.P', 'b',...
    x_range, fit_mat * PCA_BA.poly_coef(1,:)' , 'r',...
    x_range, fit_mat * PCA_BA.poly_coef(2,:)' , 'r:',...
    data_B, data_A,'.')
legend(['Linear = ' num2str(poly_BA.P(1),'%4.2f') 'x + ' num2str(poly_BA.P(2),'%4.2f') ...
    '; r2 = ' num2str(R_BA(1,2),'%4.2f')], ...
    ['PCA = ' num2str(PCA_BA.poly_coef(1,1),'%4.2f') 'x + ' num2str(PCA_BA.poly_coef(1,2),'%4.2f') ...
    '; r2 = ' num2str(PCA_BA.s.r2(1),'%4.2f')]);
axis([x_range y_range]); title('Data B vs Data A');
xlabel('Data B'); ylabel('Data A');

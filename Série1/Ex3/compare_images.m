function compare_images(img1, img2)
close all;
clc

[M,N] = size(img1);

% Data img1
img1_min  = min(min(img1));
img1_mean = mean(mean(img1));
img1_max = max(max(img1));
img1_contrast = 20 * log10(double((img1_max+1)/(img1_min+1)));
img1_entropy = entropy(img1);

% Data img2
img2_min  = min(min(img2));
img2_mean = mean(mean(img2));
img2_max = max(max(img2));
img2_contrast = 20 * log10(double((img2_max+1)/(img2_min+1)));
img2_entropy = entropy(img2);

% Compare Brightness
mean_dif = img1_mean - img2_mean;
fprintf('Brightness difference = %0.3f\n', mean_dif);

% Compare Contrast
contrast_dif = img1_contrast - img2_contrast;
fprintf('Contrast difference = %0.3f\n', contrast_dif);

% Compare Entropy
entropy_dif = img1_entropy - img2_entropy;
fprintf('Entropy difference = %0.3f\n', entropy_dif);

% Mean-Square Error
mse = sum(sum((img1 - img2).^2)) / (M*N);
fprintf('Mean-squared error = %0.3f\n', mse);

% Mean-Absolute Error
mae = sum(sum((img1 - img2))) / (M*N);
fprintf('Mean-absolute error = %0.3f\n', mae);

end
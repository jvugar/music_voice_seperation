% clc;
% clear;
% 
% load('data.mat')
% addpath(genpath('./Recon'))
% 
% num = size(set1_t, 1);        % number of the signal
% xlen = size(set1_t, 2);       % length of the signal
% level = 6;
% wvlet = 'db4';
% 
% [C, L] = wavedec(set1_t(1,:), level, wvlet);
% wvlen = size(C, 2);
% signal1 = zeros(num, wvlen);
% signal2 = zeros(num, wvlen);
% for i = 1:num
%     [C, ~] = wavedec(set1_t(i,:), level, wvlet);
%     signal1(i, :) = C;
%     [C, ~] = wavedec(set2_t(i,:), level, wvlet);
%     signal2(i, :) = C;
% end

[D1, D2] = dictionary_learning(signal1(1:100, :), signal2(1:100, :), 400, 400);
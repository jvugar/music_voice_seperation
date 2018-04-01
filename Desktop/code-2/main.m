clc;
clear;
close all;

load('data.mat')
addpath(genpath('./stft'))
addpath(genpath('./istft'))
addpath(genpath('./exact_alm_rpca'))
addpath(genpath('./inexact_alm_rpca'))

xlen = size(set1_t, 2);       % length of the signal
wlen = 1024;                   % window length (recomended to be power of 2)
hop = wlen/4;                 % hop size (recomended to be power of 2)
nfft = 4096;                  % number of fft points (recomended to be power of 2)

music = set1_t(1, :);
voice = set2_t(1, :);

[S1, f1, t1] = stft(music, wlen, hop, nfft, fs);
[S2, f2, t2] = stft(voice, wlen, hop, nfft, fs);
mixed = music + voice;
[S3, f3, t3] = stft(mixed, wlen, hop, nfft, fs);

freq = 1024;

S1_l = S1(1: freq, :);
S1_h = S1(freq + 1: end, :);
f1_l = f1(1: freq);
f1_h = f1(freq + 1: end);

S2_l = S2(1: freq, :);
S2_h = S2(freq + 1: end, :);
f2_l = f2(1: freq);
f2_h = f2(freq + 1: end);
% 
S3_l = S3(1: freq, :);
S3_h = S3(freq + 1: end, :);
f3_l = f3(1: freq);
f3_h = f3(freq + 1: end);

lambda_l = 1/sqrt(max(size(S3_l)));
lambda_h = 1/sqrt(max(size(S3_h)));
VocErr_l = [];
VocErr_h = [];
MisErr_l = [];
MisErr_h = [];


minErr_s = 10000000;
minErr = 1000000;
minErr_h = 10000000;
ratio_h = -1;

lambda = 1/sqrt(max(size(S3)));
[A_l, E_l] = separate(S3_l, 1.1 * lambda);
[A_h, E_h] = separate(S3_h, 0.1 * lambda);

A_s = [A_l; A_h];
E_s = [E_l; E_h];
[A, E] = separate(S3, ratio * lambda);

% % 
% for ratio = 0:0.1:4
%     [A_h, E_h] = separate(S3_h, ratio * lambda);
%     err_h = mean2((abs(E_h) - abs(S1_h)).^2);
%     if err_h < minErr_h
%         minErr_h = err_h;
%         ratio_h = ratio;
%     end
% end
% ratio_best = -1;
% for ratio = 0:0.1:2
%     fprintf("Ratio: %d", ratio);
% 
%     [A_l, E_l] = separate(S3_l, ratio * lambda);
%     [A_h, E_h] = separate(S3_h, ratio_h * lambda);
% 
%     A_s = [A_l; A_h];
%     E_s = [E_l; E_h];
%     [A, E] = separate(S3, ratio * lambda);
%     
%     err_s = mean2((abs(E_s) - abs(S2)).^2);
%     err = mean2((abs(E) - abs(S2)).^2);
%     minErr_s = min(err_s, minErr_s);
%     if err < minErr
%         minErr = err;
%         ratio_best = ratio;
%     end
% %     mel = mean2((abs(A_l) - abs(S1_l)).^2);
% %     meh = mean2((abs(A_h) - abs(S1_h)).^2);
% %     MisErr_l = [MisErr_l, mel];
% %     MisErr_h = [MisErr_h, meh];
% %     fprintf("Music error on low freqency:  %f \n", mel);
% %     fprintf("Music error on high freqency: %f \n", meh);
% %     
% %     vel = mean2((abs(E_l) - abs(S2_l)).^2);
% %     veh = mean2((abs(E_h) - abs(S2_h)).^2);
% %     VocErr_l = [VocErr_l, vel];
% %     VocErr_h = [VocErr_h, veh];
% %     fprintf("Voice error on low freqency:  %f \n", vel);
% %     fprintf("Voice error on high freqency: %f \n", veh);
% end
% %[A_l, E_l] = separate(M_l, lambda_l);
% %[A_h, E_h] = separate(M_h, lambda_h);
% 
% %A = [A_l; A_h];
% %E = [E_l; E_h];
% 
% %A_recov = abs(istft(A, wlen, hop, nfft, fs));
% %E_recov = abs(istft(E, wlen, hop, nfft, fs));

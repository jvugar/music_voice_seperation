clear;
clc;

path = 'MIR-1K/UndividedWavfile/';
folder = dir(path);
files = {folder(:).name};
fileNames = files(~[folder.isdir]);

segLen = 131072;
rows = 10;
set1 = zeros(rows, segLen);
set2 = zeros(rows, segLen);
tmp1 = [];
tmp2 = [];
count = 1;
fileNum = 1;
for file = fileNames
    fprintf("file: %s, num: %d \n", file{1}, fileNum);

    input = strcat(path, file{1});
    [track, fs] = audioread(input);
    track = track.';
    signal1 = track(1, :);
    signal2 = track(2, :);
    tmp1 = [tmp1, signal1];
    tmp2 = [tmp2, signal2];
    while length(tmp1) > segLen && count <= rows
        set1(count, :) = tmp1(1: segLen);
        tmp1 = tmp1(segLen + 1: end);
        
        set2(count, :) = tmp2(1: segLen);
        tmp2 = tmp2(segLen + 1: end);
        count = count + 1;
    end
    if count > rows
        break;
    end
    fileNum = fileNum + 1;
end

set1_t = set1(1: count - 1, :);
set2_t = set2(1: count - 1, :);

save('data.mat', 'set1_t', 'set2_t', 'fs');

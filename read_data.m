clear
data = [];
sample = 1;
data_matrix = [];

dir = strcat('s', sprintf('%03d',sample));
path = strcat('./', dir);

k=0;
% cv = [];
file_name = strcat(path, '/cv.txt');
cv = load(file_name);
data.cv = cv;
[m,n] = size(cv);
data_matrix(:,:,1) = cv;

% ov = [];
for i=1:2860 %arbituary number cause don't know the file name with the largest ID
    file_name = strcat(path,'/ov',int2str(i),'.txt');
    if ~exist(file_name, 'file')
        continue;
    else
        k=k+1; %keep track of name in struct
        temp = load(file_name);
    end
    
    pos = find(cv(:,1) == temp(1,1));
    temp = [zeros(pos(1)-1,n);temp];
    [m_,~] = size(temp);
    temp = [temp;zeros(m-m_,n)];
    data_matrix(:,:,k+1) = temp;
    
    j = strcat('ov',int2str(k));
    data.(j) = temp;
end

save('read_data.mat', 'data');







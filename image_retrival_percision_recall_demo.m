clc
clear
close all

%% simulate data and captions
number_of_classes = 4;
number_of_data = 100;

rng('default');
data = rand(number_of_data,1);
data_caption = round((number_of_classes-1)*data);

for k = 0:max(data_caption)
    fprintf('Class with caption %d has %d instances.\n',k,sum(data_caption == k));
end

%% make a query
rng('shuffle');
query_idx = 1+round((number_of_data-1)*rand);
query_data = data(query_idx);
query_caption = data_caption(query_idx);

fprintf('\nThe query index is %d, data is %f and caption is %d.\n',query_idx,query_data,query_caption);

%% retrive data
top_selection_number = 20;

[sort_data, sort_idx] = sort(abs(data-query_data));

retrive_idx = sort_idx(1:top_selection_number);
retrive_data = data(retrive_idx);
retrive_caption = data_caption(retrive_idx);

%% calculate evaluation metrics
percision = sum(retrive_caption == query_caption)/length(retrive_caption);
positve_recall = sum(retrive_caption == query_caption)/sum(data_caption == query_caption);
negative_recall = sum(retrive_caption ~= query_caption)/sum(data_caption ~= query_caption);

fprintf('\nRetrived percision is %.2f, positive_recall is %.2f and negative_recall is %.2f.\n', percision, positve_recall, negative_recall);

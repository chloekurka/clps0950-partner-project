% startercode.m
% Written by Chloe Kurka on March 13, 2023
% This script creates a corpus file of 10 books from the Gutenerg project.
% The text is in all lowercase and has no punctuation
% It then displays the top 20 bigrams from this corpus file

directory_name = 'C:\Users\chloe\OneDrive\Desktop\CLPS0950 TXT FILES';

%STEP 1: Load corpus data 
% List of all text files in the directory
file_list = dir(fullfile(directory_name, '*.txt'));

%Creates empty variable to store the text
corpus = '';

%Loops through each file and links the text together
for i = 1:length(file_list)
    %Reads the file
    file_name = fullfile(directory_name, file_list(i).name);
    text = fileread(file_name);

%STEP 2: Preprocess corpus 
    %Links the text to the all_text variable and makes it lowercase
    corpus = [corpus, lower(text)];
end 

%Removes the punctuation from the corpus 
corpus = regexprep (corpus, '[^a-zA-Z\s]', ''); 
%Tokenize document: This means that the raw data is converted into a form
%that is more easily processed and analysed 
documents = tokenizedDocument(corpus);

% Split the corpus into individual words. Not sure if this is necessary
words = strsplit(corpus);

% STEP 3: Generate n-grams 
% Generate all possible n-grams of length 2 ('ngrams' variable now has a list of unique n-grams)
% 'bagOfNgrams' function also has the 'count' property 
% 'count' property creates a vector of integer counts for each n-gram 
% 'ngrams' is a cell array where each row represents a single n-gram
ngrams = bagOfNgrams(documents,'NgramLengths',2);

% STEP 4: Count the frequency of n-gram of interest 
% Create a map to store the n-gram and their counts (Key = ngram, value = count)
% This container map is currently empty
ngram_counts = containers.Map; 

% Loops from first row to the last row of n-grams
% size(ngrams,1) is used here to refer to the last row 

for ii = 1:size(ngrams,1)
    % Returns the iith row as a cell array
    ngram = ngrams {ii,:};

    % Check if n-gram is already on the map
    % isKey() is a function that checks wether a key (ngram) exists in a map container (ngram_counts)
    if isKey(ngram_counts, ngram)
        ngram_counts(ngram)=ngram_counts(ngram)+1;
    else 
        % If it is not, add it to the map with a count of 1, so the value increases
        ngram_counts(ngram) = 1; 
    end 
end 

%STEP 5: Calculate the probability of each n-gram

%STEP 6: Get the n-gram with the highest probability for the given prefix
% asking user to write down BLAH

%STEP 7: Display the top most likely word 
 
disp(ngram-counts)

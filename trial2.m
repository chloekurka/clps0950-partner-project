% This script creates a corpus file of 10 books from the Gutenerg project.
% The text is in all lowercase and has no punctuation
% It then displays the top 20 bigrams from this corpus file

directory_name = 'TEXT/';

% STEP 1: Load corpus data
% List of all text files in the directory
file_list = dir(fullfile(directory_name, '*.txt'));

% Creates empty variable to store the text
corpus = '';

% Loops through each file and links the text together
for i = 1:length(file_list)
    % Reads the file
    file_name = fullfile(directory_name, file_list(i).name);
    text = fileread(file_name);

    % Links the text to the all_text variable and makes it lowercase
    corpus = [corpus, lower(text)];
end

% Removes the punctuation from the corpus
corpus = regexprep (corpus, '[^a-zA-Z\s]', '');
% Tokenize document: This means that the raw data is converted into a form
% that is more easily processed and analysed
doc = tokenizedDocument(corpus);

% Split the corpus into individual words. Not sure if this is necessary
doc = strsplit(corpus);



% STEP 2: Generate n-grams
% Generate all possible n-grams of length 2 ('ngrams' variable now has a list of unique n-grams)
% 'bagOfNgrams' function also has the 'count' property
% 'count' property creates a vector of integer counts for each n-gram
% 'ngrams' is a cell array where each row represents a single n-gram
n = 3;
ngrams = bagOfNgrams(doc,'NgramLengths',n);

%STEP 3: Count the frequency of each n-gram in the corpus
ngrams_freq = ngrams.Counts; 


%STEP 4: Ask user to type in the start of a sentence
user_input = input('Please enter the beginning of a sentence, please write at least 2 words: ', 's');
user_input = lower(user_input); 
user_input = regexprep (user_input, '[^a-zA-Z\s]', ''); 

top = 10000; 
%Take last m amount of words 
m = n-1; 
words = split(user_input); % Split into individual words

last_m_words = words(end-m+1:end); % Join last m words with a space separator

idx = find(topkngrams(ngrams,top).Ngram(:,1)==last_m_words(1)&topkngrams(ngrams,top).Ngram(:,2)==last_m_words(2));

max_matching_ngram = topkngrams(ngrams,top).Ngram(idx,:);


max_matching_freq    = topkngrams(ngrams,top).Count(idx,:);




%string_last_m_words = strjoin(last_m_words); 
%
%
%
%%Find matching n-grams 
%matching_ngrams = ngrams(startsWith(ngrams.Ngrams,string_last_m_words)); %Filter to only include n-grams that start with last_m_words
%
%if isempty(matching_ngrams)
%    disp('You typed something weird! Try again.')
%    return
%end
%
%
%% Find the frequency of each matching n-gram
%matching_ngrams_counts = matching_ngrams.Counts; 
%
%%Find the index of the matching n-gram with the highest count 
%[~, max_idx] = max(matching_ngrams_counts);
%
%% Get the matching n-gram itself
%max_matching_ngram = matching_ngrams.Ngrams{max_idx};

% Display the matching n-gram
disp('The most frequent matching n-gram is: ');
disp(max_matching_ngram);
disp(max_matching_freq);



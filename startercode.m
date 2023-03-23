% This script creates a corpus file of 10 books from the Gutenerg project.
% The text is in all lowercase and has no punctuation
% It then displays the top 20 bigrams from this corpus file

directory_name = 'TEXT/';

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
% Generate all possible n-grams of length n ('ngrams' variable now has a list of unique n-grams)
% 'ngrams' is a cell array where each row represents a single n-gram
n = 2;
ngrams = bagOfNgrams(documents,'NgramLengths',n);

%STEP 4: Count the frequency of n-gram of interest 


%STEP 5: Calculate the probability of each n-gram


%STEP 6: Get the n-gram with the highest probability for the given prefix
% asking user to put in the start of a sentence 

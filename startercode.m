% startercode.m
% Written by Chloe Kurka on March 13, 2023
% This script creates a corpus file of 10 books from the Gutenerg project.
% The text is in all lowercase and has no punctuation
% It then displays the top 20 bigrams from this corpus file

directory_name = 'C:\Users\chloe\OneDrive\Desktop\CLPS0950 TXT FILES';

% List of all text files in the directory
file_list = dir(fullfile(directory_name, '*.txt'));

%Creates empty variable to store the text
corpus = '';

%Loops through each file and links the text together
for i = 1:length(file_list)
    %Reads the file
    file_name = fullfile(directory_name, file_list(i).name);
    text = fileread(file_name);

    %Links the text to the all_text variable and makes it lowercase
    corpus = [corpus, lower(text)];
end 

%Removes the punctuation from the corpus 
corpus = regexprep (corpus, '[^a-zA-Z\s]', ''); 
documents = tokenizedDocument(corpus);

% Split the corpus into individual words. Not sure if this is necessary
words = strsplit(corpus);

% Generate all possible n-grams
ngrams = bagOfNgrams(documents,'NgramLengths',2);

% Print the n-grams
disp(ngrams);

% Creates a table of the top 20 bigrams
topkngrams(ngrams,20,'NGramLengths',2)

% Count the number of occurances of one n-gram
count(corpus, "she is")

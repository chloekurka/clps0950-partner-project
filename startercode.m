% startercode.m
% Written by Chloe Kurka on March 10/11, 2023
% This script creates a corpus file of 10 books from the Gutenerg project

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

    %Links the text to the all_text variable
    corpus = [corpus, lower(text)];
end 




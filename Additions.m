% This script creates a corpus file of 10 books from the Gutenerg project.
% The text is in all lowercase and has no punctuation
% It then displays the most frequent n-gram that matches the user input

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
corpus = regexprep(corpus, '[^a-zA-Z\s]', '');

% Tokenize document: This means that the raw data is converted into a form
% that is more easily processed and analysed
doc = tokenizedDocument(corpus);

% Split the corpus into individual words
doc_words = split(corpus);

% STEP 2: Generate n-grams
n_max = 5; % maximum n-gram length to consider
ngrams_list = cell(1, n_max); % stores n-grams of different lengths

for n = 2:n_max % loop through different n-gram lengths
    ngrams_list{n} = bagOfNgrams(doc_words, 'NgramLengths', n);
end

while true % keep looping until the user finds a matching n-gram or exits
    % Ask user to type in the start of a sentence
    user_input = input('Please enter the beginning of a sentence, please write at least 2 words: ', 's');
    user_input = lower(user_input);
    user_input = regexprep(user_input, '[^a-zA-Z\s]', '');
    user_words = split(user_input);

    % Try matching n-grams of different lengths
    for n = min(n_max, length(user_words)):-1:2 % loop through different n-gram lengths in reverse order
        ngrams = ngrams_list{n};
        last_m_words = user_words(end-(n-1):end);
        idx = find(ngrams.Ngram(:,1)==last_m_words(1) & ngrams.Ngram(:,2)==last_m_words(2));

        if ~isempty(idx) % if a matching n-gram is found
            max_matching_ngram = ngrams.Ngram(idx,:);
            max_matching_freq = ngrams.Count(idx,:);
            disp(['The most frequent matching ', num2str(n), '-gram is:']);
            disp(max_matching_ngram);
            disp(max_matching_freq);
            break; % exit the loop
        end
    end

    % If no matching n-gram is found
    if isempty(idx)
        disp('No matching n-gram found. Please try again with a new sentence.');
    end

    % Ask user if they want to try again or exit
    prompt = 'Do you want to try again? (Y/N) ';
    str = input(prompt, 's');
    if ~strcmpi(str, 'Y')
        break; % exit the loop
    end
end
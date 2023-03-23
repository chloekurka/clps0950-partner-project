function bag = getTopBigram(text, word)
bigrams = text.Ngrams;

% Find the indices of bigrams containing the specified word
index = find(word, bigrams);

% Select the bigrams that contain the specified word
bigrams(index);
end

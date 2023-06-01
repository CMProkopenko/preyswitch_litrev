

####load packages
libs <- c('wordcloud',
          'wordcloud2', 
          'RColorBrewer', 
          'tm', 'tidyr')
lapply(libs, require, character.only = TRUE)

###set wd to project directory
#setwd("~/Documents/local-git/preyswitch_litrev")

###load corpus data

###upload as .csv
###remove columns and headers?
###convert to txt

data <- read.table('data/corpus.txt', fill = TRUE)
text <- Corpus(VectorSource(data))


###clean data to remove common words, punctuation, etc.
text <- text %>%
  tm_map(removeNumbers) %>%
  tm_map(removePunctuation) %>%
  tm_map(stripWhitespace)
text <- tm_map(text, content_transformer(tolower))
text <- tm_map(text, removeWords, stopwords("english"))

text


####create matrix

dtm <- TermDocumentMatrix(text) 
matrix <- as.matrix(dtm) 
words <- sort(rowSums(matrix),decreasing=TRUE) 
df <- data.frame(word = names(words),freq=words)

####create wordcloud
set.seed(1989) # for reproducibility 


wordcloud(words = df$word, freq = df$freq, min.freq = 1,
          max.words=100, random.order=FALSE, rot.per=0.35,
          colors=brewer.pal(8, "Dark2"))

wordcloud2(data=df, size=1.6, color='random-dark')


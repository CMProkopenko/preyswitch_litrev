

####load packages
libs <- c('wordcloud',
          'wordcloud2',
          'ggplot2',
          'RColorBrewer',
          'wesanderson',
          'tm', 'tidyr')
lapply(libs, require, character.only = TRUE)

###set wd to project directory
#setwd("~/Documents/local-git/preyswitch_litrev")

###load corpus data

###upload as .csv
###remove columns and headers?
###convert to txt

data <- read.table('data/corpus2.txt', fill = TRUE)
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
preyswitch_df <- data.frame(word = names(words),freq=words)

write_csv(preyswitch_df, "preyswitch_words.csv")

####create wordcloud
set.seed(1989) # for reproducibility 

wordcloud(words = df$word, 
          freq = df$freq,
          min.freq = 1, 
          max.words = 200,
          random.order = FALSE, 
          rot.per = 0.35, 
          colors = brewer.pal(8, "Set1"))

 
wordcloud(words = df$word, freq = df$freq, min.freq = 2,
          max.words=100, random.order=FALSE, rot.per=0.35,
          scale=c(2.5,.5))


png('plots/wordcloud.png', width = 3000, height = 3000, res=1000, units="px")

wordcloud(words = df$word, freq = df$freq, min.freq = 1,
          max.words=150, random.order=FALSE, rot.per=0.35,
          scale=c(2,0.5),colors = c( "#2E4052", "#BDD9BF", "#FFC857","#E5323B","#929084", "#A997DF"))


dev.off()

#wordcloud2(data=df, size=1, color=wes_palette('FantasticFox1'))


###plot term fequency
findFreqTerms(dtm, lowfreq = 10)
findAssocs(dtm, terms = "predator", corlimit = 0.5)
findAssocs(dtm, terms = "switch", corlimit = 0.5)

head(df, 15)

barplot(df[1:15,]$freq, las = 2, names.arg = df[1:15,]$word,
        col ="#2E4052", main ="Most frequent words",
        ylab = "Word frequencies")

subsetdf <- subset(df, freq > 14)

barplot <- ggplot(data = subsetdf, aes(x = reorder(word, -freq),y = freq)) +
  geom_bar(stat = "identity", fill = "#FFC857", colour = "black") +
  theme_bw()  + 
  theme(
    panel.background =element_rect(fill='transparent', colour = "black", size=1), 
    panel.border = element_blank(), 
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.line = element_line(colour = "black", size = .1),
    axis.text.x = element_text(size=20, angle = 45, hjust = 1), 
    axis.title = element_text(size=20),
    axis.text.y = element_text(size=20),
    legend.title=element_text(size=20),
    legend.text = element_text(size = 20),
    plot.background = element_rect(fill='transparent', color=NA),
    plot.title = element_text(vjust = - 9, hjust =.02),
    legend.background = element_rect(fill='transparent'),
    legend.box.background = element_rect(fill='transparent')) + 
  ylab("Frequency") + 
  xlab("Words")


png('plots/frequency.png', width = 6000, height = 4000, res=1000, units="px")

barplot

dev.off()

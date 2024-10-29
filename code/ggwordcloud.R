
library(ggwordcloud)
library(ggplot2)

# ####Example
# 
# set.seed(1)
# ggplot(thankyou_words_small, aes(label = word, size = speakers, color = name)) +
#   geom_text_wordcloud() +
#   scale_size_area(max_size = 20) +
#   theme_minimal()
# 
# ####

preyswitch_df <- read.csv("data/preyswitch_words.csv")

preyswitch_df <- filter(preyswitch_df, freq >=5)

set.seed(1)
corpus_cloud <- ggplot(preyswitch_df, aes(label = word, size = freq)) +
  geom_text_wordcloud( eccentricity = 1) +
  scale_size_area(max_size = 30) +
  theme_minimal() + theme(text = element_text(size = 20)) + ggtitle("B)") 

corpus_cloud

png('plots/corpus_cloud.png', width = 10000, height = 10000, res=1000, units="px")

corpus_cloud

dev.off()

####

keywords <- read.csv('data/Keywords.csv')

set.seed(13)
keywords_cloud <- ggplot(keywords, aes(label = word, size = count, colour = category)) +
  geom_text_wordcloud( eccentricity = 1) +
  scale_size_area(max_size = 10) +
  scale_colour_viridis(option = "magma", discrete = T, end = .75) +
  theme_minimal() + theme(text = element_text(size = 20)) + ggtitle("A)") 

keywords_cloud

png('plots/keywords_cloud.png', width = 10000, height = 10000, res=1000, units="px")

keywords_cloud

dev.off()

keywords_cloud + corpus_cloud

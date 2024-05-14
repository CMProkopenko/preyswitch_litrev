####
libs <- c('data.table', 'readr', 'dplyr', 'lubridate', 'tidyr', 'ggplot2','stringr', 'tibble', 'patchwork', 'performance','see','viridis')
lapply(libs, require, character.only = TRUE)


###Load data


dat <- read.csv('data/WolfDataExtraction_PreyPref.csv')
#dat <- read_csv('data/WolfDataExtraction_PreyPref.csv') ###tibble version


glimpse(dat)

###Any data transformation or cleaning needed

#####Plots

pref.plot1 <- ggplot(dat) +
  geom_point(aes(x = Proportion.Biomass.Available., y = Rel..Biomass..Consumed., col = Livestock.or.Wild.)) + ##or col = Paper.ID
  geom_abline(intercept = 0, slope = 1, linetype="dashed") + ###constant 1:1 line
  theme_classic() + theme(text = element_text(size = 20)) +
  scale_colour_viridis(discrete = TRUE, end = .9) +
  xlab("Proportion Available") + ylab("Proportion Consumed") +
  labs(colour="Prey Category")
pref.plot1


ggsave("plots/wolf-preference.png", 
       height = 7, width = 10)

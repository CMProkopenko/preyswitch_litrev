
#####Example Plot

library(ggplot2, tidyverse, data.table)

#DF <- read.csv()

###this is a switching example
x = seq(0,100,0.5) ###x is the relative availability 
c = rnorm(n = 100,mean = 1, sd = .2) ###this is a constant slope with some variation around the mean
b = rnorm(n = 100,mean = 3, sd = .2) ##switching parameter, mean is above 1 indicating switching but

DF <- data.frame(N = x,
                 c1 = x*c, ###this is a constant preference
                 sw = x*(c^b) ###this is switching
                 )

exampleplot <- ggplot(DF) +
###this is making the triangle that shows up to show being above or below 1:2
annotate("polygon", x = c(-1, 100,100), y = c(-1, 100,-1), fill = "#929084", alpha = 0.2 ) +
geom_point(aes(x=N, y=c1), col = "#2E4052", alpha = .7) + ####points for the constant scenario
geom_point(aes(x=N, y=sw), alpha = .7, col = "#BDD9BF") + ####points for the switching scenario
xlab("Relative Density") + ylab("Relative Consumption Rates") +###titles and theme
#pc <- pc + geom_abline(intercept = 0, slope = 1, linetype="dashed") ###constant 1:1 line
stat_smooth(aes(x=N, y=c1),col ="#2E4052") +###smooth line for the constant scenario
stat_smooth(aes(x=N, y=sw), col = "#BDD9BF") + ##smooth line for the switching scenario
theme(text = element_text(size=20), ####editing the theme and appearance of the plot
                 panel.background=element_blank(), plot.title = element_text(hjust=-0.06),
                 axis.line = element_line(colour = "black"),
                 axis.text.x = element_blank(), 
                 axis.text.y = element_blank(),
                 axis.ticks = element_blank())
#pc <- pc + xlim(-5,100) + ylim(-5,200) 
exampleplot 



png('plots/ExamplePlot.png', width = 6000, height = 4000, res=1000, units="px")

exampleplot 

dev.off()


####making fake data for proportion example and not ratios
avail1 = seq(0,1,0.001) ###x is the availability in a proportion
consume1 = .5 ###constant consumption rate
avail2= seq(0,1,0.001)
consume2 = avail2*.5 ####consumption based on availability


DF2 <- data.frame(avail1,
                 consume1, 
                 avail2,
                 consume2)


exampleplot2 <- ggplot(DF2) +
  ###this is making the triangle that shows up to show being above or below 1:2
 # annotate("polygon", x = c(-1, 100,100), y = c(-1, 100,-1), fill = "#929084", alpha = 0.2 ) +
  geom_point(aes(x=avail1, y=consume1), col = "#2E4052", alpha = .7) + ####points for the constant scenario
  geom_point(aes(x=avail2, y=consume2), alpha = .7, col = "#BDD9BF") + ####points for the preference * availability
  xlab("Proportion Available") + ylab("Proportion Consumed") +###titles and theme
  #pc <- pc + geom_abline(intercept = 0, slope = 1, linetype="dashed") ###constant 1:1 line
  stat_smooth(aes(x=avail1, y=consume1),col ="#2E4052") +###smooth line for the constant scenario
  stat_smooth(aes(x=avail2, y=consume2), col = "#BDD9BF") + ##smooth line for the switching scenario
  theme(text = element_text(size=20), ####editing the theme and appearance of the plot
        panel.background=element_blank(), plot.title = element_text(hjust=-0.06),
        axis.line = element_line(colour = "black"),
        axis.text.x = element_blank(), 
        axis.text.y = element_blank(),
        axis.ticks = element_blank())
#pc <- pc + xlim(-5,100) + ylim(-5,200) 
exampleplot2

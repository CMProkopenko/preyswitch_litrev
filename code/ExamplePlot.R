
#####Example Plot

library(ggplot2)



x = seq(0,100,0.5)

c = rnorm(n = 100,mean = 1, sd = .2)

b = rnorm(n = 100,mean = 3, sd = 1)

DF <- data.frame(N = x,
                 c1 = x*c,
                 sw = x*(c^b)
                 )

pc <- ggplot(DF) 
pc <- pc + annotate("polygon", x = c(-1, 100,100), y = c(-1, 100,-1), fill = "#929084", alpha = 0.2 )
pc <- pc + geom_point(aes(x=N, y=c1), col = "#2E4052", alpha = .7) + geom_point(aes(x=N, y=sw), alpha = .7, col = "#BDD9BF")
pc <- pc + theme_classic() + xlab("Relative Density") + ylab("Relative Consumption Rates")
#pc <- pc + geom_abline(intercept = 0, slope = 1, linetype="dashed")
#pc <- pc + stat_smooth(aes(x=N, y=sw), col = "#BDD9BF")
#pc <- pc + stat_smooth(aes(x=N, y=c1),col ="#2E4052")
pc <- pc + theme(text = element_text(size=20),
                 panel.background=element_blank(), plot.title = element_text(hjust=-0.06),
                 axis.line = element_line(colour = "black"),
                 axis.text.x = element_blank(), 
                 axis.text.y = element_blank(),
                 axis.ticks = element_blank())
#pc <- pc + xlim(-5,100) + ylim(-5,200) 
pc



png('plots/ExamplePlot.png', width = 6000, height = 4000, res=1000, units="px")

pc

dev.off()


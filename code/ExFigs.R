

#####EXAMPLE FIGS

library(ggplot2)
library(gridExtra)
library(grid)
library(lattice)
library(data.table)


N<-seq(0,10,.01)

####3 types of models
ft1 <- .06*N

ft2 <- .2*N/(1+.2*3*N)

ft3 <- .04*(N^2)/(1+.04*3.3*(N^2))

FR = data.frame(N, ft1, ft2, ft3)


pf <- ggplot(FR)  + geom_line(aes(x=N, y=ft1), size=1) + geom_line(aes(x=N, y=ft2), size =1,linetype = "dashed")  + geom_line(aes(x=N, y=ft3), size=1,linetype = "dotted")
pf <- pf + theme_classic() + xlab("Prey Density") + ylab("Consumption Rate")
pf <- pf + theme(text = element_text(size=25),
                 panel.background=element_blank(), plot.title = element_text(hjust=-0.06),
                 axis.line = element_line(colour = "black",size=.8),
                 axis.text.x = element_blank(), 
                 axis.text.y = element_blank(),
                 axis.ticks = element_blank()) + xlim(0,10) + ylim(0,0.3) 
pf <- pf+scale_linetype_manual(name="",values =c( "dashed","solid", "dotted"))
+ ggtitle("(a)")
#pf <- pf+ annotate("rect", xmin = 0, xmax = 5.5, ymin = 0, ymax = .3,
#           alpha = .1)
pf

pr = ggplot(FR) + geom_line(aes(x=N, y=ft1/N, linetype = "Type I"),colour = "grey",size=1) + geom_line(aes(x=N, y=ft2/N,linetype = "Type II"), size =1)  + geom_line(aes(x=N, y=ft3/N, linetype="Type III"), size=1)
pr <- pr + theme_classic() + xlab("Prey Density") + ylab("Predation Rate")
pr <- pr + theme(text = element_text(size=25),
                 panel.background=element_blank(), plot.title = element_text(hjust=-0.06),
                 axis.line = element_line(colour = "black",size=.8),
                 axis.text.x = element_blank(), 
                 axis.text.y = element_blank(),
                 axis.ticks = element_blank())#+ ggtitle("(b)") #+ xlim(0,10) + ylim(0,0.3)

pr <- pr +scale_linetype_manual(name="",values =c( "dashed","solid", "dotted"))
#pr <- pr + annotate("rect", xmin = 0, xmax = 5.5, ymin = 0, ymax = .2,
#                   alpha = .1)
pr


png("FigPR", width = 13000, height = 6000, res=1000, units="px")
grid.arrange(pf,pr,  ncol = 2,
             widths = c(1, 1.2))
dev.off()



x = seq(0,5,0.01)
DF <- data.frame(N = x,
                 c1 = x,
                 fxa = 2*x,
                 b = x^3)

pc <- ggplot(DF) + 
  geom_line(aes(x=N, y=c1, colour ="Proportionate", lty = "Proportionate"), size = 1) + 
  geom_line(aes(x=N, y=fxa, colour= "Preference", lty = "Preference"), size = 1) +
  geom_line(aes(x=N, y=b, colour = "Switching", lty= "Switching"), size = 1.5) 
pc <- pc + theme_classic() + xlab("Relative Density") + ylab("Relative Consumption Rates")
pc <- pc + theme(text = element_text(size=25),
                 panel.background=element_blank(), 
                 plot.title = element_text(hjust=-0.06),
                 axis.line = element_line(colour = "black", size = .8),
                 axis.text.x = element_blank(), 
                 axis.text.y = element_blank(),
                 axis.ticks = element_blank(),
                 legend.position = "right")
pc <- pc +scale_linetype_manual(name="",values =c("solid","dashed","dotted"))
pc <- pc +scale_colour_manual(name="",values =c("black","grey","black"))
pc <- pc + xlim(0,3) + ylim(0,3) 
pc <- pc + annotate("segment", x = 1.5, xend = 1.05, y = .9, yend = .99, colour = "orange", size=2, arrow=arrow())
pc <- pc + geom_text(aes( x=2.05, y=.9, label="Tipping Point"),  color="orange",  size=7 , angle=0)
pc

png("FigExample.png", width = 9000, height = 6000, res=1000, units="px")
pc
dev.off()


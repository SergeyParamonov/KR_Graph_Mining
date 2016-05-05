library(ggplot2)
data <- read.csv("runtime.csv")
N = 40
visual <- ggplot(data, aes(x=pattern_index, y=runtime, colour=model))
visual <- visual + geom_smooth(se=FALSE, size=1.3) + geom_point(size=5)+ theme_bw(base_size=N)
visual <- visual + scale_x_continuous("i-th pattern",breaks=seq(1,15,2)) + scale_y_continuous("Runtime in Seconds") + scale_colour_discrete(name="Model",labels=c("IDP","ProB")) 
visual <- visual + theme(legend.text=element_text(size=N-5), legend.title=element_text(size=N-5), legend.position="top") 
ggsave(visual,file="idp_prob_comparison.pdf")
print(visual)

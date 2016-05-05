library(ggplot2)
N = 35

data   <- read.csv("averaged_runtime.csv")
visual <- ggplot(data, aes(x=pattern_index, y=runtime, colour=model))
visual <- visual + geom_smooth(se=FALSE, size=1.3) + geom_point()+ theme_bw(base_size=N)
visual <- visual + scale_x_continuous("i-th pattern") + scale_y_continuous("Runtime in Seconds") + scale_colour_discrete(name="Model",labels=c("Higher Order Simulation","Disjoint Union")) 
visual <- visual + theme(legend.text=element_text(size=N-5), legend.title=element_text(size=N-5), legend.position="top") 
ggsave(visual,file="asp_fol_vs_decomposed_yoshida.pdf")
print(visual)

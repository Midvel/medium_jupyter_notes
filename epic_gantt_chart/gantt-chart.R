library(reshape2)
library(ggplot2)
require(dplyr)

tasks_data <- read.csv('tasks_data.csv')


# PLOTTING WITH GGPLOT2

# Preparations
task_names <- tasks_data$name

tasks_data$name = factor(task_names, levels = unique(task_names))
tasks_data$start.date = as.Date(tasks_data$start.date)
tasks_data$end.date = as.Date(tasks_data$end.date)
tasks_data$index = 1:length(task_names) # We need index for grouping and line breakes

# Melting to get the dates in s single columns
task_data_prep <- melt(tasks_data, measure.vars = c("start.date", "end.date"))
task_data_prep <- arrange(task_data_prep, index, value)

# Plotting
ggplot(task_data_prep)+
  aes(value, name, color=is.critical) +
  geom_path(size = 8, aes(group=index)) +
  scale_color_manual(values=c("black", "red")) +
  xlab(NULL) + ylab(NULL) +
  scale_y_discrete(expand= c(0, 3)) +
  theme(aspect.ratio = 0.5)


# PLOTTING WITH PLOTRIX

require(plotrix)

vgridlab <- c("Jan","Feb","Mar","Apr","May","Jun")
vgridpos<-as.Date( c( "2020-01-01","2020-02-01","2020-03-01","2020-04-01","2020-05-01","2020-06-01"))

tasks_info<-list(labels=task_names,
            starts=as.Date( tasks_data$start.date ),
            ends=as.Date( tasks_data$end.date ) )

gantt.chart( tasks_info, vgridlab = vgridlab, vgridpos = vgridpos, hgrid=TRUE,
             xlim = as.Date( c( "2020-01-01","2020-06-20" ) ),
             main="Gantt chart", taskcolors= if_else( tasks_data$is.critical, 2, 8) )

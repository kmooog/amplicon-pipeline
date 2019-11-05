library(stringr)
library(readr)
library(dplyr)
library(colorspace) 
library(RColorBrewer) 
library(vegan)
library(ggplot2)
library(gtable)
library(scales)
library(dichromat)

input_filename = "result_removed3.csv"; type="All";

meta_filename  = "/home/kumay/r/amplicon/NMDS/metagenome_sample_depth.tsv"

upper_limit = 11000  #max depth for coloring

set.seed(123)  # seed for randomize

cCyan      <- "#00a0e9"
cMagenta   <- "#e4007f"
cGreen     <- "#009944"
cOrange    <- "#f39800"
cLightBlue <- "#0068b7"
input_filename<-str_c(input_pass, input_filename)

outplot<-function(prefix){
output_filename_png <-str_c(prefix,".png")
output_filename_eps <-str_c(prefix,".eps")

dev.copy(
	png,
	bg = "transparent",
	file=output_filename_png,
	width=1280, 
	height=960)
	dev.off()
	dev.copy2eps(file=output_filename_eps,
	family="ArialMT", 
	horizontal = FALSE,
	onefile = FALSE, 
	pointsize=10
	)
}

x <- read.table(input_filename, header=T,sep=",", check.names=FALSE)
x <- data.frame(as.matrix(x), check.names=FALSE)
x <- data.matrix(x)

sum_x <- apply(x, 2, sum)
x_normalized <- apply(x, 1, function(xx) xx/sum_x)
x_normalized <- t(x_normalized)
h1 <- x_normalized
h2 <- (h1)
h3 <- prop.table(as.matrix(h2), margin=1) 
h4 <- prop.table(as.matrix(h2), margin=2)

sample_list =colnames(h4)

metadata_table = read.table(meta_filename, header=T,sep="\t", row.names=1)
sites  =unique(metadata_table$site)
sites <- sort(sites)
pelagic_zones <- case_when(
metadata_table$depth < 200 ~ "Epipelagic", 
metadata_table$depth < 1000 ~ "Mesopelagic", 
metadata_table$depth < 4000 ~ "Bathypelagic", 
metadata_table$depth < 6000 ~ "Abyssopelagic", 
metadata_table$depth >= 6000 ~ "Hadopelagic", )

pelagic_zone_colors <- case_when(
pelagic_zones =="Epipelagic" ~ "orange", 
pelagic_zones =="Mesopelagic" ~ "green", 
pelagic_zones =="Bathypelagic" ~ "blue", 
pelagic_zones =="Abyssopelagic" ~ "gray", 
pelagic_zones =="Hadopelagic" ~ "black", 
)

pelagic_zone_colors_df <- data.frame("Classes"= factor(pelagic_zone_colors), row.names=rownames(metadata_table))

pelagic_zones_df <- data.frame("Classes"= factor(pelagic_zones), row.names=rownames(metadata_table))
color_zone       = c( "orange","green","blue","gray","black")
color_zone_names = setNames(color_zone, c("Epipelagic", "Mesopelagic","Bathypelagic","Abyssopelagic","Hadopelagic"))

print("Calculating NMDS", quote=F)
c_title_prefix=str_c("NMDS")

nmds<-metaMDS((t(h4)),
distance = "bray",
k=2,
trymax=20
)
data.scores      = as.data.frame(scores(nmds))  # Using the scores function from vegan to extract the site scores and convert to a data.frame

# Sample names

data.scores$site = rownames(data.scores)  # Create a column of site names, from the rownames of data.scores


write.csv(data.scores,"data.scores.csv")

# Grouping

my_group = pelagic_zones_df
data.scores$grp        = my_group[,1]
species.scores         = as.data.frame(scores(nmds, "species"))  #Using the scores function from vegan to extract the species scores and convert to a data.frame
species.scores$species = rownames(species.scores)  # create a column of species, from the rownames of species.scores

NMDS = data.frame(MDS1 = nmds$points[,1], 
MDS2 = nmds$points[,2],
group= my_group[,1],
check.names=FALSE)
g <- ggplot(data=data.scores,
aes(x =NMDS1,
y =NMDS2,
colour =  grp
)) 
g <- g + coord_equal() 
g <- g + theme_bw()
g <- g + geom_point(show.legend=TRUE,
alpha = 0.7,
size  = 2)

ggsave("NMDS.jpg", plot = g)
ggsave("NMDS.png", plot = g)
ggsave("NMDS.eps", plot = g)
ggsave("NMDS.svg", plot = g)


library(WGCNA);
library(vegan);
library(dendextend);
library(magrittr);

options(stringsAsFactors = FALSE);
#Read in the female liver data set
femData = read.csv("result_removed3_with_ID.csv",check.names=FALSE);
# ここにデータの正規化を入れる
tmpnames <- names(femData)

sum_x <- apply(femData, 2, sum)
x_normalized <- apply(femData, 1, function(xx) xx/sum_x)
x_normalized <- t(x_normalized)
femData <- x_normalized  #count

# Take a quick look at what is in the data set:
dim(femData);
names(femData);
names(femData) <- tmpnames
femData
datExpr0 = as.data.frame(t(femData))
gsg = goodSamplesGenes(datExpr0, verbose = 3);
gsg$allOK
if (!gsg$allOK)
{
# Optionally, print the gene and sample names that were removed:
if (sum(!gsg$goodGenes)>0)
printFlush(paste("Removing genes:", paste(names(datExpr0)[!gsg$goodGenes], collapse = ", ")));
if (sum(!gsg$goodSamples)>0)
printFlush(paste("Removing samples:", paste(rownames(datExpr0)[!gsg$goodSamples], collapse = ", ")));
# Remove the offending genes and samples from the data:
datExpr0 = datExpr0[gsg$goodSamples, gsg$goodGenes]
}

library(stringr)
library(readr)
library(dplyr)

metadata_table = read.table("Metadata20190817.csv", header=T,sep=",")
sites  =unique(metadata_table$NEWID)
sites <- sort(sites)
metadata_table$index <- str_pad(metadata_table$index, 3, pad = "0")

geo_loc_category <- case_when(
   metadata_table$NEWID == 24 | metadata_table$NEWID == 10 |metadata_table$NEWID == 35 | metadata_table$NEWID == 14 | metadata_table$NEWID == 36 | metadata_table$NEWID == 23 | metadata_table$NEWID == 20| metadata_table$NEWID == 21| metadata_table$NEWID == 22| metadata_table$NEWID == 18| metadata_table$NEWID == 16| metadata_table$NEWID == 15| metadata_table$NEWID == 19| metadata_table$NEWID == 17| metadata_table$NEWID == 13| metadata_table$NEWID == 12| metadata_table$NEWID == 9 | metadata_table$NEWID == 26 | metadata_table$NEWID == 25 | metadata_table$NEWID == 11 ~ "Kuroshio", 
    metadata_table$NEWID < 9 ~ "Antarctic Ocean",
    metadata_table$NEWID < 38 ~ "Oyashio",
    metadata_table$NEWID < 100 ~ "North Pacific",)
length(geo_loc_category)
geo_loc_category_df <- data.frame("geo_loc_category"= factor(geo_loc_category), row.names=metadata_table$index)
geo_loc_category_df$index <- metadata_table$index
col_geo_loc <- case_when(
   metadata_table$NEWID == 24 | metadata_table$NEWID == 10 |metadata_table$NEWID == 35 | metadata_table$NEWID == 14 | metadata_table$NEWID == 36 | metadata_table$NEWID == 23 | metadata_table$NEWID == 20| metadata_table$NEWID == 21| metadata_table$NEWID == 22| metadata_table$NEWID == 18| metadata_table$NEWID == 16| metadata_table$NEWID == 15| metadata_table$NEWID == 19| metadata_table$NEWID == 17| metadata_table$NEWID == 13| metadata_table$NEWID == 12| metadata_table$NEWID == 9 | metadata_table$NEWID == 26 | metadata_table$NEWID == 25 | metadata_table$NEWID == 11 ~ "red", 
    metadata_table$NEWID < 9 ~ "green",
    metadata_table$NEWID < 38 ~ "blue",
    metadata_table$NEWID < 100 ~ "orange",)
geo_loc_category_df$color <- col_geo_loc
geo_loc_category_df <- geo_loc_category_df[1:722,]

# set canvas size
options(repr.plot.width=12, repr.plot.height=4)


sampleTree = hclust(vegdist(datExpr0, method="bray",na.rm = TRUE), method = "average");
# Plot the sample tree: Open a graphic output window of size 12 by 9 inches
# The user should change the dimensions if the window is too large or too small.
#sizeGrWindow(12,9)
pdf(file = "Plots/sampleClustering.pdf", width = 12, height = 9);
par(cex = 0.6);
par(mar = c(0,4,2,0))


sampleTreeD <- as.dendrogram(sampleTree)

# Define nodePar
#nodePar <- list(lab.cex = 0.6, pch = c(NA, 19),  cex = 0.7)
# Customized plot; remove labels
sampleTreeD %>% set("leaves_pch", 19) %>%  set("leaves_col",geo_loc_category_df$color[as.integer(labels(sampleTreeD))] )%>%  plot
sampleTreeD %>% set("leaves_pch", 19) %>%  set("leaves_col",geo_loc_category_df$color[as.integer(labels(sampleTreeD))] )%>% hang.dendrogram %>% plot(main = "Sample clustering to detect outliers", sub="", xlab="", cex.lab = 1.5,cex.axis = 1.5, cex.main = 2 ,leaflab = "none")

# Plot a line to show the cut
cutoff = 1000
abline(h = 1000, col = "red");
# Determine cluster under the line
clust = cutreeStatic(sampleTree, cutHeight = 1000, minSize = 10)
table(clust)
# clust 1 contains the samples we want to keep.
keepSamples = (clust==1)
datExpr = datExpr0[keepSamples, ]
nGenes = ncol(datExpr)
nSamples = nrow(datExpr)

traitData = read.csv("metadata_for_r_quoted_limitedParams.csv",check.names=FALSE);
dim(traitData)
names(traitData)
allTraits = traitData;
library(stringr)
allTraits

i <- sapply(allTraits$index, as.character)
allTraits$index <- str_pad(i, 3, pad = "0")
allTraits$index
allTraits

femaleSamples = rownames(datExpr);
femaleSamples
traitRows = match(femaleSamples, allTraits$index);
datTraits = allTraits[traitRows, -1];
rownames(datTraits) = allTraits[traitRows, 1];
collectGarbage();
sampleTree2 = hclust(vegdist(datExpr0, method="bray",na.rm = TRUE), method = "average")
traitColors = numbers2colors(datTraits, signed = FALSE);
plotDendroAndColors(sampleTree2, traitColors,
groupLabels = names(datTraits),
main = "Sample dendrogram and trait heatmap")
save(datExpr, datTraits, file = "FemaleLiver-01-dataInput.RData")

lnames = load(file = "FemaleLiver-01-dataInput.RData");

pdf(file = "Plots/sampleClustering_single_nw.pdf", width = 12, height = 9);

# Choose a set of soft-thresholding powers
powers = c(c(1:10), seq(from = 12, to=20, by=2))
# Call the network topology analysis function
sft = pickSoftThreshold(datExpr, powerVector = powers, verbose = 5)
# Plot the results:
sizeGrWindow(9, 5)
par(mfrow = c(1,2));
cex1 = 0.9;
# Scale-free topology fit index as a function of the soft-thresholding power
plot(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
xlab="Soft Threshold (power)",ylab="Scale Free Topology Model Fit,signed R^2",type="n",
main = paste("Scale independence"));
text(sft$fitIndices[,1], -sign(sft$fitIndices[,3])*sft$fitIndices[,2],
labels=powers,cex=cex1,col="red");
# this line corresponds to using an R^2 cut-off of h
abline(h=0.90,col="red")
# Mean connectivity as a function of the soft-thresholding power
plot(sft$fitIndices[,1], sft$fitIndices[,5],
xlab="Soft Threshold (power)",ylab="Mean Connectivity", type="n",
main = paste("Mean connectivity"))
text(sft$fitIndices[,1], sft$fitIndices[,5], labels=powers, cex=cex1,col="red")

net = blockwiseModules(datExpr, power = 3, ## set the power considering with sampleClustering_single_nw.pdf
TOMType = "unsigned", minModuleSize = 2,
reassignThreshold = 0, mergeCutHeight = 0.25,
numericLabels = TRUE, pamRespectsDendro = FALSE,
saveTOMs = TRUE,
saveTOMFileBase = "femaleMouseTOM",
verbose = 3)

colors = net$colors
MEs = net$MEs
write.csv(net$colors,"single_clusters")
save(MEs, colors, file = "single_MEs.RData")

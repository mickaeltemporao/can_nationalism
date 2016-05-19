#!/usr/bin/env Rscript
# ------------------------------------------------------------------------------
# Title:        TODO: (add title)
# Filename:     intimiste_cor_matrix.R
# Description:  TODO: (write me)
# Version:      0.0.0.000
# Created:      2016-05-03 12:54:53
# Modified:     2016-05-19 10:32:33
# Author:       Mickael Temporão < mickael.temporao.1 at ulaval.ca >
# ------------------------------------------------------------------------------
# Copyright (C) 2016 Mickael Temporão
# Licensed under the GPL-2 < https://www.gnu.org/licenses/gpl-2.0.txt >
# ------------------------------------------------------------------------------

library(dplyr)
library(mice)
library(corrplot)

Data <- read.csv("data/intimiste.csv")

M <- Data %>% select(contains('proud'))
M <- complete(mice(M))
names(M) <- gsub('proud','',names(M))
names(M) <- gsub('.Pco2014','',names(M))

M <- Data %>% select(proudHlthCareBin,
             proudHistoryBin,proudConstitutionBin,proudBeaverBin,
             proudTFoxBin, proudQueenBin, proudCdnFlagBin, proudAnthemBin,
             proudHockeyBin, proudPeacekeepBin, proudArmyBin,
             proudTreatGroupBin, proudMapleLeafBin, proudWildBin,
             proudTimHBin, proudArcticBin, proudCharterBin, proudRcmpBin,
             proudAborigBin)

labs <- c("Healthcare", "History", "Constitution", "Beaver", "Terry Fox", "Queen", "Flag", "Antheem", "Hockey", "Peacekeeping",
"Army", "Groups treatment", "Maple Leaf", "Wilderness", "Tim Hortons", "Arctic", "Charter", "Mounted Police", "First Nations")
names(M) <- labs

mcor <- round(cor(M, use = "pairwise.complete.obs"),1)

png(height=1200, width=1200, pointsize=25, file="figs/intimiste_cor_full.png")
# Ordered by first principal.
corrplot(mcor, method = 'color', type = 'lower',
         addgrid.col='black',
         order='FPC', tl.cex=0.6, tl.col='black', tl.srt = 25, tl.offset = 0.6,
         number.cex=0.6, number.digits=1, addshade='positive',
         addCoef.col='black')
dev.off()

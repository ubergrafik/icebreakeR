# Load the data

ufc <- read.csv("data/ufc.csv")

# Input sample design parameter and population size for later computation.
ufc_baf <- 7
ufc_area <- 300


###
### EXAMINING/WRANGLING/CLEARING THE DATA 
###

# examine the str()ucture of the data
# check the first few rows for missing values (na)
str(ufc)
head(ufc)
colSums(is.na(ufc))

#append the units to the variable names to be sure that the
#reader can easily interpret the statistics that we will later compute.
ufc$height_m <- ufc$height/10
ufc$dbh_cm <- ufc$dbh/10

str(ufc)

#obtain some useful snapshots of the data
range(ufc$dbh_cm)
range(ufc$height_m, na.rm = TRUE)

# remove the '0' heighg data
ufc$height_m[ufc$height_m <0.1] <- NA
range(ufc$height_m, na.rm = TRUE)

# How do the numbers of trees of each species look?
table(ufc$species)

# merge data for species that are likely to be the same (F, FG and GF)
ufc$species[ufc$species %in% c("F","FG")] <- "GF"
ufc$species <- factor(ufc$species)
table(ufc$species)

# How many missing heights do we have for each species?
table(ufc$species[is.na(ufc$height_m)])


###
### DOING SOME PLOTS OF THE DATA 
###


boxplot(dbh_cm ~ species, data=ufc, ylab="Dbh (cm)")

boxplot(height_m ~ species, data=ufc, ylab="Height (m)")

scatter.smooth(ufc$dbh_cm, ufc$height_m)

hist(ufc$dbh_cm, breaks=(0:50) * 2.5, col="darkseagreen3", main="")

# load lattice library
# this command should go at the top really - e.g. loading dependancies etc.
library(lattice)

histogram( ~ dbh_cm | species, data = ufc)



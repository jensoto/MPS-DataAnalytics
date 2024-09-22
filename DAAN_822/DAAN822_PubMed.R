install.packages("RISmed")
install.packages("rentrez")

library(RISmed)
library(rentrez)

query = "(exome OR whole OR deep OR high-throughput OR (next AND generation) OR (massively AND parallel)) AND sequencing"

ngs_search <- EUtilsSummary(query, type="esearch",db = "pubmed",mindate=2011, maxdate=2013, retmax=30)

QueryCount(ngs_search)

ngs_records <- EUtilsGet(ngs_search)

y <- YearPubmed(ngs_records)

ngs_pubs_count <- as.data.frame(table(y))

QueryCount(ngs_search)

y

ngs_pubs_count
PMID(ngs_records)
Author(ngs_records) [[1]]

## Lesson 5 Discussion
# From the PubMed database obtain the latest records corresponding to 
#the articles published on the topic of “COVID 19”. Show the frequency 
#distribution of the number of papers published in each year.

# Loads library
library(RISmed)

# Creates query
covid19_query = "COVID 19 AND SARS-CoV"

# Runs query
ngs_search <- EUtilsSummary(covid19_query, type = "esearch", db = "pubmed",
                            mindate = 2019, maxdate = 2022, retmax = 500)
# Count of query results
QueryCount(ngs_search)

# Assign search results to variables to create frequency distribution table
ngs_records <- EUtilsGet(ngs_search)

y <- YearPubmed(ngs_records)

# Store results in data frame and print them
ngs_pubs_count <- as.data.frame(table(y))
ngs_pubs_count

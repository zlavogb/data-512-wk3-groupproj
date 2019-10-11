
require(data.table)

# read in data files
comments_sample <- data.table(read.table(file = 'aggression_annotated_comments_sample.tsv', sep = '\t', header = TRUE))
comments <- data.table(read.table(file = 'aggression_annotated_comments.tsv', sep = '\t', header = TRUE))
annotations_sample <- data.table(read.table(file = 'aggression_annotations_sample.tsv', sep = '\t', header = TRUE))
annotations <- data.table(read.table(file = 'aggression_annotations.tsv', sep = '\t', header = TRUE))
workers <- data.table(read.table(file = 'aggression_worker_demographics.tsv', sep = '\t', header = TRUE))


### Analyze worker demographic data
  # see distribution of enlgish first language speakers
  hist(workers$english_first_language)
  sum(workers$english_first_language)
  
  # Check on gender distribution
  nrow(workers[gender=="male"] )/nrow(workers )
  
  # Check on education distribution
  nrow(workers[education=="hs"] )/nrow(workers )
  nrow(workers[education=="bachelors"] )/nrow(workers )
  nrow(workers[education=="masters"] )/nrow(workers )
  nrow(workers[education=="doctorate"] )/nrow(workers )
  nrow(workers[education=="none"] )/nrow(workers )
  nrow(workers[education=="professional"] )/nrow(workers )
  nrow(workers[education=="some"] )/nrow(workers )

### Analyze the annotation data
  # How many aggressive comments?
  nrow(annotations[aggression == 1] )/nrow(annotations )
  # How aggressive were they scored?
  hist(annotations$aggression_score)
  nrow(annotations[aggression_score == -1] )/nrow(annotations )
  nrow(annotations[aggression_score == -2] )/nrow(annotations )
  nrow(annotations[aggression_score == -3] )/nrow(annotations )
  nrow(annotations[aggression_score == 1] )/nrow(annotations )
  nrow(annotations[aggression_score == 2] )/nrow(annotations )
  nrow(annotations[aggression_score == 3] )/nrow(annotations )
  nrow(annotations[aggression_score == 0] )/nrow(annotations )
  
  nrow(annotations[aggression_score == 0 & aggression == 1] )/nrow(annotations[aggression == 1] )
  nrow(annotations[aggression_score == -1 & aggression == 1] )/nrow(annotations[aggression == 1] )
  nrow(annotations[aggression_score == -2 & aggression == 1] )/nrow(annotations[aggression == 1] )
  nrow(annotations[aggression_score == -3 & aggression == 1] )/nrow(annotations[aggression == 1] )
  
  
### Merge together worker and annotation data
  wrk_ann <- merge(annotations, workers, by = "worker_id", all.x = T)
  
  # What proportion of comments do females mark as aggressive?
  hist(wrk_ann[gender=="female"]$aggression_score)
  hist(wrk_ann[gender=="male"]$aggression_score)
  hist(wrk_ann[gender=="male"]$aggression)
  nrow(wrk_ann[aggression == 1 & gender == "female"])/nrow(wrk_ann[gender == "female"])
  nrow(wrk_ann[aggression == 1 & gender == "male"])/nrow(wrk_ann[gender == "male"])
  
  # What proportion of comments do english vs nonenglish language mark as aggressive?
  hist(wrk_ann[english_first_language == 1]$aggression_score)
  hist(wrk_ann[english_first_language == 0]$aggression_score)
  nrow(wrk_ann[aggression == 1 & english_first_language == 1])/nrow(wrk_ann[english_first_language == 1])
  nrow(wrk_ann[aggression == 1 & english_first_language == 0])/nrow(wrk_ann[english_first_language == 0])
  
  #hist(wrk_ann[gender == "female"]$aggression)
   
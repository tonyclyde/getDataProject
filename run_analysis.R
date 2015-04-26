#Requires dplyr
library(dplyr)

# Load the main data files
train_vals <- read.table("data/train/X_train.txt")
test_vals <- read.table("data/test/X_test.txt")

# bind descriptive column names (with pesky parentheses removed)
col_name_data <- read.table("data/features.txt", colClasses = c("NULL", "character"))
col_names <- sub("\\(\\)", "", col_name_data[[1]])
names(train_vals) <- col_names
names(test_vals) <- col_names

# remove columns that are not mean or std variables
mean_std_regex <- "^.*(mean|std)($|-.*$)"
cols_to_keep <- grep(mean_std_regex, col_names)
train_vals <- train_vals[, cols_to_keep]
test_vals <- test_vals[, cols_to_keep]

# add the subject ids to the data
test_vals["subject_id"] <- read.table("data/test/subject_test.txt")
train_vals["subject_id"] <- read.table("data/train/subject_train.txt")

# add the activity ids to the data
test_vals["activity_id"] <- read.table("data/test/y_test.txt")
train_vals["activity_id"] <- read.table("data/train/y_train.txt")

# merge the test and train data
data <- merge(train_vals, test_vals, all = TRUE)

# load the activity descriptions
act_labels <- read.table("data/activity_labels.txt", col.names = c("activity_id", "activity"))

# add the activity descriptions
data <- merge(data, act_labels, by = "activity_id", all = TRUE)

# remove "activity_id", leave descriptive "activity" column
data <- mutate(data, activity_id = NULL)

# create a second data set of column mean values, grouped by subject_id and activity
data_avg <- data %>% group_by(subject_id, activity) %>% summarise_each(funs(mean), matches(mean_std_regex)) %>% arrange(subject_id, activity)

# Finally, write the result file
write.table(data_avg, file = "tidy_data.txt", row.name=FALSE)
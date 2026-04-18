#!/usr/bin/env Rscript
install.packages("argparse", repos = "https://cran.rstudio.com/")
# if doesn't work add this: install.packages("argparse", repos = "https://cran.rstudio.com/")
suppressPackageStartupMessages({
  library(argparse)
})
options('python_cmd'='C:/ProgramData/Anaconda3/python.exe')
  
TASK_FILE <- ".tasks.txt" # nolint # the .tasks.txt is where the list is saved to

add_task <- function(task_input) {
  if (is.null(task_input) || length(task_input) == 0 || task_input == "") {
    print("Error: No tasks provided.")
    return(NULL)
  } # This checks if the task is empty
  if (!exists("tasks") || nrow(tasks) == 0) {
    next_id <- 1 #if the task is empty it'll start from 1 
  } else {
  next_id <- max(tasks$id) + 1 #adds 1 to already existing number of tasks
  }
  new_task_row <- data.frame(
    id = next_id,
    task = as.character(task_input),
    stringsAsFactors = FALSE
  ) # ensures right type characters used
  return(new_task_row)
  }

list_tasks <- function() { 
  if (file.exists(TASK_FILE)) {
  tasks <- readLines(TASK_FILE)
  } else {
    return("") # this returns empty string if no file is found
  } 
  if (length(tasks) == 0) {
    return("Empty") # in case there are empty files
  }
  formatted_rows <- paste0(seq_along(tasks), '. ', tasks) #seq_along(tasks) adds the numbers before the items
  final_string <- paste(formatted_rows, collapse = "\n") # collapses all rows into a single string
  return(final_string)
}

    
remove_task <- function(index) {
  if (!file.exists(TASK_FILE)) {
    stop('Error: List is empty.') # the stop() abandons the function
  return(NULL) # ! = NOT, so if tasks don't exist or there are no rows in the list then states that
  } 
  tasks <- readLines(TASK_FILE)
  if (length(tasks) == 0) {
    stop('Error: List is empty!') # again stop() will make the test work
  } 
  if (index < 1 || index > length(tasks))
  { stop("Error: wrong index.") # should stop task if a wong index is entered
  }else {
  tasks <- tasks[-index] # REMOVES TASK, it keeps everything except the item at the chosen index
  # [] these show a specific subset of a table
  writeLines(tasks, TASK_FILE)
  print(paste('Task', index, 'removed'))
  }
} #continue by testing this.

main <- function(args) {

  if (!is.null(args$add)) {
    add_task(args$add)
  } else if (args$list) {
    tasks <- list_tasks()
    print(tasks)
  } else if (!is.null(args$remove)) {
    remove_task(args$remove)
  } else {
    print("Use --help to get help on using this program")
  }
}


if (sys.nframe() == 0) {

  # main program, called via Rscript
  parser <- ArgumentParser(description = "Command-line Todo List")
  parser$add_argument("-a", "--add",
                      help = "Add a new task")
  parser$add_argument("-l", "--list",
                      action = "store_true",
                      help = "List all tasks")
  parser$add_argument("-r", "--remove",
                      help = "Remove a task by index")

  args <- parser$parse_args()
  print(args)
  main(args)
}

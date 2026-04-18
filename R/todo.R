#!/usr/bin/env Rscript
# install.packages("argparse") - add this line incase this package isnt already installed
# if doesn't work add this: install.packages("argparse", repos = "https://cran.rstudio.com/")
suppressPackageStartupMessages({
  library(argparse)
})
options('python_cmd'='C:/ProgramData/Anaconda3/python.exe')
  
TASK_FILE <- ".tasks.txt" # nolint # the .tasks.txt is where the list is saved to

add_task <- function(task_input) {
  if (is.null(task_input) || length(task_input) == 0 || task_input == "") {
    return(NULL)
  } # This checks if the task is empty
  if (file.exists(TASK_FILE)) {
    tasks <- readLines(TASK_FILE)
  } else {
    tasks <- character() # if there are no current tasks it'll start empty
  }
    tasks <- c(tasks, task_input) # this combines the new task with the list (thats what the c does)
    writeLines(tasks, TASK_FILE) # this will save the updated list, so you can see the new item
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
    stop() # the stop() abandons the function
  return(NULL) # ! = NOT, so if tasks don't exist or there are no rows in the list then states that
  } 
  tasks <- readLines(TASK_FILE)
  if (length(tasks) == 0) {
    stop() # again stop() will make the test work
  } 
  if (index < 1 || index > length(tasks))
  { stop() # should stop task if a wrong index is entered
  }else {
  tasks <- tasks[-index] # REMOVES TASK, it keeps everything except the item at the chosen index
  # [] these show a specific subset of a table
  writeLines(tasks, TASK_FILE)
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

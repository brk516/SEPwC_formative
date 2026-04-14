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

list_tasks <- function(show_tasks) {
  if (nrow(show_tasks) == 0) {
    print('List empty!')
  } else {
    print(show_tasks)
  }
}

remove_task <- function(index) {

}

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

#!/usr/bin/env Rscript
install.packages("argparse")
# if doesn't work add this: install.packages("argparse", repos = "https://cran.rstudio.com/")
suppressPackageStartupMessages({
  library(argparse)
})
options('python_cmd'='C:/ProgramData/Anaconda3/python.exe')

parser <- ArgumentParser(description='command-line todo list')
  parser$add_argument('-a', '--add', 
                      help='Add new task')
  # using the action='store true' command means you don't need to type anything after list to make it list stuff
  parser$add_argument('-l', '--list', 
                      action='store_true', help='List all tasks')
  parser$add_argument('-r', '--remove', 
                      type='integer', help='Remove a task by index')
  # the index is the number position of an item in the list 
  # e.g. --remove 2 would remove the second item in the list
  args <- parser$parse_args() #
    if (!is.null(args$add)) {
      print(paste('Added:', args$add))
      # this should add args$add to list
    }
    if (args$list) {
      print('Tasks:')
      # should print the list
    }
    if (!is.null(args$remove)) {
      print(paste('Removing task:', args$remove))
      # should remove task at the position args$remove
    }
  main <- function(args) {
    if (file.exists('task.csv')) {
      tasks <<- read.csv('tasks.csv', stringsAsFactors = FALSE)
    } else {
      tasks <<- data.frame(id = integer(), task = character())
    }
  } # loads existing tasks to bypass the amnesia problem ie rebuting the task each time
  
  
TASK_FILE <- ".tasks.txt" # nolint

add_task <- function(task_input) {
  if (is.null(task_input) || length(task_input) == 0 || task_input == "") {
    message("Error: No task description provided.")
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

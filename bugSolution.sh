#!/bin/bash

# This script demonstrates a solution to the race condition bug using file locking.

# Create two files
touch file1.txt
touch file2.txt

# Function to write to a file with locking
write_to_file() {
  local file=$1
  local message=$2
  flock -n 200  <<< "$message" # lock the file for writing
  if [ $? -eq 0 ]; then
    echo "$message" >> "$file"
    echo "Written to $file: $message"
    flock -u 200
  else
    echo "Could not acquire lock on $file"
  fi
}

# Write to the files concurrently with file locking
(while true; do write_to_file file1.txt "Process 1"; sleep 1; done) &
(while true; do write_to_file file2.txt "Process 2"; sleep 1; done) &

# Wait for a few seconds to allow the processes to write
sleep 5

# Kill the background processes
kill %1
kill %2

# The content of file1.txt and file2.txt should be complete and correct

echo "Check file1.txt and file2.txt for complete content"
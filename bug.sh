#!/bin/bash

# This script demonstrates a race condition bug.

# Create two files
touch file1.txt
touch file2.txt

# Start two processes that will write to the files concurrently
(while true; do echo "Process 1" >> file1.txt; sleep 1; done) &
(while true; do echo "Process 2" >> file2.txt; sleep 1; done) &

# Wait for a few seconds to allow the processes to write
sleep 5

# Kill the background processes
kill %1
kill %2

# The content of file1.txt and file2.txt may be incomplete or corrupted due to the race condition

echo "Check file1.txt and file2.txt for incomplete or corrupted content"
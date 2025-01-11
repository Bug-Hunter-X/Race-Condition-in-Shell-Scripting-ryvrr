# Race Condition Bug in Shell Script

This repository demonstrates a race condition bug in a simple shell script.  Two processes attempt to write to separate files concurrently. The lack of synchronization creates a race condition, potentially leading to incomplete or corrupted file data. The solution provides a method to mitigate this by using file locking.
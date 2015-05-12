Some less known shell commands
------------------------------

I'll be listing a few shell tricks in this file, gathered from experience with shell projects,
or from the book 'The Linux Bible'

**Some nice commands**\n

- ln -s <file> <linkname> - Creates a symlink.
- ls -R lists all files recursively.
- ls -S lists them by size.

**Some files you should know about**\n

- /etc/passwd - Stores information about user. *Confirm*

**File permissions**\n

First bit in *ls -l* is for directory. Next 3 for owner, next 3 for group and last 3 for others.
chmod xyz -- x for owner, y for group, z for others.
Their numerical values have specific meanings: 
- 7 -- rwx
- 6 -- rw
- 5 -- rx
- 4 -- r

Use -R to give the specific permissions to the whole directory.

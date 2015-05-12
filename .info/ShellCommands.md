Linux tips and tricks
------------------------------

I'll be listing a few Linux tricks in this file, gathered from my own (often destructive) experiences,
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

Another way is to use characters. Doing u+rw adds write permissions for user. Similarly for g (group) and o (other).
Doing a o-rw for example removes read write permissions for others.\n

Use -R to give the specific permissions to the whole directory.\n

*umask* decides the default permissions for a file/directory.\n

To own a file, you need to go sudo and take over the permissions with this format: *chown username:username filename*\n
This assigns the file to the user and the group of the user (only one *username* leaves the group root.)\n


**TODO**\n

- Add how to make a command run without sudo ( http://askubuntu.com/questions/159007/ )

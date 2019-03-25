# Git Commit Automation
This shell script can be used to automate git basic process, such as git add, git commit and git push.

This script can be used as shown

```
./git.sh
```
This will be pointing to **origin** as it's default remote and **current branch** in which we are making changes.This will be prompting you commit message. Commit message should have message pattern as follows: 

```
[project_code-ticket_number] commit message
```

### Why should my commit message be in this format?
This is easy to track and when we follow this pattern for commiting code. changes which are made will be easier to track, Also when used with agile method ticket are also been kept track of.

### Optional operations
1. Changing remote repo
```
./git.sh remote
```
Here remote will be our new target remote. By default it is **origin**

2. Changing branch
```
./git.sh remote branch
```
Here we can pass secound argument as brach which will change branch to which we want to change instead of current working branch.

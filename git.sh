#!/bin/sh

#####
##### Check if .git file is there or not. Check for git initalization
#####

if [ -e .git ]
then
    # Get current working brach
    CURRENT_BRANCH=$(eval "git branch | grep \* | cut -d ' ' -f2")

    #####
    ##### Handling command line argument
    #####

    # Setting up default
    REMOTE="origin" # TOBE replaced with origin from git remote
    BRANCH=$CURRENT_BRANCH

    # Checking argument length
    if [ $# -eq "2" ]
    then
    # Two arguments script call ./git.sh [remote] [branch]
    REMOTE="$1"
    BRANCH="$2"
    elif [ $# -eq "1" ]
    then
    # One arguments script call ./git.sh [remote]
    REMOTE="$1"
    elif [ $# -gt "2" ]
    then
    # Invalid script call
    echo "Invalid usage of the script"
    echo "usage: ./git.sh [remote] [branch]"
    exit 1
    fi

    echo "Remote is "$REMOTE" and branch is "$BRANCH

    ##### 
    ##### Checking Branch
    #####

    # List of blacklisted branch's
    BLACKLISTED_BRANCH=("dev" "staging" "pre-prod" "master")

    # Length of Black list branch
    BLACKLISTED_BRANCH_LENGTH=${#BLACKLISTED_BRANCH}

    # Loop iterator initial value
    i=0

    # Looping through individual items
    while [ $i -le $BLACKLISTED_BRANCH_LENGTH ]
    do
        # Item from each iteration.
        BLACKLISTED_BRANCH_ITEM=${BLACKLISTED_BRANCH[$i]}

        # Checking if branch is blacklisted
        if [ $BLACKLISTED_BRANCH_ITEM == $BRANCH ]
        then
            # Stop the process my giving a warning
            echo "Your not allowed to push your code to "$BRANCH
            exit 1
        fi
        
        # Increamenting iterator value by one
        i=$((i+1))
    done

    # local file tracking
    git add .

    # Git commit message
    read -p "Enter commit message here: " MSG

    # Checking YML commit pattern
    if [[ $MSG =~ [[a-zA-z]*-[0-9]*][a-zA-Z0-9[:space:]:!.,]*$ ]]
    then
        git commit -m "$MSG"
    else
        printf "Commit is not in proper format...\n\nusage:\n\n [project code - ticker number]: commit message"
        exit 1
    fi

    # Pushing changes to repo
    git push $REMOTE $BRANCH
else
    echo ".git file is not there"
fi

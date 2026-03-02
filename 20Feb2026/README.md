# First README Notebook 📓

This is one of my first notes from class,  
focused on learning Git commands and how version control works.

---

# Basic Git Commands

## Git Commands – Bash

When starting a new repository on GitHub, there are different commands that allow you to manage your project using Git in Bash.

Here are some of the most important ones:

---

## 🔹 git init

You can use this command to start a new repository.  
It initializes Git in the current directory you are working in.  

This creates a hidden `.git` folder that will track all changes in your project.  
From there, you can start creating branches and managing versions of your files.

```bash
git init
```

## 🔹 git clone

git clone https://github.com/username/repository.git

This command allows you to clone a repository from GitHub.
It downloads all the files, commits, and version history from the repository and brings them to your local machine.

In my case, I use Visual Studio Code to work with the cloned project.

Inside the cloned repository, you can:

See all the commits made by the owner

Check the changes made in every version

Compare modifications between versions

Track who made changes and when

This is one of the most powerful features of Git: version control.

## 🔹 git status
git status

This command allows the user to check the repository status.

It shows:

Modified files

New files not yet tracked

Files ready to be committed

The current branch you are on

It helps you understand what is happening inside your repository before making a commit.

## 🔹 git add
git add .

This command adds all modified files to the staging area.

The staging area is like a preparation space where you select the changes you want to include in your next commit.

## 🔹 git commit
git commit -m "Your commit message"

This command saves your changes with a descriptive message.

Each commit creates a checkpoint in your project history, allowing you to go back to previous versions if needed.

## 🔹 git push
git push origin main

This command uploads your committed changes to GitHub.

It connects your local repository with the remote repository and updates it with your latest changes.

## 🔹 git pull
git pull origin main

This command downloads the latest changes from the remote repository and updates your local project.

It is useful when working in teams or when you made changes directly from GitHub.

# 🌿 Branches and Tags
## 🔹 git branch
git branch

This command shows all existing branches in your repository.

Branches allow you to work on new features without affecting the main project.

To create a new branch:

git branch new-feature
## 🔹 git checkout
git checkout new-feature

This command switches to another branch.

You can also create and switch in one step:

git checkout -b new-feature
## 🔹 git merge
git merge new-feature

This command merges changes from one branch into another.

For example, you can merge a feature branch into the main branch after finishing development.

## 🔹 git tag
git tag v1.0

Tags are used to mark specific points in your project history, usually for releases.

For example:

v1.0 → First stable version

v2.0 → Major update

Tags help organize versions in a more professional way.

# Branch Conflict

Normally when youre updating you branches or mostly the main one you can merge it with another one if you prefer to release the branch version as the main one
This will follow a path by itself where the new branch gets in to the main one and continues to follow the main path of the updates until you create a new diferent one.

there can be some situations where you update the same line in your master branch as you did in the new branch and when you try to merge it there is gonna be an issue where you get the merge conflict, you can only update rows that are before the main row so they become part of the main one and if you try to merge it in the wrong way you are going to need to delete one the lines of your code or document where both of the updates were done in one of the branches you have created

![BranchesConflict](/assets/Captura%20de%20pantalla%202026-02-20%20094013.png)


27 - Feb - 2026

⚙️ Advanced Configuration & Identity
Before making commits, Git needs to know who is responsible for the changes.

🔹 git config
This sets your identity globally on your machine.

Bash
# Set your name and email (Required for commits)
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Check your current configuration
git config --list
🔹 Managing Credentials (Logout/Security)
If you are using a shared computer and want to remove your data and credentials safely:

Unset Identity: Remove your name and email from the global config.

Bash
git config --global --unset-all user.name
git config --global --unset-all user.email
Clear Saved Passwords: * Windows: Go to Control Panel > User Accounts > Credential Manager > Windows Credentials and remove entries related to git:https://github.com.

Terminal (Universal): Tell Git to stop remembering your credentials.

Bash
git config --global --unset credential.helper
🌐 Remote Repository Management
Commands to manage the link between your local folder and servers like GitHub.

🔹 git remote
Bash
# Add a new remote connection
git remote add origin https://github.com/username/repo.git

# Change the URL of an existing remote
git remote set-url origin https://github.com/username/new-repo.git

# Remove a remote connection
git remote remove origin

# List all connected remotes and their URLs
git remote -v
🌿 Modern Branching & Navigation
While git checkout is classic, Git recently introduced switch and restore to make commands more intuitive.

🔹 git switch
Designed specifically for moving between branches.

Bash
# Switch to an existing branch
git switch main

# Create a new branch and switch to it immediately
git switch -c feature-name
🔹 git restore
Used to undo changes in your working directory.

Bash
# Discard changes in a specific file (revert to last commit)
git restore filename.txt

# Unstage a file (remove it from the 'git add' area)
git restore --staged filename.txt
🏷️ Advanced Tagging
In your README, you mentioned creating tags. However, tags are not automatically sent to GitHub when you push code.

Bash
# Create a tag
git tag v1.0

# Push a specific tag to GitHub
git push origin v1.0

# Push ALL local tags to GitHub at once
git push origin --tags

# Delete a local tag
git tag -d v1.0
🧹 Cleanup & Reset
To keep your project history clean or fix mistakes.

🔹 git reset
Bash
# Undo the last commit but keep your work in the files (Soft)
git reset --soft HEAD~1

# DELETE the last commit and all changes in the files (Hard - Dangerous!)
git reset --hard HEAD~1
🔹 git clean
Removes untracked files (files that are not yet added to Git) to keep your folder tidy.

Bash
# See what would be deleted
git clean -n

# Force delete untracked files and directories
git clean -fd
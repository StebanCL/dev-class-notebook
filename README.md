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
#!/bin/bash

# Define the directories
GITHUB_IO_DIR="../tsaisean.github.io"

# Step 1: Run Hugo command to build the site
echo "Building Hugo site..."
hugo

# Step 2: Accept an optional commit message from the user
COMMIT_MSG="${1:-"Update site content"}"

echo "Committing changes in my-blog-site repository..."
git add -A
git commit -m "$COMMIT_MSG"
git push origin main

# Step 3: Copy files from the public folder to tsaisean.github.io folder
echo "Copying files to tsaisean.github.io directory..."
cp -r "public/"* "$GITHUB_IO_DIR/"

# Step 4: Commit and push changes in tsaisean.github.io repo
echo "Committing changes in tsaisean.github.io repository..."
cd "$GITHUB_IO_DIR"
git add -A
git commit -m "$COMMIT_MSG"
git push origin main

echo "Deployment complete!"
echo "Your site is now live at: https://tsaisean.github.io/"

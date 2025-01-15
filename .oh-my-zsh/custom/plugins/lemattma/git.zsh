alias gcurr='git rev-parse --abbrev-ref HEAD'

# Switch to
alias master='git checkout master'
alias main='git checkout main'
alias develop='git checkout develop'

# Switch and update
alias masterpu='master && git pull origin master'
alias mainpu='main && git pull origin main'
alias developpu='develop && git pull origin develop'

# Fetch and update other branch
alias masterfe='git fetch origin master:master'
alias mainfe='git fetch origin main:main'
alias developfe='git fetch origin develop:develop'

# Undo a commit
alias gundocommit='git reset --soft HEAD^'

# Amend last commit
alias gupdatecommit='git add . && git commit --amend --no-edit'

# Create a patch
alias gpatch='git add . && git diff --cached >'

# Stash
alias gsh='git add . && git stash'
alias gshp='git stash pop'
alias gshl='git stash list'
alias gshd='git stash drop'

# Push current branch
function gpush() {
  git push -f origin `gcurr`
}

# current branch's SHA
function gsha() {
  git rev-parse --quiet `gcurr`
}

function gcbranches() {
  git branch -r
  du -sh .git
  git fetch origin `gcurr` --prune --prune-tags
  git branch -r --no-contains `gsha` | xargs -I{} git branch -rd "{}"
  git gc --prune=now
  git branch -r
  du -sh .git
}

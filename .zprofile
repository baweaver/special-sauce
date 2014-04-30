# BAWeaver ZSH Profile
# ====================
#
# A collection of my aliases, shortcuts, and other shell based functions to speed up production
#
# So why do I put a comment after aliases? alias_ls details them all
#
# Motto: Automate and Alias all the things! If it takes more than 5 keystrokes and you do it more than
# five times in a day, script it. No exceptions, document it and fix it.
#
# Here's a list of sites I've found cool things from, and borrowed, as well as the suffix I tag their
# commands with:
#
# [Ben] Ben Orenstein
# [CLF] http://commandlinefu.com

# Initializers and Path
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Aliases
# =======

# Shell aliases
# -------------

# Functions
mkcd () { mkdir $1 && cd $1; }    # Make Directory and CD into it
cdl () { cd $1 && ls -la $1; }    # Change Directory and List files
most_used () {                    # Find which commands I use the most
  history | awk '{a[$2]++}END{for(i in a){print a[i] " " i}}' | sort -rn | head
}

# File actions
alias chx="chmod +x"           # Make something executable
alias search="find . -name $1" # Find by name. I can never remember this thing...
alias tree="ls -laR $1 | more" # List all files recursively in long format

# Gloabal aliases
alias -g C="| pbcopy"          # Suffix: Copy output to clipboard
alias -g G="| grep"            # Suffix: Grep [Ben]
alias -g M="| more"            # Suffix: More [Ben]
alias -g S="| sed"             # Suffix: Sed

alias c="clear"                             # Clear

# Ruby Aliases
# ------------

alias gin="gem install" # Shortened version of gem install
alias gsv="gem server"  # Start a web server for local docs
alias rb="ruby"         # Shortened version of ruby
alias pgm="pry --gem"   # Pry for gems
alias ln="launchy"      # Launchy

# Rails Aliases
# -------------

# Rails Utilities
alias rcon="rails console"            # Open Rails Console
alias rnew="rails new"                # Create a new Rails Project

# Rails Databases
alias rdbd="rake db:create db:migrate RAILS_ENV=development" # Make Dev DB
alias rdbt="rake db:create db:migrate RAILS_ENV=test"        # Make Test DB

# Rails Generators
alias rgc="rails generate controller" # Generate a Controller
alias rgm="rails generate model"      # Generate a Model
alias rgs="rails generate scaffold"   # Generate a Scaffold
alias rgv="rails generate view"       # Generate a View

# Rails Bundle / Rake Tasks
alias bins="bundle install"           # Install Gems
alias brake="noglob bundle exec rake" # Rake fix for ZSH
alias rdbm="rake db:migrate"          # Update the DB
alias bup="bundle update"             # Bundle Update

# Rails RSPEC Testing
alias ber="bundle exec rspec"                  # Run RSPEC
alias berp="bundle exec rspec -p --"           # Run RSPEC and profile
alias bet="bundle exec teaspoon"               # Run Teaspoon
alias beta="bundle exec teaspoon --format tap" # Run Teaspoon in Tap format


# Git Aliases
# -----------

# Git Branching
alias -g cb="echo `git symbolic-ref HEAD 2>/dev/null | cut -d '/' -f 3`" # Current Branch name
alias -g cbp="echo `cb | cut -d '-' -f1,2`" # Get Current Branch prefix
alias gcb="git checkout -b"       # Git Checkout New Branch
alias pbr="gpo cb"                # Push the current branch to origin
alias gchk="git checkout -b"      # Check out a branch, make a new one if it doesn't exist
alias gmain="git checkout master" # Check out master
alias gmm="git merge master"      # Merge master into the current branch
alias gmp="gmain && git pull"     # Check out master and pull changes
alias gmp_m="gmp && gmm"          # Checkout master, pull, and merge
alias gpo="git push origin"       # Push to the origin of a branch
alias gp="git pull"               # Git Pull
alias ga="git add"                # Git Add
alias grm="git rm"                # Git Remove
gcm () {
  git commit -m "`cbp` $*"
}

# Commits
get_commits () {
  i=1
  url="`git config --get remote.origin.url | sed 's/\.git//'`/commit"
  git log --pretty=oneline -$1 | while read line; do
    commit="$url/`echo $line | sed 's/^\([0-9a-f]*\) .*$/\1/'`"
    message="`echo $line | sed 's/^[0-9a-f]* \(.*\)$/\1/'`"
    echo "[$i] $message:\n$commit\n"
    i=`expr $i + 1`
  done
}

cp_last_commit () {
  get_commits 1 | tail -1 | pbcopy
}
op_last_commit () {
  launchy `get_commits 1 | tail -1`
}


# Git statuses
alias g="git"          # Find the status of files, a lot shorter
alias gst="git status" # Git Status
alias gd="git diff"    # List differences from the last commit

# Vim Aliases
# -----------

alias v="vim"            # Shorten Vim
alias vc="vim ."         # Open the current directory in Vim
alias vrc="vim ~/.vimrc" # Edit my Vimrc

# Theme / Dotfile editing shortcuts
# ---------------------------------
alias vtmux="v ~/.tmux.conf"                            # Edit TMUX Conf
alias vtheme="v ~/.oh-my-zsh/themes/agnoster.zsh-theme" # Edit the Agnoster theme

# Z Profile Aliases
# -----------------

alias s="source"               # Source
alias szp="s ~/.zprofile"      # Reload my zprofile
alias vzpf="v ~/.zprofile"     # Edit my zprofile

# Notes Aliases
# -------------

alias fix="echo $1 >> ~/fix"          # What do I need to fix? For quick notes, like alias additions
alias todo="vim ~/todo"               # Add things to a to do list

# Python Aliases
# --------------

alias pins="pip install"                           # Shortened pip install
alias py="python"                                  # Shortened version of Python
alias pysins="py setup.py install"                 # Shortened Python Lib Install
alias ven="virtualenv venv && . venv/bin/activate" # Make a new Virtual Env and activate it
vact () { . $1/bin/activate }                      # Activate Python Venv

#  Misc Aliases
# -------------

alias asset_clear="rake assets:clobber && rake tmp:clear"
alias blue_steel_update="bundle update && asset_clear"

# Script Aliases
# --------------

alias alias_ls="~/scripts/alias_list.rb | more" # List Aliases and their definitions
# Make a new alias and load it
new_alias () {
  echo "alias $1=\"$2\" # $3" >> ~/.zprofile && szp
}

# Java / Scala Aliases
# --------------------
alias mcc="mvn clean compile" # maven clean compile

# ZSH Configs
# -----------

export TERM="xterm-256color"
ZSH_THEME="agnoster"

# Unsorted Aliases - Literally everything appended at the end
# ----------------
alias rks="rake site" # rake site
export EDITOR=vim
alias mcin="mvn clean install" # maven clean install

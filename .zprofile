# BAWeaver ZSH Profile
# ====================
#
# A collection of my aliases, shortcuts, and other shell based functions to speed up production
#

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# A. Functions
# ============

function mkcd { mkdir $1 && cd $1; } # Make Directory and CD into it
function cdl { cd $1 && ls -la $1; } # Change Directory and List files

# B. Aliases
# ==========

# 1. Shell aliases
# ----------------

alias cdl=cdl $1               # Change Directory and list files inside
alias mkcd=mkcd $1             # Make Directory and CD into it
alias tree="ls -laR $1 | more" # List all files recursively in long format
alias search="find . -name $1" # Find by name. I can never remember this thing...

# 2. Rails Aliases
# ----------------

# a. Rails utilities
alias rcon="rails console"
alias rnew="rails new"

# b. Rails Generators
alias rgs="rails generate scaffold"
alias rgc="rails generate controller"
alias rgv="rails generate view"
alias rgm="rails generate model"

# c. Rails Bundle / Rake Tasks
alias bins="bundle install"
alias rdbm="rake db:migrate"

# d. Rails RSPEC Testing
alias ber="bundle exec rspec"

# 3. Git Aliases
# --------------

# a. Git Branching
alias gchk="git checkout -b"      # Check out a branch, make a new one if it doesn't exist
alias gmain="git checkout master" # Check out master
alias gmp="gmain && git pull"     # Check out master and pull changes
alias gmm="git merge master"      # Merge master into the current branch
alias gmp_m="gmp && gmm"          # Checkout master, pull, and merge
alias gpo="git push origin"       # Push to the origin of a branch

# b. Git statuses
alias g="git status" # Find the status of files, a lot shorter
alias gd="git diff"  # List differences from the last commit

# 4. Vim Aliases
# --------------

alias v="vim"            # Shorten Vim
alias vrc="vim ~/.vimrc" # Edit my Vimrc
alias vc="vim ."         # Open the current directory in Vim

# 5. Z Profile Aliases
# --------------------

alias vzprof="vim ~/.zprofile"  # Edit my zprofile
alias zsrc="source ~/.zprofile" # Reload my zprofile

# 6. Notes Aliases
# ----------------

alias note="vim ~/note"      # Add things to notes
alias todo="vim ~/todo"      # Add things to a to do list
alias fix="echo $1 >> ~/fix" # What do I need to fix? For quick notes, like alias additions

# 99. Misc Aliases
# ----------------

alias starwars="telnet towel.blinkenlights.nl" # Watch ASCII Starwars via telnet

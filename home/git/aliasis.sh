# Git shortcuts




alias g='git'
alias gb='git branch'
alias gba='git branch -a'
alias gbc='gc -b' # Dyslexia
alias gbup='gb --set-upstream-to=origin/$(gbs) $(gbs)'
alias gcb='gc -b'

alias gcl='git clone'
alias gco='gc'
alias gd='git diff'
alias gdc='gd --cached'

alias gl='git log'
alias gm='git commit -m'
alias gma='git commit -am'
alias gp='git push'
alias gpa='gp --all'
alias gpup='gp --set-upstream origin $(gbs)'
alias gr='git remote'
alias grr='git remote rm'
alias grv='gr -v'
alias gs='git status'
alias gst='gs'
alias gu='git pull'











# OSX-specific Git shortcuts
if is_osx; then
  alias gdk='git ksdiff'
  alias gdkc='gdk --cached'
  function gt() {
    local path repo
    {
      pushd "${1:-$PWD}"
      path="$PWD"
      repo="$(git rev-parse --show-toplevel)"
      popd
    } >/dev/null 2>&1
    if [[ -e "$repo" ]]; then
      echo "Opening git repo $repo."
      gittower "$repo"
    else
      echo "Error: $path is not a git repo."
    fi
  }
fi
source ~/.bash_profile

ggpushmr() {
      git push --set-upstream origin -o merge_request.create -o merge_request.title=$1 -o merge_request.label="frontend"
}

fzf-down () {
        fzf --height 50% "$@" --border
}

is_in_git_repo () {
        git rev-parse HEAD > /dev/null 2>&1
}

ghf () {
        is_in_git_repo || return
        git log --date=short --format="%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)" --graph --color=always | fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' --header 'Press CTRL-S to toggle sort' --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} -o "[a-f0-9]\{7,\}"
}

gmr () {
        open -a "Google Chrome" https://gitlab.mtb.co.th/gettech/saletool/-/merge_requests/$1
}

gcof () {
        is_in_git_repo || return
        git checkout $(pon)
}

pon () {
        is_in_git_repo || return
        git branch -a --color=always | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox} -v '/HEAD\s' | sort | fzf-down --ansi --multi --tac --preview-window right:70% --preview 'git log --oneline --graph --date=short --pretty="format:%C(auto)%cd %h%d %s" $(sed s/^..// <<< {} | cut -d" " -f1) | head -'$LINES | sed 's/^..//' | cut -d' ' -f1 | sed 's#^remotes/##'
}

# Watch PWD to check for bitkeeper dir entry on dir change

function _bk_or_git_prompt.is_pristine -a revno
    not string match -r '.+-dirty' $revno
end

if which bk >/dev/null 2>&1
    __vcs_crumb.define bk 'bk root' 'bk describe' '_bk_or_git_prompt.is_pristine "%s"'
end

if which git >/dev/null 2>&1
    __vcs_crumb.define git 'git rev-parse --git-dir' 'git describe --always --tag --dirty' '_bk_or_git_prompt.is_pristine "%s"'
end

if which svn >/dev/null 2>&1
    __vcs_crumb.define svn 'svn info' 'svn info --show-item revision' true
end

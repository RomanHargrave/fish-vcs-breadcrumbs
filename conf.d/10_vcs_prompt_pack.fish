# Watch PWD to check for bitkeeper dir entry on dir change

function _bk_or_git_prompt.is_pristine
   string match -r '.+-dirty' $_vcs_revision
end

if which bk >/dev/null ^&1 
    __vcs_crumb.define bk 'bk root' 'bk describe' _bk_or_git_prompt.is_pristine
end

if which git >/dev/null ^&1
    __vcs_crumb.define git 'git rev-parse --git-dir' 'git describe --always --tag --dirty' _bk_or_git_prompt.is_pristine
end

if which svn >/dev/null ^&1
    __vcs_crumb.define svn 'svn info' 'svn info --show-item revision' true
end

if which bzr >/dev/null ^&1
    __vcs_crumb.define bzr 'bzr revno' 'bzr revno' true 
end

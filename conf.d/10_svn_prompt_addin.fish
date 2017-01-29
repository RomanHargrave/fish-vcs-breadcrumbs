# Watch PWD to check for svn dir entry

if isatty
    function _svn_prompt.pwd_watcher -v PWD
        if which svn 2>&1 >/dev/null
            if svn info 2>&1 >/dev/null
                fish_prompt_breadcrumb add _svn_prompt.svn_status_seg
            else
                fish_prompt_breadcrumb rm _svn_prompt.svn_status_seg
            end
        end
    end
end

function _svn_prompt.svn_status_seg
    set description (svn info --show-item revision)
    set_color white
    printf 'svn:%s' $description
end

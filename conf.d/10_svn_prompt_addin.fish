# Watch PWD to check for svn dir entry

if isatty
    function _svn_prompt.pwd_watcher -v PWD
        if which svn >/dev/null ^&1
            if svn info >/dev/null ^&1
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

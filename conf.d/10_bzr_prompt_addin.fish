# Watch PWD to check for bzr branch 

if isatty
    function _bzr_prompt.pwd_watcher -v PWD
        if which bzr >/dev/null ^&1
            if bzr revno >/dev/null ^&1
                fish_prompt_breadcrumb add _bzr_prompt.bzr_status_seg
            else
                fish_prompt_breadcrumb rm _bzr_prompt.bzr_status_seg
            end
        end
    end

    function _bzr_prompt.bzr_status_seg
        set_color green
        printf 'bzr:%s' (bzr revno)
        set_color normal
    end
end

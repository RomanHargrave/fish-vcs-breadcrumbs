# Watch PWD to check for bitkeeper dir entry on dir change

if isatty
    function _bk_prompt.pwd_watcher -v PWD
        if which bk 2>&1 >/dev/null
            if bk root 2>&1 >/dev/null
                fish_prompt_breadcrumb add _bk_prompt.bk_status_seg
            else
                fish_prompt_breadcrumb rm _bk_prompt.bk_status_seg
            end
        end
    end

    function _bk_prompt.bk_status_seg
        set description (bk describe)
        if string match -r '.+-dirty' $description >/dev/null
            set_color red
        else
            set_color green
        end
        printf 'bk:%s' $description
    end
end

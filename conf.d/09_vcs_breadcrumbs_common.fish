# Common framework for vcs crumbs

set ___vcs_crumb_define_FN __vcs_crumb.define

if isatty 

    set __vcs_crumbs

    set _vcs_crumb_color_clean green
    set _vcs_crumb_color_dirty red

    function $___vcs_crumb_define_FN -a vcs_name -a _c_present -a _c_revision -a _c_pristine
        set _crumb_impl_name ___vcs_crumb_impl_$vcs_name

        function $_crumb_impl_name -V vcs_name -V _c_revision -V _c_pristine --description "Breadcrumb generated for $vcs_name"
            # revision exported for dirty check command
            set -x _vcs_revision (eval $_c_revision)
            if eval $_c_pristine >/dev/null ^&1
                set_color $_vcs_crumb_color_clean
            else
                set_color $_vcs_crumb_color_dirty
            end

            printf '%s:%s' $vcs_name $_vcs_revision
        end

        # Array expansion will erase the \30 if the crumb list is empty
        set _tmp_crumbs_head $__vcs_crumbs\30 
        set __vcs_crumbs "$_tmp_crumbs_head$vcs_check_in_tree"\31"$_crumb_impl_name"
    end

    function __vcs_crumb._pwd_watcher -v PWD
        for vcs_def in (string split \30 $__vcs_crumbs)
            set vcs_raw_def (string split \31 $vcs_def)
            set vcs_validate    $vcs_raw_def[1]
            set vcs_crumb       $vcs_raw_def[2]

            if eval $vcs_validate >/dev/null ^&1
                fish_prompt_breadcrumb add $vcs_crumb
            else
                fish_prompt_breadcrumb rm $vcs_crumb
            end
        end
    end

else

    function $___vcs_crumb_define_FN
    end

end

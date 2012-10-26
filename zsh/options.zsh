#!/bin/zsh -f

# Set some default options
# http://zsh.sourceforge.net/Doc/Release/zsh_15.html#SEC81
setopt always_to_end append_history auto_continue auto_list auto_menu \
auto_param_slash auto_remove_slash auto_resume bg_nice no_check_jobs no_hup \
auto_pushd complete_in_word csh_junkie_history no_extended_glob brace_ccl \
glob_complete hist_find_no_dups \
hist_ignore_space hist_no_functions hist_save_no_dups list_ambiguous \
long_list_jobs menu_complete no_rm_star_silent no_rm_star_wait zle \
inc_append_history prompt_subst no_list_beep local_options \
local_traps hist_verify extended_history hist_reduce_blanks chase_links \
chase_dots hash_cmds hash_dirs numeric_glob_sort vi notify \
monitor kshglob noflowcontrol no_clobber nonomatch

unsetopt beep equals mail_warning multibyte

typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

setopt prompt_subst
autoload -Uz colors
autoload -Uz vcs_info
colors

autoload +X vcs_info 2>/dev/null || vcs_info() {}


# vim: set et sw=4 sts=4 ts=4 ft=zsh :

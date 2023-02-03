# This is an alternative approach. Single line minimalist in git repo.
override_git_prompt_colors() {
  GIT_PROMPT_THEME_NAME="Single_line_Minimalist"

  function prompt_callback {
    local PS1="$(gp_truncate_pwd)"
    gp_set_window_title "$PS1"
  }
  GIT_PROMPT_PREFIX="${White}(${ResetColor}"
  GIT_PROMPT_SUFFIX="${White})${ResetColor}"
  GIT_PROMPT_SEPARATOR="|"

  GIT_PROMPT_BRANCH="${Green}"
  GIT_PROMPT_MASTER_BRANCH="${BoldRed}"
  GIT_PROMPT_UNTRACKED="${Cyan}…${ResetColor}"
  GIT_PROMPT_CHANGED="${Yellow}✚ "
  GIT_PROMPT_STAGED="${Magenta}● "

  GIT_PROMPT_SYMBOLS_AHEAD="↑ "             # The symbol for "n versions ahead of origin"
  GIT_PROMPT_SYMBOLS_BEHIND="↓ "            # The symbol for "n versions behind of origin"

  GIT_PROMPT_COMMAND_OK="${Green} ✔ "    # indicator if the last command returned with an exit code of 0
  GIT_PROMPT_COMMAND_FAIL="${BoldRed} ✘-_LAST_COMMAND_STATE_"    # indicator if the last command returned with an exit code of other than 0

  GIT_PROMPT_START_USER="${White}\w${ResetColor}"
  GIT_PROMPT_START_ROOT="${White}\w${ResetColor}"

  GIT_PROMPT_END_USER=" ${Blue}❯ ${White}"
  GIT_PROMPT_END_ROOT=" # ${Blue}"

}
reload_git_prompt_colors "Single_line_Minimalist"

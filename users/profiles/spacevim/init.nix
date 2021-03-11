#=============================================================================
# basic.toml --- basic configuration example for SpaceVim
# Copyright (c) 2016-2020 Wang Shidong & Contributors
# Author: Wang Shidong < wsdjeg at 163.com >
# URL: https://spacevim.org
# License: GPLv3
#=============================================================================
{
  # All SpaceVim option below [option] section
  options = {
    # set spacevim theme. by default colorscheme layer is not loaded,
    # if you want to use more colorscheme, please load the colorscheme
    # layer
    colorscheme = "gruvbox";
    colorscheme_bg = "dark";
    # Disable guicolors in basic mode, many terminal do not support 24bit
    # true colors
    enable_guicolors = false;
    # Disable statusline separator, if you want to use other value, please
    # install nerd fonts
    statusline_separator = "nil";
    statusline_iseparator = "bar";
    buffer_index_type = 4;
    windows_index_type = 3;
    enable_tabline_filetype_icon = false;
    enable_statusline_mode = false;
    statusline_unicode_symbols = false;
    # Enable vim compatible mode, avoid changing origin vim key bindings
    vimcompatible = false;
    escape_key_binding = ""; # no jk shortcut
  };

  # Enable autocomplete layer
  layers = [
    {
      name = "autocomplete";
      auto_completion_return_key_behavior = "complete";
      auto_completion_tab_key_behavior = "cycle";
    }
    {
      name = "shell";
      default_position = "top";
      default_height = 30;
    }
    {
      name = "git";
    }
    {
      name = "lsp";
    }

    {
      name = "lang#scala";
    }
    {
      name = "lang#python";
    }
  ];
}
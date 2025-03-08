# https://github.com/tinted-theming/base16-fzf
# https://github.com/junegunn/fzf/wiki/Color-schemes

_gen_fzf_light_theme() {
  export FZF_DEFAULT_OPTS="
  --color=bg:#2E3440,fg:#D8DEE9,hl:#81A1C1
  --color=fg+:#ECEFF4,bg+:#3B4252,hl+:#88C0D0
  --color=info:#5E81AC,prompt:#81A1C1,pointer:#BF616A
  --color=marker:#EBCB8B,spinner:#B48EAD,header:#A3BE8C"
}

_gen_fzf_dark_theme() {
  export FZF_DEFAULT_OPTS="
  --color=bg:#2E3440,fg:#D8DEE9,hl:#81A1C1
  --color=fg+:#ECEFF4,bg+:#3B4252,hl+:#88C0D0
  --color=info:#5E81AC,prompt:#81A1C1,pointer:#BF616A
  --color=marker:#EBCB8B,spinner:#B48EAD,header:#A3BE8C"
}


export DARK_MODE=$(cat ~/.dark_mode)


if [ $DARK_MODE = "true" ]; then
  # export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  # --color=fg:#bdae93,bg:#32302f,hl:#83a598
  # --color=fg+:#ebdbb2,bg+:#3c3836,hl+:#83a598
  # --color=info:#fabd2f,prompt:#fabd2f,pointer:#8ec07c
  # --color=marker:#8ec07c,spinner:#8ec07c,header:#83a598'
  _gen_fzf_dark_theme
else
  _gen_fzf_light_theme
  # export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  # --color=fg:#8f740a,bg:#fdf9e7,hl:#fbf1c7
  # --color=fg+:#8f740a,bg+:#fbf1c7,hl+:#fbf1c7
  # --color=info:#8f740a,prompt:#8f740a,pointer:#8ec07c
  # --color=marker:#8f740a,spinner:#8f740a,header:#83a598,border:#f7e7a1'
fi

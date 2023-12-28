# https://github.com/tinted-theming/base16-fzf
# https://github.com/junegunn/fzf/wiki/Color-schemes

_gen_fzf_light_theme() {
  local color00='#ffffff'
  local color01='#e0e0e0'
  local color02='#d6d6d6'
  local color03='#8e908c'
  local color04='#969896'
  local color05='#4d4d4c'
  local color06='#282a2e'
  local color07='#1d1f21'
  local color08='#c82829'
  local color09='#f5871f'
  local color0A='#eab700'
  local color0B='#718c00'
  local color0C='#3e999f'
  local color0D='#4271ae'
  local color0E='#8959a8'
  local color0F='#a3685a'

  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS" \
    --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D \
    --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C \
    --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"

}

_gen_fzf_dark_theme() {
  local color00='#202020'
  local color01='#2a2827'
  local color02='#504945'
  local color03='#5a524c'
  local color04='#bdae93'
  local color05='#ddc7a1'
  local color06='#ebdbb2'
  local color07='#fbf1c7'
  local color08='#ea6962'
  local color09='#e78a4e'
  local color0A='#d8a657'
  local color0B='#a9b665'
  local color0C='#89b482'
  local color0D='#7daea3'
  local color0E='#d3869b'
  local color0F='#bd6f3e'

  export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS" \
   --color=bg+:$color01,bg:$color00,spinner:$color0C,hl:$color0D \
   --color=fg:$color04,header:$color0D,info:$color0A,pointer:$color0C \
   --color=marker:$color0C,fg+:$color06,prompt:$color0A,hl+:$color0D"
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

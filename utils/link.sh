# Define a function which rename a `target` file to `target.backup` if the file
# exists and if it's a 'real' file, ie not a symlink

backup() {
  target=$1
  
  backup="$HOME/backup/$(date '+%Y-%m-%d')"
  # if [ ! -e "$target" ]; then
  #     return 0 
  # fi
echo "aaaaaa"
  [ ! -d "$backup" ] && mkdir -p $backup
  mv -f "$target" "$backup/$(basename ${target}).old"
  
 # greenprint "-> Moved your old $target config file to $backup/$target.old"
  
}

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]; then

        skip=true;

      else

        yellowprint "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          [o])
            overwrite=true;;
          [O])
            overwrite_all=true;;
          [b])
            backup=true;;
          [B])
            backup_all=true;;
          [s])
            skip=true;;
          [S])
            skip_all=true;;
          [*])
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]; then
      rm -rf "$dst"
      greenprint "removed $dst"
    fi

    if [ "$backup" == "true" ]; then
      backup "$dst" 
    fi

    if [ "$skip" == "true" ]; then
      greenprint "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -sf $1 $2
    greenprint "linked $1 to $2"
  fi
}

install_configs () {
  blueprint 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "$DOTFILES_ROOT" -name '*.symlink')
  do
    dst="$HOME/.config/$(basename "${src%.*}")"

    echo "$src  $dst"
    link_file "$src" "$dst"
  done

  for src in $(find -H "$DOTFILES_ROOT/home"  -name '*.symlink' )
  do
    dst="$HOME/$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}

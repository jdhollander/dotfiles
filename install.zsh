#!/usr/bin/env zsh

function createlink {
  # If already a symlink, skip
  if [[ -L $HOME/$1 ]] then
    echo "SKIPPING: $HOME/$1 (symlink exists)"
    return;
  fi
  # If path doesn't exist, easy case
  if [[ ! -e $HOME/$1 ]] then
    if ln -s ${0:A:h}/src/$1 $HOME/$1; then
      echo "${0:A:h}/src/$1 -> $HOME/$1";
    else
      echo "Failed to create symlink for $HOME/$1"
    fi
    return
  fi
  # If existing path is a directory, ask to overwrite
  if [[ -d $HOME/$1 ]] then
    print -n "Directory exists $HOME/$1. Overwrite? (y/n) "
    read -q answer
    if [[ $answer == [yY] ]]; then
      echo "\nOverwriting"
      rm -r $HOME/$1
      ln -sf ${0:A:h}/src/$1 $HOME/$1
      echo "${0:A:h}/src/$1 -> $HOME/$1";
    else
      echo "\nSkipping"
    fi
  else
    # Otherwise, ask to overwrite file
    print -n "File exists $HOME/$1. Overwrite? (y/n) "
    read -q answer
    if [[ $answer == [yY] ]]; then
      echo "\nOverwriting"
      ln -sf ${0:A:h}/src/$1 $HOME/$1
      echo "${0:A:h}/src/$1 -> $HOME/$1";
    else
      echo "\nSkipping"
    fi
  fi
}

# Install symlink for files at a depth of 1
for file in $(find ./src -type f -d 1); do
  createlink ${file#./src/};
done

# Install a symlink for directories at a depth of 1
for dir in $(find ./src -type d -d 1); do
  if [[ $dir =~ '.*\.config$' ]] continue;
  createlink ${dir#./src/};
done;

# Install a symlink for files and directories of .config
for dir in $(find ./src/.config -d 1); do
  createlink ${dir#./src/};
done;

# Install TPM for TMUX
if [[ ! -e ~/.tmux/plugins/tpm ]] then
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi


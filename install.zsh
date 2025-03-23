#!/usr/bin/env zsh

function createlink {
  if [[ ! -e $HOME/$1 ]] then
    if ln -s ./src/$1 $HOME/$1; then
    echo "$1 -> $HOME/$1";
    else
      echo "Failed to create symlink for $HOME/$1"
    fi
  else
    if [[ -d $HOME/$1 ]] then
      print -n "Directory exists $HOME/$1. Overwrite? (y/n) "
      read -q answer
      if [[ $answer == [yY] ]]; then
        echo "\nOverwriting"
        ln -sf ./src/$1 $HOME/$1
      else
        echo "\nSkipping"
      fi
    else
      print -n "File exists $HOME/$1. Overwrite? (y/n) "
      read -q answer
      if [[ $answer == [yY] ]]; then
        echo "\nOverwriting"
        ln -sf ./src/$1 $HOME/$1
      else
        echo "\nSkipping"
      fi
    fi
  fi
}

# Install symlink for files at a depth of 1
for file in $(find ./src -type f -d 1); do
  createlink ${file#./src/};
  # ln -s $file $HOME/${file#./src/};
  # echo "${file#./src/} -> $HOME/${file#./src/}";
done

# Install a symlink for directories at a depth of 1
for dir in $(find ./src -type d -d 1); do
  if [[ $dir =~ '.*\.config$' ]] continue;
  createlink ${dir#./src/};
  # echo "${dir#./src/} -> $HOME/${dir#./src/}";
  # ln -s $dir $HOME/${dir#./src/};
done;

# Install a symlink for files and directories of .config
for dir in $(find ./src/.config -d 1); do
  createlink ${dir#./src/};
  # echo "${dir#./src/} -> $HOME/${dir#./src/}";
  # ln -s $dir $HOME/${dir#./src/};
done;

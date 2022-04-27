WORK_DIR=$(pwd)

function check_target_dir() {
  if [ ! -d "$1" ]; then
    echo "Target directory does not exist."
    exit 1
  fi
  cd "$WORK_DIR/$1/lib"
  echo "Checking target directory: ${PWD}"
  flutter analyze
  cd "$WORK_DIR"
}

check_target_dir .
check_target_dir tools
check_target_dir example

#flutter analyze
#flutter analyze tools/lib
#flutter analyze example/lib

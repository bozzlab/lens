case $1 in
  mac)
    find ~/Library/Logs/Lens -type f -name *.log -delete
  ;;
  linux)
    find ~/.config/Logs/Lens -type f -name *.log -delete
  ;;
  win)
    find %APPDATA%/Logs/Lens -type f -name *.log -delete
  ;;
esac

make build-extension-types build-extensions
yarn build:$1
DEBUG=true yarn integration

if [ $? -ne 0 ]; then
  case $1 in
    mac)
      find ~/Library/Logs/Lens -type f -name *.log -exec cat >&2 {} \;
    ;;
    linux)
      find ~/.config/Logs/Lens -type f -name *.log -exec cat >&2 {} \;
    ;;
    win)
      find %APPDATA%/Logs/Lens -type f -name *.log -exec cat >&2 {} \;
    ;;
  esac

  exit 1
fi

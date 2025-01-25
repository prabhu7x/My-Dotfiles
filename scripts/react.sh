#!/bin/bash

options=("React-1" "React-2" "React-3" "Quit")

select choice in "${options[@]}"
do
  case $choice in
    "React-1")
        cd $HOME/Documents/React_Projects/my-react-app-1 && npm start & i3-msg move container to workspace 6
      ;;
    "React-2")
        cd $HOME/Documents/React_Projects/my-react-app-2 && npm start & i3-msg move container to workspace 6
      ;;
    "React-3")
        cd $HOME/Documents/React_Projects/my-react-app-3 && npm start & i3-msg move container to workspace 6
      ;;
    "Quit")
      echo "Exiting program..."
      break
      ;;
    *)
      echo "Invalid option"
      ;;
  esac
done


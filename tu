#!/usr/bin/osascript

on run argv
  set tunnel to item 1 of argv
  tell application "/Applications/Tunnelblick.app"
    connect tunnel
  end tell
end run

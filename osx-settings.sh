#!/usr/bin/env bash

# For finding
# defaults find com.apple.ActivityMonitor

# Close any open System Preferences panes, to prevent overriding
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
# sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Fast Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# Trackpad
defaults write NSGlobalDomain com.apple.trackpad.scaling 2 # speed
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag 1 # three finger drag
defaults write com.apple.AppleMultitouchTrackpad Clicking 1 # light click
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold 0 # tap to click
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold 0 # tap to click
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture 2 # three finger swipe
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture 0
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture 0

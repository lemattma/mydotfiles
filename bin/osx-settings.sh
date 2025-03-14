#!/usr/bin/env bash

# For finding
# defaults find com.apple.ActivityMonitor

# Close any open System Preferences panes, to prevent overriding
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
# sudo -v

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
# while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


###############################################################################
# Keyboard & Trackpad
###############################################################################

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3 # √

# Fast Keyboard
defaults write NSGlobalDomain KeyRepeat -int 2
defaults write NSGlobalDomain InitialKeyRepeat -int 15

# # Trackpad
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -int 1 # three finger drag
defaults write com.apple.AppleMultitouchTrackpad Clicking -int 1 # light click

# Silent clicking
defaults write com.apple.AppleMultitouchTrackpad ActuationStrength -int 0

# Haptic feedback
# 0: Light
# 1: Medium
# 2: Firm
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0

# Tracking Speed
# 0: Slow
# 3: Fast
defaults write NSGlobalDomain com.apple.trackpad.scaling -float 2.5

###############################################################################
# Finder                                                                      #
###############################################################################

# Make the Sidebar a little wider, so our favorites fit.
defaults write com.apple.finder SidebarWidth -int 175
defaults write com.apple.finder FK_SidebarWidth -int 175

# Finder: When opening a new window, start in the home directory.
defaults write com.apple.finder NewWindowTarget -string 'PfHm'

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"√

# Show the ~/Library folder
chflags nohidden ~/Library

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Set sidebar icon size to medium.
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Remove the Tags section.
defaults write com.apple.finder ShowRecentTags -bool false

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true


# TODO:
# # NOTE: Adding apps to the Dock should happen in the scripts where said apps are installed.

# ## Disable animations when opening an application from the Dock.
# defaults write com.apple.dock launchanim -bool FALSE

# ## Automatically hide and show the Dock.
# defaults write com.apple.dock autohide -bool TRUE

# ## Eliminate any delay before showing the Dock.
# defaults write com.apple.Dock autohide-delay -float 0

# # We use dockutil to add and remove icons in the Mac OS X dock.
# ## Install dockutil
# # NOTE: Homebrew doesn't have dockutil 3.0 yet, as of 2022-05-28.
# #brew install --quiet dockutil
# # We're installing manually, until Homebrew gets 3.0.
# wget https://github.com/kcrawford/dockutil/releases/download/3.0.2/dockutil-3.0.2.pkg
# sudo installer -pkg dockutil-3.0.2.pkg -target / > /dev/null
# rm dockutil-3.0.2.pkg

# ## Remove rarely-used Dock items.
# for dock_item in Siri Launchpad Contacts Notes Reminders Maps Messages FaceTime iBooks Podcasts TV News ; do
#   dockutil --remove "$dock_item" &> /dev/null
# done

# ## Add Activity Monitor to the Dock.
# dockutil --find "Activity Monitor" &> /dev/null \
# || dockutil --add "/System/Applications/Utilities/Activity Monitor.app" --position end

# ## Show CPU graph in Activity Monitor icon in Dock.
# defaults write com.apple.ActivityMonitor IconType -int 6

# ## Restart the Dock.
# killall Dock

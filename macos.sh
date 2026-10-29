#!/usr/bin/env bash
# macOS System Settings & App Defaults
# Run with: ~/.dotfiles/macos.sh

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Close System Settings so it doesn't overwrite changes we make below
osascript -e 'tell application "System Settings" to quit' 2>/dev/null || true

echo "Applying macOS system settings..."

# ==============================================================================
# Appearance & Window Management
# ==============================================================================

# Automatically switch between Light and Dark mode
defaults write NSGlobalDomain AppleInterfaceStyleSwitchesAutomatically -bool true

# Disable double-click on window title bar to minimize
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false

# Do NOT switch to a Space with open windows when activating an application
# (Essential for tiling window managers like Glide / Amethyst / Phoenix)
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool false

# Keep windows when quitting/reopening apps
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool true

# Stage Manager & Desktop Click behavior
defaults write com.apple.WindowManager GloballyEnabled -bool false
defaults write com.apple.WindowManager HideDesktop -bool true
defaults write com.apple.WindowManager StageManagerHideWidgets -bool false
defaults write com.apple.WindowManager StandardHideWidgets -bool false
defaults write com.apple.WindowManager AppWindowGroupingBehavior -int 1

# ==============================================================================
# Keyboard & Text Input
# ==============================================================================

# Disable automatic capitalization and double-space period substitution
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false
defaults write NSGlobalDomain NSAutomaticPeriodSubstitutionEnabled -bool false

# Remap Caps Lock (0x700000039 / 30064771129) -> Escape (0x700000029 / 30064771113)
# 1. Apply immediately for the current session via hidutil
/usr/bin/hidutil property --set '{"UserKeyMapping":[{"HIDKeyboardModifierMappingSrc":0x700000039,"HIDKeyboardModifierMappingDst":0x700000029}]}' >/dev/null 2>&1 || true

# 2. Persist in ByHost defaults for the generic keyboard (0-0-0) and any connected keyboards
remap_capslock_to_escape() {
  local domain_key="com.apple.keyboard.modifiermapping.$1"
  defaults -currentHost write -g "$domain_key" -array \
    '<dict><key>HIDKeyboardModifierMappingDst</key><integer>30064771113</integer><key>HIDKeyboardModifierMappingSrc</key><integer>30064771129</integer></dict>'
}

remap_capslock_to_escape "0-0-0"
# Known Apple internal & external keyboard VendorID-ProductID-0 pairs
remap_capslock_to_escape "1452-835-0"
remap_capslock_to_escape "3141-30354-0"

# Also detect any currently connected HID keyboards dynamically
while IFS= read -r vid_pid; do
  [[ -n "$vid_pid" ]] && remap_capslock_to_escape "${vid_pid}-0"
done < <(
  ioreg -rc AppleHIDKeyboardEventDriver -r -c IOHIDInterface 2>/dev/null | awk '
    /"VendorID" = / { vid=$3 }
    /"ProductID" = / { pid=$3; if (vid && pid) { print vid "-" pid; vid=""; pid="" } }
  ' | sort -u
)

# ==============================================================================
# Trackpad (Built-in & Bluetooth)
# ==============================================================================

# Enable Three-Finger Drag (and move Mission Control / App Expose / Space swipe to 4 fingers)
for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
  defaults write "$domain" Clicking -bool false
  defaults write "$domain" TrackpadRightClick -bool true
  defaults write "$domain" TrackpadThreeFingerDrag -bool true
  defaults write "$domain" TrackpadThreeFingerHorizSwipeGesture -int 0
  defaults write "$domain" TrackpadThreeFingerVertSwipeGesture -int 0
  defaults write "$domain" TrackpadThreeFingerTapGesture -int 0
  defaults write "$domain" TrackpadFourFingerHorizSwipeGesture -int 2
  defaults write "$domain" TrackpadFourFingerVertSwipeGesture -int 2
  defaults write "$domain" TrackpadFourFingerPinchGesture -int 2
  defaults write "$domain" TrackpadFiveFingerPinchGesture -int 2
done

# Light click threshold on Force Touch trackpad
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0
defaults write NSGlobalDomain com.apple.trackpad.forceClick -bool true

# Mirror trackpad gestures in CurrentHost global domain
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.enableSecondaryClick -bool true
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerDragGesture -int 1
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerHorizSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerVertSwipeGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.threeFingerTapGesture -int 0
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerHorizSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerVertSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fourFingerPinchSwipeGesture -int 2
defaults -currentHost write NSGlobalDomain com.apple.trackpad.fiveFingerPinchSwipeGesture -int 2

# ==============================================================================
# Dock & Spaces
# ==============================================================================

# Auto-hide the Dock
defaults write com.apple.dock autohide -bool true

# Dock icon size
defaults write com.apple.dock tilesize -int 59

# Scale effect when minimizing windows, and minimize into application icon
defaults write com.apple.dock mineffect -string "scale"
defaults write com.apple.dock minimize-to-application -bool true

# Don't animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Don't automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Hot corners: Bottom-right -> Quick Note (14)
defaults write com.apple.dock wvous-br-corner -int 14
defaults write com.apple.dock wvous-br-modifier -int 0

# ==============================================================================
# Finder
# ==============================================================================

# Use List view in all Finder windows by default ("Nlsv")
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
defaults write com.apple.finder FXArrangeGroupViewBy -string "Name"

# Desktop icons
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Enable spring-loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true
defaults write NSGlobalDomain com.apple.springing.delay -float 0.5

# Expand file list mode in Open dialogs
defaults write NSGlobalDomain NavPanelFileListModeForOpenMode -int 2

# ==============================================================================
# App Preferences (iTerm2 & KeyCastr)
# ==============================================================================

# Point iTerm2 directly to ~/.dotfiles/dotfiles/.iterm2 and auto-save changes
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${DOTFILES_DIR}/dotfiles/.iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
# 2 = Save changes to custom folder automatically
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 2
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile -bool true

# KeyCastr preferences
defaults write io.github.keycastr "default.allKeys" -bool false
defaults write io.github.keycastr "default.allModifiedKeys" -bool true
defaults write io.github.keycastr "default.commandKeysOnly" -bool false
defaults write io.github.keycastr "selectedVisualizer" -string "Default"

# ==============================================================================
# Restart affected services
# ==============================================================================

for app in "Dock" "Finder" "SystemUIServer"; do
  killall "${app}" >/dev/null 2>&1 || true
done

echo "Done! Note: Some trackpad/keyboard changes may require logging out or restarting."

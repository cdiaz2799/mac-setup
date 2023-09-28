# XCode
echo "Installing xcode..."
xcode-select --install

# Rosetta
echo "Installing Rosetta..."
softwareupdate --install-rosetta --agree-to-license

# Updates
echo "Installing macOS Updates in the background"
sudo softwareupdate --install -all --background

# Check for Homebrew
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Updating Homebrew..."
brew update

echo "Installing Homebrew packages..."
brew bundle
brew cleanup

echo "Setting zsh as default shell..."
chsh -s /opt/homebrew/bin/zsh

echo "Installing Oh My ZSH..."
curl -L http://install.ohmyz.sh | sh

echo "Setting up Zsh plugins..."
cd ~/.oh-my-zsh/custom/plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git
git clone git://github.com/zsh-users/zsh-autosuggestions

echo "Setting finder preferences..."
chflags nohidden ~/Library
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.finder ShowPathbar -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.finder FXPreferredViewStyle Clmv
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true



echo "Disabling OSX Gate Keeper..."
sudo spctl --master-disable
sudo defaults write /var/db/SystemPolicy-prefs.plist enabled -string no
defaults write com.apple.LaunchServices LSQuarantine -bool false

echo "Setting misc. OS X preferences..."
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo "Making Safari less annoying..."
defaults write com.apple.Safari ShowFavoritesBar -bool false
defaults write com.apple.Safari ShowSidebarInTopSites -bool false
defaults write com.apple.Safari DebugSnapshotsUpdatePolicy -int 2
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
defaults write com.apple.Safari ProxiesInBookmarksBar "()"

echo "Disabling Siri..."
defaults write com.apple.assistant.support "Assistant Enabled" -bool false
defaults write com.apple.Siri StatusMenuVisible -bool false

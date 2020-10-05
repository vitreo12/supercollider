#!/bin/sh

export HOMEBREW_NO_ANALYTICS=1

brew install libsndfile || brew install libsndfile || exit 1
brew install portaudio || exit 2
brew install ccache || exit 3
if $IS_LEGACY_BUILD; then
    brew install supercollider/formulae/qt@5.9.3 --force || exit 4
else
    brew upgrade qt5 || exit 4
fi
brew install fftw # temp allow

# according to https://docs.travis-ci.com/user/caching#ccache-cache
export PATH="/usr/local/opt/ccache/libexec:$PATH"

# To get less noise in xcode output
gem install xcpretty

#!/bin/sh

export HOMEBREW_NO_ANALYTICS=1

if $UPDATE_HOMEBREW; then
    #run update first so that possible update errors won't hold up package installation
    brew update
else
    export HOMEBREW_NO_AUTO_UPDATE=1
fi

brew install libsndfile || exit 1
brew install portaudio || exit 2
brew install ccache || exit 3
if  [[ ! -z "$QT_FORMULA" ]]; then
    brew install $QT_FORMULA --force || exit 4
elif $UPDATE_HOMEBREW; then
    brew upgrade qt5 || exit 4
fi
brew install fftw # do not abort in this step - fftw dependencies' install may fail, but this is not an issue for us

if $USE_SYSLIBS; then
    # boost is already installed
    brew install yaml-cpp || exit 7
fi

# according to https://docs.travis-ci.com/user/caching#ccache-cache
export PATH="/usr/local/opt/ccache/libexec:$PATH"

# To get less noise in xcode output
gem install xcpretty

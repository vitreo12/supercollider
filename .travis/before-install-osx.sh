#!/bin/sh

export HOMEBREW_NO_ANALYTICS=1

if ! $UPDATE_HOMEBREW; then
   export HOMEBREW_NO_AUTO_UPDATE=1
fi

echo "RUNNING brew install libsndfile"
brew install libsndfile || exit 1
echo "RUNNING brew install portaudio"
brew install portaudio || exit 2
echo "RUNNING brew install ccache"
brew install ccache || exit 3
if  [[ ! -z "$QT_FORMULA" ]]; then
    echo "RUNNING brew install $QT_FORMULA --force"
    brew install $QT_FORMULA --force || exit 4
elif $UPDATE_HOMEBREW; then
    echo "RUNNING brew upgrade qt5"
    brew upgrade qt5 || exit 4
fi
echo "RUNNING brew install fftw"
brew install fftw # do not abort in this step - fftw dependencies' install may fail, but this is not an issue for us

if $USE_SYSLIBS; then
    # boost is already installed
    echo "RUNNING brew install yaml-cpp"
    brew install yaml-cpp || exit 7
fi

# according to https://docs.travis-ci.com/user/caching#ccache-cache
export PATH="/usr/local/opt/ccache/libexec:$PATH"

# To get less noise in xcode output
gem install xcpretty

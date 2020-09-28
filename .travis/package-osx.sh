#!/bin/sh

mkdir -p $HOME/artifacts

cd $TRAVIS_BUILD_DIR/BUILD/Install
zip -q -r --symlinks $HOME/artifacts/$ARTIFACT_AWS_NAME.zip SuperCollider
cp $HOME/artifacts/$ARTIFACT_AWS_NAME.zip $HOME/$ARTIFACT_GH_NAME.zip

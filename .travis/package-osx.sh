#!/bin/sh

mkdir -p $HOME/artifacts

cd $TRAVIS_BUILD_DIR/BUILD/Install
ls -a
zip -q -r --symlinks $HOME/artifacts/$S3_ARTIFACT_NAME.zip SuperCollider
ls -a $HOME/artifacts
cp $HOME/artifacts/$S3_ARTIFACT_NAME.zip $HOME/$GITHUB_ARTIFACT_NAME.zip
ls -a $HOME

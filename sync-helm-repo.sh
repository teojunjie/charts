#!/bin/bash
set -eox

# run in root dir of charts repo 
# make a scratch local helm repo 
TMPDIR=scratch
mkdir $TMPDIR

# sync remote server files with local 
gsutil rsync -d gs://test-helm-bucket01 $TMPDIR

# generate index.yaml in $TMPDIR
helm repo index $TMPDIR --url https://storage.cloud.google.com/test-helm-bucket01/

# sync local files with remote server
gsutil rsync -d $TMPDIR gs://test-helm-bucket01

# cleanup by removing scratch dir 
rm -rf $TMPDIR
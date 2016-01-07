#!/bin/sh
# -----------------------------------------------------------------------------
# Description:  Update svn:ignore properties based on .svnignore files
# First Author:	2008-06-26 <mhucka@caltech.edu>
# Organization: California Institute of Technology
# -----------------------------------------------------------------------------
#
# This lets you keep a .svnignore file in a directory, and use it to set the
# svn:ignore property on the directory itself.  This is useful because SVN
# doesn't actually have the concept of a .svnignore file, and it's 1000x
# more convenient than maintaining the ignore property on the directory using
# svn commands.
#
# Syntax of the .svnignore file: like what "svn propset svn:ignore" accepts,
# and in addition, lines in the .svnignore file that begin with a pound sign
# (#) are ignored so that one can put comments in the file.
#
# WARNING: this will do a commit on the directory, which means that any other
# changes in the directory will be committed too.  This is only intended to be
# used when the .svnignore file is the only thing being changed.

find $1 -depth -name .svnignore | while read file ; do
  dir="`dirname $file`"
  egrep -v '^[ 	]*#' $file | svn propset svn:ignore -F - $dir
  svn update $dir
  svn commit --depth=immediates -m"Updated list of ignored files." $dir $dir/.svnignore
done

echo "Done."

#!/bin/bash

WORKDIR=$1
EXED=$2

cd $WORKDIR
wname="'fort.12'"
cat > ww3_prep.inp << EOF
$ ---------------------------------------------------------------
$ WAVEWATCH III Field preprocessor input file
$ ---------------------------------------------------------------
   'WND' 'LL' T T
$
   -82.00 -52.0 121 22.0 48.00 105
  'NAME' 1 1 '(..T..)' '(..T..)'
  20 $wname
$
$ ---------------------------------------------------------------
$ end of input file
$ ---------------------------------------------------------------
EOF
#
# Run ww3_prep
$EXED/ww3_prep > ww3_prep_eastc.out


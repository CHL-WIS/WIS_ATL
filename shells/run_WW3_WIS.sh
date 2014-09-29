#!/bin/bash
#
# ---------------------------------------------------------------
#
#   Script for running WW3 in Pacific domain for WIS test
#
#   written 06/03/11 TJ Hesser
#
#
# ---------------------------------------------------------------
#
UNAME='TJHesser'
BASIN='atl'
BASE=$WORKDIR/WIS_ATL
OUTD=$BASE/outdat
INPF=$BASE/inputfiles
SHEL=$BASE/shells
WIND=$INPF/winds/
FCOD=$BASE/fcode
EXED=$BASE/exe
#
#
# Go to winds directory and generate file with all winds 
#
#
cd $WIND
ls -1 *AES.WIN > $SHEL/windlist.tmp
#
# Go to shells directory and find winds to run
#
cd $SHEL
cat windlist.tmp | while read WINDS
do 
  echo $WINDS
  if grep $WINDS donelist
  then
    :
  else
    echo $WINDS >> torunlist.tmp
  fi 
done
#
#
cat torunlist.tmp | while read WINDS
 do 
   sleng="${#WINDS}"
   let "suse = $sleng - 4"
   FILESZ=`ls -l $WIND/$WINDS | awk '{printf "%s", $5} '  `
   STORMTMP=`echo $WINDS | cut -c1-$suse `
   echo $STORMTMP >> stormlist
done
#
#  Remove the temporary FILES
#
rm ${SHEL}/windlist.tmp
rm ${SHEL}/torunlist.tmp
#
#
# --------------------------------------------------------------
# --------------------------------------------------------------
#  Loop to run storms 
# --------------------------------------------------------------
#
cd $SHEL
File="stormlist"
exec 3<&0
exec 0<"$File"
read STORM_NAME2
STN=`echo $STORM_NAME2 | cut -c1-4 `
year=`echo $STORM_NAME2 | cut -c1 `
if [ $year -le 9 ] 
then 
  STORM_NAME="19${STN}_WIS_ATL_WW3_OWI_ST4"
else 
  STORM_NAME="20${STN}_WIS_ATL_WW3_OWI_ST4"
fi 

RUN_NAME=`echo $STORM_NAME | cut -c1-6 `
WORKDIR=`echo $OUTD/$STORM_NAME `
if [ ! -d $WORKDIR ]
  then 
   mkdir $WORKDIR
else
   echo `date` ${STORM_NAME} HAS ALREADY BEEN PROCESSED >> ${SHEL}/failog
   exit 0
fi
#
WINDPROC=`echo ${STORM_NAME2}.WIN `
#
if [ -f ${WIND}/${WINDPROC} ]
then
cd $WORKDIR
#
#  Move grids and make ww3_grid.inp
#  Run ww3_grid
$SHEL/genscript_basin_l1.sh $INPF $WORKDIR $EXED
#
#
#  NEW:  READING WIND FILE and CONSTRUCTING THE FLAT ASCII File for WW3.
#        Making the dates  
#
ln -sf $WIND/$WINDPROC $WORKDIR/fort.2
#
$FCOD/preproc_wnd_WW3.x
#
mv fort.20 ${WORKDIR}/${STORM_NAME}.datesin
cp fort.12 ${WORKDIR}/${STORM_NAME}.wnd
rm fort.2
#
#  Generate the ww3_prep.inp file
#  Run ww3_prep
$SHEL/genscript_prep_basin.sh $WORKDIR $EXED
#   
mv mod_def.ww3 mod_def.basin_l1
mv wind.ww3 wind.basin_l1
#
wind2a=` echo $WINDPROC | cut -c1-4 `
wind2=$wind2a"_AL2.WIN"
echo $wind2
ln -sf $WIND/$wind2 $WORKDIR/fort.2
$FCOD/preproc_wnd_WW3.x
cp fort.12 ${WORKDIR}/${STORM_NAME}-eastc.wnd
rm fort.2
$SHEL/genscript_eastc_l2.sh $INPF $WORKDIR $EXED
$SHEL/genscript_prep_eastc.sh $WORKDIR $EXED
cp mod_def.ww3 mod_def.inp_eastc
mv mod_def.ww3 mod_def.eastc_l2
mv wind.ww3 wind.inp_eastc
#
$SHEL/genscript_coast_l3.sh $INPF $WORKDIR $EXED
mv mod_def.ww3 mod_def.coast_l3
#
#
rm *.grd *.mask *.obstr
$SHEL/genscript_multi.sh $STORM_NAME $WORKDIR
$SHEL/genscript_sub.sh $STORM_NAME $RUN_NAME $BASE $BASIN $UNAME

echo $WINDPROC >> $SHEL/donelist

else
echo `date` Wind Field $WINDPROC DOES NOT EXIST >> $SHEL/stormlog
fi
rm -f $SHEL/stormlist
exit 0



#!/bin/bash

STORM_NAME=$1
RUN_NAME=$2
BASE=$3
BASIN=$4
EXED=$BASE/exe
SHEL=$BASE/shells
WORKDIR=$BASE/outdat/$STORM_NAME

cd $WORKDIR
cat > serial_points1.sh << EOF
#!/bin/bash

cd $WORKDIR

   $SHEL/ww3_post_nc_point.sh  ALL ALL 1 coast_l3 coast $STORM_NAME $BASE $BASIN   > ww3_post1.out     &
wait

EOF
chmod 760 $WORKDIR/serial_points1.sh

cd $WORKDIR
cat > serial_fields.sh << EOF
#!/bin/bash

cd $WORKDIR


   $SHEL/ww3_post_nc_field.sh  basin_l1 basin $STORM_NAME $BASE $BASIN 1  > ww3_post1.out    &
   $SHEL/ww3_post_nc_field.sh  basin_l1 basin $STORM_NAME $BASE $BASIN 2 > ww3_post2.out     &
   $SHEL/ww3_post_nc_field.sh  basin_l1 basin $STORM_NAME $BASE $BASIN 3 > ww3_post3.out     &
   $SHEL/ww3_post_nc_field.sh  basin_l1 basin $STORM_NAME $BASE $BASIN 4 > ww3_post2.out     &
   $SHEL/ww3_post_nc_field.sh  basin_l1 basin $STORM_NAME $BASE $BASIN 5 > ww3_post2.out     &

   $SHEL/ww3_post_nc_field.sh  eastc_l2 eastc $STORM_NAME $BASE $BASIN 1  > ww3_post1.out    &
   $SHEL/ww3_post_nc_field.sh  eastc_l2 eastc $STORM_NAME $BASE $BASIN 2 > ww3_post2.out     &
   $SHEL/ww3_post_nc_field.sh  eastc_l2 eastc $STORM_NAME $BASE $BASIN 3 > ww3_post3.out     &
   $SHEL/ww3_post_nc_field.sh  eastc_l2 eastc $STORM_NAME $BASE $BASIN 4 > ww3_post2.out     &
   $SHEL/ww3_post_nc_field.sh  eastc_l2 eastc $STORM_NAME $BASE $BASIN 5 > ww3_post2.out     &

   $SHEL/ww3_post_nc_field.sh  coast_l3 coast $STORM_NAME $BASE $BASIN 1  > ww3_post1.out    &
   $SHEL/ww3_post_nc_field.sh  coast_l3 coast $STORM_NAME $BASE $BASIN 2 > ww3_post2.out     &
   $SHEL/ww3_post_nc_field.sh  coast_l3 coast $STORM_NAME $BASE $BASIN 3 > ww3_post3.out     &
   $SHEL/ww3_post_nc_field.sh  coast_l3 coast $STORM_NAME $BASE $BASIN 4 > ww3_post2.out     &
   $SHEL/ww3_post_nc_field.sh  coast_l3 coast $STORM_NAME $BASE $BASIN 5 > ww3_post2.out     &

wait

EOF
chmod 760 $WORKDIR/serial_fields.sh

cat > $WORKDIR/tar_points.sh << EOF
#!/bin/bash

  $SHEL/tar_points.sh $STORM_NAME $BASE coast_l3  &
wait

EOF
chmod 760 $WORKDIR/tar_points.sh

cat > $WORKDIR/netcdf_fields.sh << EOF
#!/bin/bash

   $SHEL/ww3_make_nc_field.sh  basin_l1 basin $STORM_NAME $BASE $BASIN  > ww3_post1.out     &
   $SHEL/ww3_make_nc_field.sh  eastc_l2 eastc $STORM_NAME $BASE $BASIN  > ww3_post1.out     &
   $SHEL/ww3_make_nc_field.sh  coast_l3 coast $STORM_NAME $BASE $BASIN  > ww3_post1.out     &

wait

EOF
chmod 760 $WORKDIR/netcdf_fields.sh


cat > ${STORM_NAME}_points.sh << EOF
#!/bin/bash
#
#PBS -N ${RUN_NAME}_point
#PBS -q debug
#PBS -A ERDCV03995SHS
#PBS -l select=1:ncpus=32:mpiprocs=32
#PBS -l walltime=00:30:00
#PBS -j oe
#PBS -m abe
#PBS -M tyler.hesser@usace.army.mil
#PBS -l ccm=1
#PBS -l application=Other

#
unmask 007
unmask
export MPICH_UNEX_BUFFER_SIZE=240M
export MPICH_ENV_DISPLAY=1
export MPICH_ABORT_ON_ERROR=1
export MPI_GROUP_MAX=32
#
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#      START OF THE BASIN SHELL SCRIPT FOR AUTOMATED FORECAST
#
#
# ---------------------------------
#
cd $WORKDIR
ccmrun $WORKDIR/serial_points.sh > serial_points.out

wait

ccmrun $WORKDIR/tar_points.sh > tar_points.out

wait
#
# ----------------------------------------------------------------
# end submit script
# -------------------------------------------------------------
EOF

chmod 760 $WORKDIR/${STORM_NAME}_points.sh
qsub $WORKDIR/${STORM_NAME}_points.sh

cat > ${STORM_NAME}_fields.sh << EOF
#!/bin/bash
#
#PBS -N ${RUN_NAME}_field
#PBS -q debug
#PBS -A ERDCV03995SHS
#PBS -l select=1:ncpus=32:mpiprocs=32
#PBS -l walltime=01:00:00
#PBS -j oe
#PBS -m abe
#PBS -M tyler.hesser@usace.army.mil
#PBS -l ccm=1
#PBS -l application=Other

#
unmask 007
unmask
export MPICH_UNEX_BUFFER_SIZE=240M
export MPICH_ENV_DISPLAY=1
export MPICH_ABORT_ON_ERROR=1
export MPI_GROUP_MAX=32
#
# +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
#      START OF THE BASIN SHELL SCRIPT FOR AUTOMATED FORECAST
#
#
# ---------------------------------
#
cd $WORKDIR
ccmrun $WORKDIR/serial_fields.sh > serial_fields.out
wait

ccmrun $WORKDIR/netcdf_fields.sh > netcdf_fields.out

wait
#
# ----------------------------------------------------------------
# end submit script
# -------------------------------------------------------------
EOF

chmod 760 $WORKDIR/${STORM_NAME}_fields.sh
qsub $WORKDIR/${STORM_NAME}_fields.sh


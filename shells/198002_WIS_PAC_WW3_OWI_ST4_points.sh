#!/bin/bash
#
#PBS -N _point
#PBS -q debug
#PBS -A ERDCV03995SHS
#PBS -l select=2:ncpus=32:mpiprocs=32
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
cd /outdat/198002_WIS_PAC_WW3_OWI_ST4
ccmrun /outdat/198002_WIS_PAC_WW3_OWI_ST4/serial_points.sh > serial_points.out

wait

ccmrun /outdat/198002_WIS_PAC_WW3_OWI_ST4/tar_points.sh > tar_points.out

wait
#
# ----------------------------------------------------------------
# end submit script
# -------------------------------------------------------------

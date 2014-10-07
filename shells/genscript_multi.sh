#!/bin/bash
#
#
STORM_NAME=$1
WORKDIR=$2
#
cd $WORKDIR
sdat1=`awk '{printf "%s", $1} ' ${STORM_NAME}.datesin `
sdat2=`awk '{printf "%s", $2} ' ${STORM_NAME}.datesin `
edat1=`awk '{printf "%s", $3} ' ${STORM_NAME}.datesin `
edat2=`awk '{printf "%s", $4} ' ${STORM_NAME}.datesin `

str=`echo $sdat1 | cut -c1-6 `
stc=`echo $sdat1 | cut -c7-8 `
st1=`echo $sdat2 | cut -c1-2 `
ste=`echo $sdat2 | cut -c3-6 `
st2=`echo $((st1+1)) `
st3=`echo $((stc+1)) `
if [ $st2 -lt "10" ]
  then
  stc="0"$st2
else
  stc=$st2
fi
if [ $st3 -lt "10" ]
  then
  sto="0"$st3
else
  sto=$st3
fi
startf=$stc$ste
start1=$str$sto

#
cat > ww3_multi.inp << EOF
 -------------------------------------------------------------------- $
$ WAVEWATCH III multi-grid model driver input file                     $
$ -------------------------------------------------------------------- $
$
$ *******************************************************************
$ *** NOTE : This is an example file from the mww3_test_05 script ***
$ ***        Unlilke other input example files this one CANNOT    ***
$ ***        be run as an independent interactive run             ***
$ *******************************************************************
$
$ The first input line sets up the general multi-grid model definition
$ by defining the follwing six parameters :
$
$   1) Number of wave model grids.i                         ( NRGRD )
$   2) Number of grids definint input fields.               ( NRINP )
$   3) Flag for using unified point output file.           ( UNIPTS )
$   4) Output server type as in ww3_shel.inp
$   5) Flag for dedicated process for iunified point output.
$   6) Flag for grids sharing dedicated output processes.
$
  3 1 F 1 F F
$
 'inp_eastc' F F T F F F F
$
$ -------------------------------------------------------------------- $
$ Now each actual wave model grid is defined using 13 parameters to be
$ read fom a single line in the file. Each line contains the following
$ parameters
$     1)   Define the grid with the extension of the mod_def file.
$    2-8)  Define the inputs used by the grids with 8 keywords
$          corresponding to the 8 flags defining the input in the
$          input files. Valid keywords are:
$            'no'      : This input is not used.
$            'native'  : This grid has its own input files, e.g. grid
$                        grdX (mod_def.grdX) uses ice.grdX.
$            'MODID'   : Take input from the grid identified by
$                        MODID. In the example below, all grids get
$                        their wind from wind.input (mod_def.input).
$     9)   Rank number of grid (internally sorted and reassigned).
$    10)   Group number (internally reassigned so that different
$          ranks result in different group numbers.
$   11-12) Define fraction of cumminicator (processes) used for this
$          grid.
$    13)   Flag identifying dumping of boundary data used by this
$          grid. If true, the file nest.MODID is generated.
$
  'basin_l1'  'no' 'no' 'native' 'no' 'no' 'no' 'no'   1  1  0.00 1.00  F
  'eastc_l2'  'no' 'no' 'inp_eastc' 'no' 'no' 'no' 'no'   2  1  0.00 1.00  T
  'coast_l3'  'no' 'no' 'inp_eastc' 'no' 'no' 'no' 'no'   3  1  0.00 1.00  F
$  'cali_l4'  'no' 'no' 'native' 'no' 'no' 'no' 'no'   4  1  0.00 1.00  F  
$  'hawaii_l2'  'no' 'no' 'inp_basin' 'no' 'no' 'no' 'no'   5  1  0.00 1.00  T
$  'hawaii_l3'  'no' 'no' 'inp_basin' 'no' 'no' 'no' 'no'   6  1  0.00 1.00  F
$ 'grd3'  'no' 'no' 'input' 'no' 'no' 'no' 'no'   3  1  0.50 1.00  F
$
$ In this example three grids are used requiring the files
$ mod_def.grdN. All files get ther winds from the grid 'input'
$ defined by mod_def.input, and no other inputs are used. In the lines
$ that are commented out, each grid runs on a part of the pool of
$ processes assigned to the computation.
$
$ -------------------------------------------------------------------- $
$ Starting and ending times for the entire model run
$
   $sdat1 $sdat2   $edat1 $edat2
$
$ -------------------------------------------------------------------- $
$ Specific multi-scale model settings (single line).
$    Flag for masking computation in two-way nesting (except at
$                                                     output times).
$    Flag for masking at printout time.
$
  T F
$
$ Define output data ------------------------------------------------- $
$
$ Five output types are available (see below). All output types share
$ a similar format for the first input line:
$ - first time in yyyymmdd hhmmss format, output interval (s), and
$   last time in yyyymmdd hhmmss format (all integers).
$ Output is disabled by setting the output interval to 0.
$
$ Type 1 : Fields of mean wave parameters
$          Standard line and line with flags to activate output fields
$          as defined in section 2.4 of the manual. The second line is
$          not supplied if no output is requested.
$                               The raw data file is out_grd.ww3,
$                               see w3iogo.ftn for additional doc.
$
$
    $sdat1 $startf 3600  $edat1 $edat2
$
  N
  WND HS FP DIR SPR PHS PTP PDIR PNR
$
$
    $sdat1 $startf 0  $edat1 $edat2
$
$
    $sdat1 $startf 0  $edat1 $edat2
$
$
$ Type 4 : Restart files (no additional data required).
$                               The data file is restartN.ww3, see
$                               w3iors.ftn for additional doc.
$
    $edat1 $edat2 1  $edat1 $edat2
$
$ Type 5 : Boundary data (no additional data required).
$                               The data file is nestN.ww3, see
$                               w3iobp.ftn for additional doc.
$
   $sdat1 $startf     0  $edat1 $edat2
$
   $sdat1 $startf     0  $edat1 $edat2
$
$ -------------------------------------------------------------------- $
$ Output requests per grid and type to overwrite general setup
$ as defined above. First record per set is the grid name MODID
$ and the output type number. Then follows the standard time string,
$ and conventional data as per output type. In mww3_test_05 this is
$ not used. Below, one example generating partitioning output for
$ the inner grid is included but commented out.
$
$
$
 'coast_l3'  2
  $sdat1 $startf   3600  $edat1 $edat2
 -68.3300  42.67000   44005
 -70.0800  43.50000   44007
    0.E3       0.E3    'STOPSTRING'
$
$ -------------------------------------------------------------------- $
$ Mandatory end of outpout requests per grid, identified by output
$ type set to 0.
$
  'the_end'  0
$
$ -------------------------------------------------------------------- $
$ Moving grid data as in ww3_hel.inp. All grids will use same data.
$
   'STP'
$
$ -------------------------------------------------------------------- $
$ End of input file                                                    $
$ -------------------------------------------------------------------- $
EOF

#!/bin/bash

cd /outdat/198003_WIS_PAC_WW3_OWI_ST4


   /shells/ww3_post_nc_field.sh  basin_l1 basin 198003_WIS_PAC_WW3_OWI_ST4   1  > ww3_post1.out    &
   /shells/ww3_post_nc_field.sh  basin_l1 basin 198003_WIS_PAC_WW3_OWI_ST4   2 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  basin_l1 basin 198003_WIS_PAC_WW3_OWI_ST4   3 > ww3_post3.out     &
   /shells/ww3_post_nc_field.sh  basin_l1 basin 198003_WIS_PAC_WW3_OWI_ST4   4 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  basin_l1 basin 198003_WIS_PAC_WW3_OWI_ST4   5 > ww3_post2.out     &

   /shells/ww3_post_nc_field.sh  westc_l2 westc 198003_WIS_PAC_WW3_OWI_ST4   1  > ww3_post1.out    &
   /shells/ww3_post_nc_field.sh  westc_l2 westc 198003_WIS_PAC_WW3_OWI_ST4   2 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  westc_l2 westc 198003_WIS_PAC_WW3_OWI_ST4   3 > ww3_post3.out     &
   /shells/ww3_post_nc_field.sh  westc_l2 westc 198003_WIS_PAC_WW3_OWI_ST4   4 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  westc_l2 westc 198003_WIS_PAC_WW3_OWI_ST4   5 > ww3_post2.out     &

   /shells/ww3_post_nc_field.sh  westc_l3 westc 198003_WIS_PAC_WW3_OWI_ST4   1  > ww3_post1.out    &
   /shells/ww3_post_nc_field.sh  westc_l3 westc 198003_WIS_PAC_WW3_OWI_ST4   2 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  westc_l3 westc 198003_WIS_PAC_WW3_OWI_ST4   3 > ww3_post3.out     &
   /shells/ww3_post_nc_field.sh  westc_l3 westc 198003_WIS_PAC_WW3_OWI_ST4   4 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  westc_l3 westc 198003_WIS_PAC_WW3_OWI_ST4   5 > ww3_post2.out     &

   /shells/ww3_post_nc_field.sh  cali_l4 cali 198003_WIS_PAC_WW3_OWI_ST4   1  > ww3_post1.out    &
   /shells/ww3_post_nc_field.sh  cali_l4 cali 198003_WIS_PAC_WW3_OWI_ST4   2 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  cali_l4 cali 198003_WIS_PAC_WW3_OWI_ST4   3 > ww3_post3.out     &
   /shells/ww3_post_nc_field.sh  cali_l4 cali 198003_WIS_PAC_WW3_OWI_ST4   4 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  cali_l4 cali 198003_WIS_PAC_WW3_OWI_ST4   5 > ww3_post2.out     &

   /shells/ww3_post_nc_field.sh  hawaii_l2 hawaii 198003_WIS_PAC_WW3_OWI_ST4   1  > ww3_post1.out    &
   /shells/ww3_post_nc_field.sh  hawaii_l2 hawaii 198003_WIS_PAC_WW3_OWI_ST4   2 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  hawaii_l2 hawaii 198003_WIS_PAC_WW3_OWI_ST4   3 > ww3_post3.out     &
   /shells/ww3_post_nc_field.sh  hawaii_l2 hawaii 198003_WIS_PAC_WW3_OWI_ST4   4 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  hawaii_l2 hawaii 198003_WIS_PAC_WW3_OWI_ST4   5 > ww3_post2.out     &

   /shells/ww3_post_nc_field.sh  hawaii_l3 hawaii 198003_WIS_PAC_WW3_OWI_ST4   1  > ww3_post1.out    &
   /shells/ww3_post_nc_field.sh  hawaii_l3 hawaii 198003_WIS_PAC_WW3_OWI_ST4   2 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  hawaii_l3 hawaii 198003_WIS_PAC_WW3_OWI_ST4   3 > ww3_post3.out     &
   /shells/ww3_post_nc_field.sh  hawaii_l3 hawaii 198003_WIS_PAC_WW3_OWI_ST4   4 > ww3_post2.out     &
   /shells/ww3_post_nc_field.sh  hawaii_l3 hawaii 198003_WIS_PAC_WW3_OWI_ST4   5 > ww3_post2.out     &

wait


#/bin/bash 
 
#This part is only for running in SLURP at ecmwf
#SBATCH --error=main.err
#SBATCH --output=main.out
#SBATCH --job-name=harp_user_scripts

#set -x  

source config/config_atos.sh

if [ "$RUN_VOBS2SQL" == "yes" ]; then 
    echo "Running vobs2sql"
   $RS_DIR/point_pre_processing/vobs2sql.R  
fi 

if [ "$RUN_VFLD2SQL" == "yes" ]; then 
     echo "Running vfld2sql"
    $RS_DIR/point_pre_processing/vfld2sql.R 
fi 
 

if [ "$RUN_POINT_VERF" == "yes" ]; then 
   $RS_DIR/point_verif/point_verif.R 
fi 

if [ "$RUN_POINT_VERF_LOCAL" == "yes" ]; then 
   echo "Running complete verification set"
   $RS_DIR/point_verif/point_verif_local.R   
fi 

if [ "$SCORECARDS" == "yes" ]; then 
   $RS_DIR/point_verif/create_scorecards.R   
fi 

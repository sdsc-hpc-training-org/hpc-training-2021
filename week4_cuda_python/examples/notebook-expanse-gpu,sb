#!/bin/bash
##
## ======================================================================
## This is an example batch script which can be submitted as part of a
## reverse proxy jupyter notebook. This batch script creates the jupyter
## notebook on a compute node, while the start notebook script is used to
## submit this batch script. You should never submit this batch script on
## its own, e.g. `sbatch slurm-expanse/notebook.sh`. Don't do that :).
## You can specify this particluar batch script by using the -b flag, e.g.
## ./start-jupyter -b slurm-expanse/notebook.sh
## ======================================================================

## You can add your own slurm directives here, but they may override
## anything you gave to the start-jupyter script like the time, partition, etc
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=10
#SBATCH --gpus=1
#SBATCH --export=ALL

## Environment
module purge
module load slurm
module load gpu
module load anaconda3

# DO NOT EDIT BELOW THIS LINE
source $start_root/lib/check_available.sh
source $start_root/lib/get_jupyter_port.sh

# Get the expanse node's IP (really just the hostname)
IP=$(hostname -s).eth.cluster
check_available jupyter-notebook "Try 'conda install jupyter'" || exit 1
jupyter notebook --ip $IP --config $config --no-browser &

# the jupyter pid is stored in the variable $!
PORT=$(get_jupyter_port $!)

# redeem the api_token given the untaken port
url='"https://manage.$endpoint/redeemtoken.cgi?token=$api_token&port=$PORT"'

# Redeem the api_token
eval curl $url

# try to remove the config file.
rm $config

# waits for all child processes to complete, which means it waits for the jupyter notebook to be terminated
wait

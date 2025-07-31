# Cyclodextrin-PFAS Simulations


This repository contains molecular dynamics (MD) simulation setups, scripts, and analysis tools to study the interactions between **α/β/γ‑cyclodextrins (ACD/BCD/GCD)** and various **PFAS or interferent molecules** (PFOS, SDS, TCAA).   The workflow is designed for **GROMACS + PLUMED** simulations with **free‑energy calculations** to assess binding and selectivity. <br />

## qMD4
This folder contains the .gro and .itp files for setting up cyclodextrins for simulation.   <br />

## interferents_gaff
This folder contains the .gro and .itp files for setting up interferents for simulation <br />

## system_cd 

This folder contains all relevant files for simulation of PFAS - Cyclodextrin systems. The folder is subdivided into subfolders containing the required scripts to assemble the simulations, equilibrate the systems and perform the molecular dynamics calculations.  <br />

## analysis

This folder contains the jupyter notebook and corresponding .py files for computing delta Gs and Kbs for any given system for your choice of grid and cutoff.


## 📂 Repository Structure
Cyclodextrin-PFAS_Simulations/<br />
│
├── LICENSE              # MIT or chosen license<br />
├── README.md            # Project documentation<br />
│
├── analysis/            # Analysis scripts and notebooks<br />
│   ├── KbdG_samplecalculations.ipynb  # Example free-energy/binding calc<br />
│   ├── calculateFES.py                 # Compute free energy surfaces (FES)<br />
│   └── process-traj-unbiased.sh        # Process raw MD trajectories<br />
│
├── interferents_gaff/   # Force-field (GAFF) for interferent molecules<br />
│   ├── TCAA.*           # Trichloroacetic acid (TCAA) inputs<br />
│   ├── sds.*            # SDS inputs<br />
│   ├── *.sh             # Box generation & parameter extraction scripts<br />
│
├── qMD4/                # Cyclodextrin base parameter files<br />
│   ├── acd.gro/top      # α-cyclodextrin<br />
│   ├── bcd/...          # β-cyclodextrin with force-field files<br />
│   ├── gcd.gro/top      # γ-cyclodextrin<br />
│   ├── ions.itp, water-ffatoms.itp<br />
│
└── system_cd/           # Full MD system setups for each host–guest pair<br />
    ├── pfos-f-*         # PFOS with ACD, BCD, GCD<br />
    ├── sds-f-*          # SDS with ACD, BCD, GCD<br />
    ├── tcaa-f-*         # TCAA with ACD, BCD, GCD<br />
    │   ├── *.gro/top/itp/mdp         # Structures & topology<br />
    │   ├── plumed.dat               # Biasing/collective variable setup<br />
    │   ├── taac-*.sbatch            # Cluster submission scripts<br />
    │   ├── reweight*.sh             # Free-energy reweighting scripts<br />


- **`*-f-acd`**, **`*-f-bcd`**, **`*-f-gcd`**: PFAS/interferent bound to α, β, γ‑cyclodextrin  <br />
- **`*.mdp`**: Standard GROMACS input files for minimization, equilibration, and production runs  <br />
- **`plumed*.dat`**: PLUMED inputs for biasing<br />
- **`*.sbatch`**: SLURM job submission scripts for HPC execution  <br />



**Published work avaliable at DOI: 10.26434/chemrxiv-2024-6q6q5** <br />



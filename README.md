# SNr_data  
Data processing and visualization scripts in Matlab.

baseline.m: studies the baseline recording "SNr cell firing baseline".  
baseline_isi.m: generates pre-stimulation baseline ISI distributions.  
baseline_raster.m: compares the pre-stimulation baseline raster plots between with ZD and without ZD. 
baseline_v2.m: compares the first post-stim and the last pre-stim spiketime distributions with and without stimulation.  
baseline_v3.m: compares the first post-stim and the last pre-stim spiketime distributions from data and from prediction based on ISI distribution.  

cumulative_plots.m: generates eCDFs of spiketimes and other useful graphs.  
raster_plots.m: generates the rastor plot and spiketime histogram of a selected data file.  
rate_nZD.m: generates 2x3 (GPe, D1; 5Hz, 10Hz, 20Hz) spiketime histograms of all trials without ZD.  
rate_nZD_PSTH.m: generates 2x3 PSTHs of all trials without ZD.  
rate_nZD_PSTH_50stims.m: generates 2x3 PSTHs of the first 50 stimulations each of all trials without ZD.  
rate_20Hz_firstPSTH.m: generates first-spike PSTHs of the first 50 stimulations each of all trials.  
rate_20Hz_firstPSTH_all.m: generates first-spike PSTHs of all stimulations of all trials.  
recovery_20Hz.m: illustrates how PSTH and first-spike PSTH evolve as the stimulation carries out in time.  
rate_20Hz_secPSTH.m: generates second-spike PSTHs of all stimulations each of all trials.  
rate_nZD_secPSTH.m: generates second-spike PSTHs of all stimulations each of all trials.  
find_isi.m: plot the ISI distributions under stimulation.  

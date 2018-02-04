% Macaque V1 grating dataset
% Static gratings, binned spikes 
%
% Provided by A. S. Tolias, A. S. Ecker, P. Berens and M. Bethge 
% http://bethgelab.org/datasets/v1gratings/
%
% Licensed under a Creative Commons Attribution-NonCommercial-NoDerivs 3.0 
% Unported License.
% For details, see http://creativecommons.org/licenses/by-nc-nd/3.0/
%
% The mat file contains a cell array, in which each cell contains a
% struct with all metadata and data from one session. The fields of the
% structure contain the following:
%
% date              date and time stamp when the session was recorded
% subject           identifies the monkey used in the session
% conditions        specifies the orientation and contrast used
% contamination     contamination of the single units, for details see
%                   paper; for both studies only units with a contamination
%                   value < 0.05 were used
% tetrode           specifies the tetrode a single unit was recorded on;
%                   for tetrode grid layout, see supplementary material of 
%                   Ecker et al. (2010)
% spikes            contains binned spikes
%                   single units x conditions x time bins x repetitions
% times             times aligned to bin centers
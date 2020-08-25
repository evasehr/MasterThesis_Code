import os
import pandas as pd

#cwd = os.getcwd()
cwd = '/Carnegie/DPB/Data/Shared/Labs/Moi/Everyone/deepselection/randomForest/'
src = '/Carnegie/DPB/Data/Shared/Labs/Moi/Everyone/deepselection/'
# src = '../'		                                                    #provide source folder path

betas = pd.DataFrame(columns=['rs'])                                                #creation of empty table with betas
for current_folder, sub_folders, files in os.walk(src):
    full_path = os.path.abspath(current_folder)
    for folder in sub_folders:
        print('You are currently here: ', os.path.join(current_folder, folder))     #as a check - prints the actual location
    for file in files:
        if file.startswith(('clim-bio', 'clim-tm', 'clim-prec', 'rFitness2_mlp', 'rFitness2_mli', 'rFitness2_thi', 'rFitness2_thp')):			#only bio, prec, tmax and tmin
            if file.endswith('assoc.txt'):
                df = pd.read_csv(f'{full_path}/{file}', delim_whitespace=True)
                fname_w_ext = os.path.basename(file)                                    #takes filename to be used later as column name
                fname, fext = os.path.splitext(fname_w_ext)
                dfsel = df[['rs', 'beta']]                                              #greps necessary columns -> rs and beta
                dfsel.columns = ['rs', fname]                                           #renaming of beta column with filename
                betas = betas.merge(dfsel, on='rs', how='outer')                        #outer join on column 'rs'
betas.rename(columns=lambda x: x.rstrip('.assoc'), inplace=True)                          #removes '.assoc' from column name
betas.rename(columns={'r':'rs'}, inplace=True) 
betas.dropna(inplace=True)							    #drops lines with NA values (resembling inner join)
betas.to_csv(r'/Carnegie/DPB/Data/Shared/Labs/Moi/Everyone/deepselection/randomForest/betas_woNAs_55climvars_rFit.txt', sep='\t', index=False)                                             #export to CSV
#print('Table with betas has been saved to', cwd)




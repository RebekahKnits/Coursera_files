The run_analysis assumes the data files are in the 'UCI HAR Dataset' folder inside a folder marked as data. 
I extracted the data. 
I merge the data into X and Y and subject groups.
I pull out only the measurements from X that are related to Mean and STD. 
I label the columns with Time and Frequency rather than t and f to see better. I also remove the parathesis as they are special characters.
Finally I bind the three data elements together in preparation for the final 'tidy data set'.


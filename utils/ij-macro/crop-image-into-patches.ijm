// Close all open tif's and nd2's
close("*.tif");

// don't show images
batchMode = false;
setBatchMode(batchMode);

// Define Input Folder
input = getDirectory("Select a Directory for import");
print(input)

// Define Output Folder
// output = getDirectory("Select a Directory for output"); // "/Users/kkolyva/Desktop/test_f/d/";

// Get list of files
filenames = getFileList(input);
Array.sort(filenames);

// General start for fish folders
prefix = "fish_"

// patch width\height
pWidth = 256;
pHeight = 256;

for (iFile = 0; iFile < 1 /*filenames.length*/; ++iFile){
	if (startsWith(filenames[iFile], prefix)){

		// you don't care about the correspondences img-to-mask
		// just crop verything into pieces but with proper naming  	

		imagePath = input + filenames[iFile]; 
		imageName = filenames[iFile];

		print(imagePath);
		open(imagePath);

		getDimensions(gWidth, gHeight, channels, slices, frames);


		
		for(i = 0; i < gWidth / pWidth; i++){
			for (j = 0; j < gHeight / pHeight; j++){
				makeRectangle(i*pWidth, j*pHeight, pWidth, pHeight);
				run("Duplicate...", "title=" + imageName + i + j);
				close();
			}	
		}
	}
	showProgress(iFile, filenames);
}
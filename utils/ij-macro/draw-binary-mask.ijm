// Close all open tif's and nd2's
close("*.tif");

// don't show images
setBatchMode(true);

// Define Input Folder
input = getDirectory("Select a Directory for import");

// Define Output Folder
// output = getDirectory("Select a Directory for output"); // "/Users/kkolyva/Desktop/test_f/d/";

// Get list of files
filenames = getFileList(input);
Array.sort(filenames);

// General start for fish folders
prefixFolder = "fish_"

for (iFile = 0; iFile < filenames.length; ++iFile){
	if (startsWith(filenames[iFile], prefixFolder)){
		fishFolder = input + filenames[iFile];
		roiPath = fishFolder + "RoiSet.zip";
		imagePath = fishFolder + "content-based projection.tif";
		maskPath = fishFolder + "mask.png";

		if (File.exists(roiPath) && File.exists(imagePath)){
			print(fishFolder);

			open(imagePath);
			saveAs("JPG", imagePath);
			getDimensions(width, height, channels, slices, frames);
			close();

			newImage("mask", "8-bit black", width, height, 1); // 1 slice
			run("ROI Manager...");
			roiManager("Open", roiPath);
			roiManager("Show All");
			// create the binary mask
			roiManager("Draw");

			saveAs("PNG", maskPath);
			// close roi manager to remove old spots
			run("Close");

			close();
		}
	}
}
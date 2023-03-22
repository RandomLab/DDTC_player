//-------------------------------------------------------------
//FILE FINDERS / WITH EXT AND MAC NOT SHOWING
//-------------------------------------------------------------
String [] getFilesInDirectory(String path, String [] ext){
	File file = new File(path);
  if (file.isDirectory()) {
    println("is a directory");
		// Get all the files in the directory
		String[] names = file.list();
		// Create a new list to hold the files with the extension
		StringList files = new StringList();
		// Loop through the files
		for (int i = 0; i < names.length; i++) {
			// Get the file name
			String name = names[i];
			// Check if it ends with the extension

			boolean autorizedExt = false;
			for (int j = 0; j < ext.length; j++) {
				if (name.toUpperCase().endsWith(ext[j].toUpperCase()) && !name.startsWith(".")) {
					autorizedExt = true;
				}
			}

			if (autorizedExt) {
				// Add it to the list
				files.append(name);
			}
		}
		// Convert the list to an array
		String[] namesRes = files.array();
		// Return the array
    return namesRes;
  } else {
    // If it's not a directory
    return null;
  }
}



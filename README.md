# 7zipBulkValidation
Powershell script to test archives, log the good ones, and log then delete the bad archives.

Outline:
1. Set Alias for 7zip. Should match default install location if installed on C:\
2. Set location to the root folder with the bulk archives. Directories within this folder are expected.
3. Set Powershell Out-File default width to 10k so Out-file doesn't word-wrap your path names
4. Run 7zip archive test.
5. Filter Errors only for .7z files into a log for deletion. Filter all files tested into "tested.log"
6. Clean up logs of tested and error so that they reflect the literal path
7. Sleep
8. Check to see if there are errors. If so, forcibly and recursively delete all erroneous 7z files.
9. Archive and error files from previous run

Feature Enhancements:

- [ ] Support user entered root domain.
- [ ] Push user submission into 7z call, clean up, Remove-Item.... etc
- [X] Add listfile argument to 7zip call to ignore already scanned files
- [X] Move Step 4 (Remove-Item Archive.log and Error.log) to end of script
- [ ] Resolve why "#" folder isn't being ignored even though its in the exclusion file


Found appropriate syntax for 7zip -xr switch
Added validation for whether oldtested.log exists or not to prevent 7zip -xr 'file doesn't exist' fatal error and added Write-Output to indicate that
Improved Write-Output at error and tested cleanup
Renamed main script file
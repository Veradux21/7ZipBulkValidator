# 7zipBulkValidation
Powershell script to test archives, log the good ones, and log then delete the bad archives.

Outline:
1. Set Alias for 7zip. Should match default install location if installed on C:\
2. Set location to the root folder with the bulk archives. Directories within this folder are expected.
3. Set Powershell Out-File default width to 10k so Out-file doesn't wordwrap your path names
4. Archive and error files from previous run (once debugging complete, move to bottom of the script)
5. Run 7zip archive test. (Need to figure out why the exclusion listfile argument isn't working... would significantly improve repeat runs)
6. Filter Errors only for .7z files into a log for deletion. Filter all files tested into "tested.log"
7. Clean up logs of tested and error so that they reflect the literal path
8. Sleep
9. Check to see if there are errors. If so, forcibly and recursively delete all erroneous 7z files.

Feature Enhancements:

- [ ] Support user entered root domain.
- [ ] Push user submission into 7z call, clean up, Remove-Item.... etc
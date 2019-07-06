HARR - Hackey Admin Rights Request

In this file:
1. What is HARR?				Ln. 9
2. How to call?					Ln. 13
3. How to use in other projects?		Ln. 29


  1______What is HARR

HARR is a utility that helps me (and maybe you) to request admin right from scripts (designed for batch scripts). It is packed in a 7z-archive.

  2______How to call

HARR's main file is a batch file [HARR.cmd], you can call it following with the filename to run in admin rights.

	Examples:

		How to start 'file.bat' with admin rights:

			HARR file.bat

		How to request admin rights from a batch script:

			if not "%Adminrequested%"=="1" (
			call HARR "%~s0"
			)

  3______How to use in other projects

Since HARR is part of HackeyBlock, it is equiped with the request name 'Hackey Admin Rights Request.exe' and with an HackeyBlock icon. You can change this.

	Replacing the icon:

    1. install WinRAR trial-version, this for the replacement of the icon.
    2. Open 'Hackey Admin Rights Request.exe' with WinRAR, this should be one of the options after right-clicking the file.
    3. Right-above, click on the [SFX] button.
    4. In the dialog window that opens, click on [advanced sfx-options].
    5. Click the  [Advanced] tab
    6. Opt-in on 'Ask for admin rights'
    7. Click the  [Text & icon] tab.
    8. Click on [Browse] aside 'load SFX-icon from file...'
    9. click [OK]
    10. the logo should be replaced.

Replacing the request name:

    1. rename 'Hackey Admin Rights Request.exe' to your desire
    2. update 'HARR-prcesr.HARRset' to the renamed file.

The license of the HackeyBlock project is applicable on HARR and assets.
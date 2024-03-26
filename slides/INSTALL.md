# IPP-LaTeX Bundle
Installation instructions for  TeX Live and MikTeX. 

## TeX Live:
1. Open a terminal window.
2. Run
```
	kpsewhich --var-value TEXMFLOCAL
```
this will return the path configured as TEXMFLOCAL tree.
Typical values are:
`/usr/local/texlive/texmf-local` (unix) or `c:/texlive/texmf-local` (windows)
in the following this path will be called <TEXMFLOCAL>
3. merge the drectories `tex` and `doc` of ipp-local.tds.zip into the `<TEXMFLOCAL>` directory. This file doesn't have to be installed. There should now be a directory containing the package/class files at `<TEXMFLOCAL>/tex/latex/local/ipp`
4. update the file name database by running mktexlsr (or texhash, which is a synonym) in the terminal
5.  Run one of the demo files, which can be found in `<TEXMFLOCAL>/doc/latex/local/ipp` to test the installation.


## MikTeX (General information can be found at https://miktex.org/faq/local-additions):
The following instructions assume that, you run MikTeX 2.9 without manual additions. If you already configured a TEXMFLOCAL-variable, you could replace the <TEXMFLOCAL> path by your own setting and jump to step 5.

1. Choose a position for your local texmf tree. Common choices are: <path to your User's home directory>/texmf-local. A system wide choice is possible, but you will have to run the MikTeX Console in administrator mode. In the following we will reference this path as `<TEXMFLOCAL>`, it might look like `c:/users/Username/texmf-local` or `~/texmf-local`.
2. Open the MikTeX Console. (For system wide setup, choose administrator mode)
3. Select the Directories tab inside the Settings menu.
4. Add your directory by clicking onto the “+”-button and add the path of `<TEXMFLOCAL>`. There might be a warning about the directory not being TDS-compliant. This can be ignored. It will be fixed later.
5. Merge the drectories `tex` and `doc` of ipp-local.tds.zip into the <TEXMFLOCAL> directory. This file doesn't have to be installed.
  Now there should be directories `tex` and `doc` inside the <TEXMFLOCAL> path.
6. Update the file name database: This can be done by clicking onto the Tasks button at the top of the MikTeX Console window. Run “Refresh file name database”. This is the same task, as running mktexlsr via the terminal.
7. Run one of the demo files, which can be found in `<TEXMFLOCAL>/doc/latex/local/ipp` to test the installation.

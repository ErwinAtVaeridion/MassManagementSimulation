-----IMPORTANT-----
PLEASE: DO NOT MODIFY ANY OF THESE FILES. 
-------------------

This folder contains all the files necessary to create a Vaeridion Latex document.
Please COPY ALL files to your local drive or to a shared folder to start working.

- report.tex is the main file where you describe the specifics of the document (e.g. title, document number etc)
- the different folders contain example files which you can modify and fill with your content.
- the .bst and the .cls files are not to be modified. They describe how the report looks.

After installation of TexStudio and MikTex, you can simply run the main file "report.tex" in TextStudio.
You will create a report.pdf file in the same working directory.



1. Compiler needs to be changed to XeLaTeX:
Options > Configure TexStudio… > Build > Default Compiler > XeLaTeX

2. VAERIDION_Latex_LatexClassFile.cls

2.1 included xcolor for XeLaTeX
\ifxetex
    \RequirePackage[xetex]{geometry}
    \RequirePackage[xetex]{graphicx}
    \RequirePackage[xetex]{hyperref}
    \RequirePackage{fontspec}
    \RequirePackage{xltxtra}
    \defaultfontfeatures{Ligatures=TeX}
    \RequirePackage[cmyk,table]{xcolor}
\else
	\RequirePackage[cmyk,pdftex,table]{xcolor}
    \ifpdf
        \RequirePackage[pdftex]{geometry}
        \RequirePackage[pdftex]{graphicx}
        \RequirePackage[pdftex]{hyperref}
        
    \else
        \RequirePackage[dvips]{geometry}
        \RequirePackage[dvips]{graphicx}
        \RequirePackage[hypertex]{hyperref}
    \fi
    \RequirePackage[T1]{fontenc}
    \RequirePackage[utf8]{inputenc}
\fi

2.2 
%% If the document is not compiled with XeLaTeX, we need to use the native
%% fonts.
\ifxetex
	\@nativefontsfalse
\else
	\@nativefontstrue
\fi

2.3 changed whole font sheme for XeLaTeX
\setmainfont{Avenir Next LT Pro}[
	    BoldFont = {Avenir Next LT Pro Bold},
	    ItalicFont = {Avenir Next LT Pro Italic},
	    BoldItalicFont = {Avenir Next LT Pro Bold Italic},
	    Ligatures=TeX
    ]
    \setsansfont[
        %Path = fonts/,
        %Extension = .ttf,
        %BoldFont = *-Bold,
        %ItalicFont = *,
        %ItalicFeatures = FakeSlant,
        %BoldItalicFont = *-Bold,
        %BoldItalicFeatures = FakeSlant
        Ligatures=TeX,
        BoldFont = Tahoma Bold
    ]{Tahoma}
    \setmonofont[
        %Path = fonts/,
        %Extension = .ttf,
        %UprightFont = *MT,
        %BoldFont = *-BoldMT,
        %ItalicFont = *-ItalicMT,
        %BoldItalicFont = *-BoldItalicMT
        BoldFont = Courier New Bold,
        ItalicFont = {Courier New Italic},
        BoldItalicFont = {Courier New Bold Italic}
    ]{Courier New}
    \setmathfont{Cambria Math}

3. Chapter2.tex: \bm changed to \mathbf
\begin{equation}
		\label{eq:equation2}
	\begin{aligned}
		%G_{\text{1,}X} &=\bm{G_{x1}}L_\text{front,mid}+\Delta X_{G1}\\
		G_{\text{1,}X} &=\mathbf{G}_{x1}L_\text{front,mid}+\Delta X_{G1}\\
		G_{\text{1,}Y} &=G_{\text{1,}y}\left(\frac{w_\text{fuse}}{2}-R_\text{spinner} \right)\\
		G_{\text{1,}Z} &=G_{\text{1,}z}\Delta Z_\text{prop}
	\end{aligned}
\end{equation}
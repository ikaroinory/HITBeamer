%----------------------------------------------------------------------------------------------------%
%
% HITBeamer
%     -- A beamer class for HIT
%
%----------------------------------------------------------------------------------------------------%

%----------------------------------------------------------------------------------------------------%
%
% -> Class Clarification
%
%----------------------------------------------------------------------------------------------------%
\NeedsTeXFormat{LaTeX2e}

\ProvidesClass{HITBeamer}[2024/12/12 v1.0 A beamer class for HIT]

%----------------------------------------------------------------------------------------------------%
%
% -> Options
%
%----------------------------------------------------------------------------------------------------%
\RequirePackage{ifthen}

\def\bool@hideNav{false}
\DeclareOption{hideNav}{\def\bool@hideNav{true}}

\def\bool@computing{false}
\DeclareOption{computing}{\def\bool@computing{true}}

\def\bool@en{false}
\DeclareOption{en}{
    \def\bool@en{true}
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbeamer}}
\ProcessOptions\relax

\LoadClass{ctexbeamer}

\ifthenelse{\equal{\bool@hideNav}{true}}{\setbeamertemplate{navigation symbols}{}}{}

%----------------------------------------------------------------------------------------------------%
%
% -> Require Packages
%
%----------------------------------------------------------------------------------------------------%
\RequirePackage{tikz}
\RequirePackage{float}
\RequirePackage{graphicx}

% Table
\RequirePackage{booktabs}
\RequirePackage{makecell}
\RequirePackage{multirow}

% Figure
\RequirePackage{subcaption}

% Algorithm
\RequirePackage{algorithm}
\RequirePackage{algorithmicx}
\RequirePackage{algpseudocode}

% Math
\RequirePackage{bm}

% Caption
\RequirePackage{caption}

%----------------------------------------------------------------------------------------------------%
%
% -> Global variables
%
%----------------------------------------------------------------------------------------------------%
\gdef\global@title{Unknown}
\gdef\global@author{Unknown}
\gdef\global@institute{Unknown}
\gdef\global@supervisor{Unknown}
\gdef\global@reportYear{\the\year}
\gdef\global@reportMonth{\the\month}
\gdef\global@reportDay{\the\day}
\gdef\global@authorPrefix{}
\NewDocumentCommand{\authorPrefix}{m}{\gdef\global@authorPrefix{#1}}
\gdef\global@supervisorPrefix{}
\NewDocumentCommand{\supervisorPrefix}{m}{\gdef\global@supervisorPrefix{#1}}

\newcommand{\command@englishmonthshort}[1]{%
    \ifcase#1%
        \PackageError{HITBeamer}{The range of months is from 1 to 12}{}
    \or%
        Jan.%
    \or%
        Feb.%
    \or%
        Mar.%
    \or%
        Apr.%
    \or%
        May%
    \or%
        Jun.
    \or%
        Jul.%
    \or%
        Aug.%
    \or%
        Sep.%
    \or%
        Oct.%
    \or%
        Nov.%
    \or%
        Dec.%
    \else%
        \PackageError{HITBeamer}{The range of months is from 1 to 12}{}
    \fi%
}

\gdef\global@reportDate{%
    \ifthenelse{\equal{\bool@en}{true}}{%
        \command@englishmonthshort{\global@reportMonth} \global@reportDay, \global@reportYear
    }{%
        \global@reportYear 年\global@reportMonth 月\global@reportDay 日%
    }%
}

%----------------------------------------------------------------------------------------------------%
%
% -> Caption
%
%----------------------------------------------------------------------------------------------------%
\ifthenelse{\equal{\bool@en}{true}}{
    \captionsetup[figure]{labelfont={bf}, labelformat={default}, labelsep=period, name={Figure}}
    \captionsetup[table]{labelfont={bf}, labelformat={default}, labelsep=period, name={Table}}
}{}

%----------------------------------------------------------------------------------------------------%
%
% -> Colors
%
%----------------------------------------------------------------------------------------------------%
\definecolor{hit}{RGB}{0,102,142}

\setbeamercolor{structure}{fg=hit}
\setbeamercolor{palette primary}{use=structure,fg=white,bg=structure.fg}
\setbeamercolor{palette secondary}{use=structure,fg=white,bg=structure.fg!75!black}
\setbeamercolor{palette tertiary}{use=structure,fg=white,bg=structure.fg!50!black}
\setbeamercolor{palette quaternary}{fg=white,bg=structure.fg!50!black}

\setbeamercolor{title}{bg=hit}
\setbeamercolor{frametitle}{bg=hit,fg=white}
\setbeamercolor{titlelike}{parent=palette primary}

\setbeamercolor{footline}{bg=hit}

\setbeamercolor{block title}{bg=hit,fg=white}
\setbeamercolor*{block title example}{use={normal text,example text},bg=white,fg=hit}
\setbeamercolor{fine separation line}{}
\setbeamercolor{item projected}{fg=white}
\setbeamercolor{palette sidebar primary}{use=normal text,fg=normal text.fg}
\setbeamercolor{palette sidebar quaternary}{use=structure,fg=structure.fg}
\setbeamercolor{palette sidebar secondary}{use=structure,fg=structure.fg}
\setbeamercolor{palette sidebar tertiary}{use=normal text,fg=normal text.fg}
\setbeamercolor{section in sidebar}{fg=brown}
\setbeamercolor{section in sidebar shaded}{fg=grey}

\setbeamercolor{separation line}{}
\setbeamercolor{sidebar}{bg=hit}
\setbeamercolor{sidebar}{parent=palette primary}
\setbeamercolor{subsection in sidebar}{fg=brown}
\setbeamercolor{subsection in sidebar shaded}{fg=grey}

%----------------------------------------------------------------------------------------------------%
%
% -> Fonts
%
%----------------------------------------------------------------------------------------------------%
% \usefonttheme{serif}
\setCJKmainfont[AutoFakeBold]{STKaiti}
\setCJKsansfont[AutoFakeBold]{STKaiti}
\setsansfont{Times New Roman}

\setbeamerfont{title}{family=\kaishu, series=\bfseries}
\setbeamerfont{author}{family=\kaishu}
\setbeamerfont{institute}{family=\kaishu}
\setbeamerfont{date}{parent=institute}

\setbeamerfont{frametitle}{family=\kaishu, size=\large}

\setbeamerfont{block title}{family=\kaishu}

\setbeamerfont{headline}{family=\kaishu}

\setbeamerfont{caption}{size=\tiny}

\usefonttheme[onlymath]{serif}

%----------------------------------------------------------------------------------------------------%
%
% -> Commands
%
%----------------------------------------------------------------------------------------------------%
\let\old@title\title
\RenewDocumentCommand{\title}{m}{
    \gdef\global@title{#1}
    \old@title{\global@title}
}

\let\old@author\author
\RenewDocumentCommand{\author}{m}{
    \gdef\global@author{#1}
    \old@author{\global@author}
}

\let\old@institute\institute
\RenewDocumentCommand{\institute}{m}{
    \gdef\global@institute{#1}
    \old@institute{\global@institute}
}

\NewDocumentCommand{\supervisor}{m}{
    \gdef\global@supervisor{#1}
}

\NewDocumentCommand{\reportYear}{m}{
    \gdef\global@reportYear{#1}
}
\NewDocumentCommand{\reportMonth}{m}{
    \gdef\global@reportMonth{#1}
}
\NewDocumentCommand{\reportDay}{m}{
    \gdef\global@reportDay{#1}
}
\NewDocumentCommand{\reportDate}{mmm}{
    \reportYear{#1}
    \reportMonth{#2}
    \reportDay{#3}
}

\NewDocumentCommand{\cover}{}{
    \begin{frame}
        \titlepage
    \end{frame}
}

\NewDocumentCommand{\toc}{}{
    \begin{frame}
        \tableofcontents[
            sectionstyle       = show,
            subsectionstyle    = show/shaded/hide,
            subsubsectionstyle = show/shaded/hide
        ]
    \end{frame}
}

\NewDocumentCommand{\endpage}{O{hide}m}{
    \begin{frame}
        \centering\huge
        #2%

        \ifthenelse{\equal{#1}{show}}{
            \par\large
            \vspace*{2em}
            \global@authorPrefix\ifthenelse{\equal{\global@authorPrefix}{}}{}{\ifthenelse{\equal{\bool@en}{true}}{: }{：}}\global@author
            \ifthenelse{\equal{\global@supervisor}{Unknown}}
            {}{%
                \quad\global@supervisorPrefix\ifthenelse{\equal{\global@supervisorPrefix}{}}{}{\ifthenelse{\equal{\bool@en}{true}}{: }{：}}\global@supervisor%
            }
        }{}
        \vskip2em
        {\usebeamercolor[fg]{titlegraphic}\inserttitlegraphic\par}
    \end{frame}
}

%----------------------------------------------------------------------------------------------------%
%
% -> Algorithms
%
%----------------------------------------------------------------------------------------------------%
\captionsetup[algorithm]{
	format   = plain,
	labelsep = quad,
	position = top
}
\RenewDocumentCommand{\algorithmicrequire}{}{\ifthenelse{\equal{\bool@en}{true}}{\textbf{Input: }}{\textbf{输入：}}}
\RenewDocumentCommand{\algorithmicensure}{}{\ifthenelse{\equal{\bool@en}{true}}{\textbf{Output: }}{\textbf{输出：}}}

%----------------------------------------------------------------------------------------------------%
%
% -> Template Settings
%
%----------------------------------------------------------------------------------------------------%
\titlegraphic{%
    \includegraphics[height = 1cm]{asserts/HIT.png}%
    \ifthenelse{\equal{\bool@computing}{true}}{\hspace{1ex}\includegraphics[height = 1cm]{asserts/Computing.png}}{}%
}

\useoutertheme[footline=authorinstitutetitle,subsection=false]{smoothbars}
\useinnertheme{circles}

\setbeamertemplate{title page}{\ignorespaces
    \vbox{}
    \begingroup{
        \centering
        % {\usebeamercolor[fg]{titlegraphic}\inserttitlegraphic\par}\vskip1em
        \begin{beamercolorbox}[sep=8pt, center]{title}\ignorespaces
            \usebeamerfont{title}\inserttitle\par
            \ifx\insertsubtitle\@empty
            \else
                \vskip0.25em
                {\usebeamerfont{subtitle}\usebeamercolor[fg]{subtitle}\insertsubtitle\par}
            \fi
        \end{beamercolorbox}
        \vskip1em\par
        \begin{beamercolorbox}[sep=8pt, center]{author}
            \usebeamerfont{author}%
            \global@authorPrefix\ifthenelse{\equal{\global@authorPrefix}{}}{}{\ifthenelse{\equal{\bool@en}{true}}{: }{：}}\global@author
            \ifthenelse{\equal{\global@supervisor}{Unknown}}
            {}{%
                \quad\global@supervisorPrefix\ifthenelse{\equal{\global@supervisorPrefix}{}}{}{\ifthenelse{\equal{\bool@en}{true}}{: }{：}}\global@supervisor%
            }
        \end{beamercolorbox}
        \begin{beamercolorbox}[sep=8pt, center]{institute}
            \usebeamerfont{institute}\global@institute
        \end{beamercolorbox}
        \begin{beamercolorbox}[sep=8pt, center]{date}
            \usebeamerfont{date}\global@reportDate
        \end{beamercolorbox}
        \vskip1em
        {\usebeamercolor[fg]{titlegraphic}\inserttitlegraphic\par}
    }\endgroup
    \vfill
}

\setbeamertemplate{footline}{\ignorespaces
    \begin{beamercolorbox}[colsep=1.5pt]{upper separation line foot}\kaishu
    \end{beamercolorbox}

    \begin{beamercolorbox}[ht=2.5ex,dp=1.125ex,
      leftskip=.3cm,rightskip=.3cm plus1fil]{author in head/foot}
      \leavevmode{\usebeamerfont{author in head/foot}\kaishu\insertshortauthor}
      \hfill
      {\usebeamerfont{institute in head/foot}\usebeamercolor[fg]{institute in head/foot}\kaishu\insertshortinstitute}
    \end{beamercolorbox}

    \begin{beamercolorbox}[ht=2.5ex,dp=1.125ex,
      leftskip=.3cm,rightskip=.3cm plus1fil]{title in head/foot}
      {\usebeamerfont{title in head/foot}\kaishu\insertshorttitle}
      \hfill
      {\usebeamerfont{frame number}\usebeamercolor[fg]{frame number}\insertframenumber~/~\inserttotalframenumber}
    \end{beamercolorbox}
    
    \begin{beamercolorbox}[colsep=1.5pt]{lower separation line foot}
    \end{beamercolorbox}
}

\setbeamertemplate{bibliography item}[text]
\setbeamertemplate{caption}[numbered]

%----------------------------------------------------------------------------------------------------%
%
% -> Others
%
%----------------------------------------------------------------------------------------------------%
\AtBeginSection[]{
	\begin{frame}
		\tableofcontents[sectionstyle=show/shaded,subsectionstyle=show/shaded/hide,subsubsectionstyle=show/shaded/hide]
	\end{frame}
}
\AtBeginSubsection[]{
	\begin{frame}
		\tableofcontents[sectionstyle=show/shaded,subsectionstyle=show/shaded/hide,subsubsectionstyle=show/shaded/hide]
	\end{frame}
}

%%-----------------------------------------------------------------------------
%% rapportPFE.cls --
%% Style de rapport pour un PFE du département IF de l'INSA Lyon.
%% Auteur : Philippe Lamarre (Philippe.Lamarre@insa-lyon.fr)
%% Style basé sur 'report.cls'
%% Version 1.0 - rapport français
%% Version 1.1 - rapport au choix en français ou en anglais
%% Version 1.2 - logo de la structure d'accueil, ajout d'options de document : R&D et Confidentiel
%%-----------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}
\def\versionnumber@RapportPFE{1.1}
\def\version@packageRapportPFE{2019/10/29 \versionnumber@RapportPFE}
\ProvidesClass{rapportPFE}
              [\version@packageRapportPFE]
\typeout{Style pour un rapport de Projet de Fin d'Etudes du département IF de l'INSA Lyon}
\typeout{ }

\newif\iffrancais
\francaistrue

\newif\ifinit
\initfalse

\newif\ifRandD
\RandDfalse

\newif\ifconfidential
\confidentialfalse

\newif\iflogoStructureAccueil
\logoStructureAccueilfalse

\newcommand{\@vf}[2]{\iffrancais{#1}\else{#2}\fi}
\newcommand{\@init}[2]{\ifinit{#1}\else{#2}\fi}
% traitement des options
\newcommand{\@mainLanguage}{french}
\newcommand{\@otherLanguage}{english}
\DeclareOption{init}{
\inittrue
}
\DeclareOption{francais}{}
\DeclareOption{english}{%
\francaisfalse%
\renewcommand{\@mainLanguage}{english}%
\renewcommand{\@otherLanguage}{french}%
}
\DeclareOption{RandD}{\RandDtrue}
\DeclareOption{Confidential}{\confidentialtrue}
\DeclareOption{Confidentiel}{\confidentialtrue}

% Obligation de rester en a4, 12pt et twosides. Du coup, on ne passe pas les options à la classe dont on hérite
%DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

% Classe de base 
\LoadClass[a4paper,12pt,twoside]{article}
\RequirePackage[2020-02-02]{latexrelease} % Ajouté le 09/03/2022
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage[width=17cm, left=2.5cm]{geometry}
%\RequirePackage{fancyvrb}
%\RequirePackage{fancyhdr}
\iffrancais
\RequirePackage[french,english]{babel}
\else
\RequirePackage[english]{babel}
\fi
\RequirePackage{hyperref}
\RequirePackage{graphicx}
\RequirePackage{amsthm}

\RequirePackage{xcolor}
\ifconfidential
\RequirePackage{xwatermark}
\iffrancais
\newwatermark[firstpage,textalign=center,fontfamily=pbk,angle=55,scale=2.75,xpos=-1cm,ypos=1cm,color=lightgray]{Confidentiel}
\newwatermark[lastpage,textalign=center,fontfamily=pbk,angle=55,scale=2.75,xpos=-1cm,ypos=1cm,color=lightgray]{Confidentiel}
\else
\newwatermark[firstpage,textalign=center,fontfamily=pbk,angle=55,scale=2.75,xpos=-1cm,ypos=1cm,color=lightgray]{Confidential}
\newwatermark[lastpage,textalign=center,fontfamily=pbk,angle=55,scale=2.75,xpos=-1cm,ypos=1cm,color=lightgray]{Confidential}
\fi
\fi



% Informations administratives du PFE
\newcommand{\dateDebutPFE}[1]{\gdef\@dateDebutPFE{#1}}
\newcommand{\dateFinPFE}[1]{\gdef\@dateFinPFE{#1}}
\newcommand{\nomStructureAcceuil}[1]{\gdef\@nomStructureAcceuil{#1}}
\newcommand{\villeStructureAccuel}[1]{\gdef\@villeStructureAccuel{#1}}
% Logo de la structure d'accueil
\newcommand{\logoStructureAccueil}[2]{\logoStructureAccueiltrue\gdef\@logoStructureAccueil{\includegraphics[#1]{#2}}}

% Encadrants 
\newbox{\@encadrantsBox}
\newsavebox{\@encadrantsBoxA}
\newif\if@encadrantsPresent
\@encadrantsPresentfalse
\def\@inconnu{\hbox to 3cm{\hrulefill}}
\def\@tuteurPFE{\@inconnu}
\def\@referentPFE{\@inconnu}


\newenvironment{encadrants}{%
    \global\@encadrantsPresenttrue%
    \def\tuteur##1##2##3##4{\hbox to 2.6cm{##1\hss :}%
      & ##2, ##3 \vspace*{0.05cm}& ##4 \vspace*{0.05cm}\\}%
    \def\referent##1##2##3##4{\hbox to 2.6cm{##1\hss :}%
      & ##2, ##3 \vspace*{0.05cm}& ##4 \vspace*{0.05cm}\\}%
  \begin{lrbox}{\@encadrantsBoxA}%
		\begin{tabular}{lll}%
       }{\end{tabular}\end{lrbox}%
\global\setbox\@encadrantsBox=\vbox{\copy\@encadrantsBoxA}}


\newcommand{\encadrantsDefaut}{%
  \def\referent##1{\gdef\@referentPFE{##1}}%
  \def\tuteur##1{\gdef\@tuteurPFE{##1}}%
  \begin{lrbox}{\@encadrantsBoxA}%
    \begin{tabular}{lll}%
      \hbox to 2.5cm{\tuteurname\hss :} & \@tuteurPFE &\@inconnu\\%
      \if\@referentPFE\@inconnu \referent{\@inconnu}\fi%
    \end{tabular}\end{lrbox}%
  \global\setbox\@encadrantsBox=\vbox{\copy\@encadrantsBoxA}}


% Page de résumé et de mots-clés
\let\@keywords=\@empty
\let\@motscles=\@empty
\newcommand{\keywords}[1]{\gdef\@keywords{#1}}
\newcommand{\motscles}[1]{\gdef\@motscles{#1}}
\newbox{\resumeFr@pageDeux}
\newbox{\resumeEn@pageDeux}

\newenvironment{ResumeMotsCles}{
  }{
}

\newsavebox{\resumeFr@pageResume} % Sauvegarde du résumé pour la 4e de couverture.
\newsavebox{\resumeEn@pageResume}

\newlength{\resumeEnwidth}
\setlength{\resumeEnwidth}{\textwidth}
\newlength{\abs@width}
\setlength{\abs@width}{\textwidth}
\addtolength{\abs@width}{-15\p@}
\newenvironment{resumeEn}{%
  \begin{lrbox}{\resumeEn@pageResume}%
    \begin{minipage}{\abs@width}%
      \begin{center}%
        {\large\bfseries Abstract}\par\vspace{.4cm}%
        \begin{minipage}{\resumeEnwidth}}%
        {\end{minipage}%
      \end{center}%
    \end{minipage}%
  \end{lrbox}%
  \global\setbox\resumeEn@pageDeux=\vbox{\copy\resumeEn@pageResume}}%
\newenvironment{resumeFr}{%
  \begin{lrbox}{\resumeFr@pageResume}%
    \begin{minipage}{\abs@width}%
      \begin{center}%
        {\large\bfseries Résumé}\par\vspace{.4cm}%
        \begin{minipage}{\resumeEnwidth}}%
        {\end{minipage}%
      \end{center}%
    \end{minipage}%
  \end{lrbox}%
  \global\setbox\resumeFr@pageDeux=\vbox{\copy\resumeFr@pageResume}}



% Remerciements
\newcommand{\acknowledgementname}{Remerciements}
%\newcommand{\acknowledgementname}{}
\newenvironment{remerciements}{%
  \thispagestyle{empty}%
  \section*{\acknowledgementname}}
  {\vfill%
  \cleardoublepage%
  }
  


\newcommand\ResumesMotsCles{%
  \clearpage%
  \thispagestyle{empty}\mbox{ }\clearpage%
  \pagestyle{empty}%
  \begin{center}%
    \begin{minipage}{15cm}%
      \begin{center}%
        {\fontsize{18pt}{22pt}\selectfont\bfseries%
          \def\\{}\@vf{\@titre}{\@title}}\\[0.5cm]%
        {\Large\@firstname\ \IFmiddlename \@lastname}%
      \end{center}%
    \end{minipage}%
   \iffrancais% version française : le résumé français en premier
    \par\vspace{1cm}%
    \begin{minipage}{\abs@width}%
      \begin{center}%
        \vfill%
        \noindent\unvcopy\resumeFr@pageDeux%
        \ifx\@motscles\@empty\else%
        \smallskip%
        \begin{flushleft}%
          \noindent\textbf{Mots-cl\'es :} \@motscles%
        \end{flushleft}%
        \fi%
        \par\vspace{1.5cm}%
        \noindent\unvcopy\resumeEn@pageDeux%
        \ifx\@keywords\@empty\else%
        \smallskip%
        \begin{flushleft}%
          \noindent\textbf{Keywords:} \@keywords%
        \end{flushleft}%
        \fi%
      \end{center}%
    \end{minipage}%
    \else% version anglaise en premier le résumé en anglais
    \par\vspace{1cm}%
    \begin{minipage}{\abs@width}%
      \begin{center}%
        \vfill%
        \noindent\unvcopy\resumeEn@pageDeux%
        \ifx\@keywords\@empty\else%
        \smallskip%
        \begin{flushleft}%
          \noindent\textbf{Keywords:} \@keywords%
        \end{flushleft}%
        \fi%
        \par\vspace{1.5cm}%
        \noindent\unvcopy\resumeFr@pageDeux%
        \ifx\@motscles\@empty\else%
        \smallskip%
        \begin{flushleft}%
          \noindent\textbf{Mots-cl\'es :} \@motscles%
        \end{flushleft}%
        \fi%
      \end{center}%
    \end{minipage}%

    \fi%
  \end{center}%
  }


% commencer sur une page impaire
\newcommand{\clearemptydoublepage}%
{\newpage{\pagestyle{empty}\cleardoublepage}}



% Mise en forme d'un nom propre
\newcommand{\Nom}[1]{\index{#1@\textsc{#1}}{\textsc{#1}}}
\newcommand{\System}[1]{\index{#1@\textsc{\textsf{#1}}}\textsf{{\textsf{#1}}}}


% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Création de la page de garde
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\renewcommand\maketitle {%
    \begin{titlepage}%
    \vspace*{-2cm}\hspace{-2cm}\includegraphics[width=6cm]{insa}\iflogoStructureAccueil\hfill\@logoStructureAccueil\fi\vspace*{2cm}%
      \begin{center}%
        {\fontsize{14pt}{18pt}\selectfont%
          INSA Lyon - Département Informatique%
        }\\%
        \vspace{0.4cm}%
        \rule{3cm}{1pt}%
      \end{center}%
        \vspace{0.3cm}%
      \begin{center}%
        \fontsize{14pt}{15pt}\selectfont%
        {\bfseries \@init{\@vf{Dossier d'initialisation}{Start-up Report}}{\@vf{Rapport}{Report}}}\\[.3cm]%
        \@vf{de}{of the}\\ [.3cm]%
        {\bfseries \@vf{PROJET DE FIN D'ÉTUDES}{Graduation Project}}\\%
      \begin{center}%
        \vspace{0.5cm}%
                 \usefont{T1}{phv}{b}{n}\fontsize{18pt}{18pt}\selectfont%
            \@vf{\@titre}{\@title}\par%
                  \rule{3cm}{.1mm}\par%
      \vspace*{.25cm}%
      \textit{\@vf{\@title}{\@titre}} \par%
        \vspace{0.3cm}%
        \rule{3cm}{1pt}%
      \end{center}%
        \vspace{.5cm}%
{\fontsize{16pt}{18pt}\selectfont\bfseries\fontfamily{phv}\selectfont%
          \@firstname\ \IFmiddlename \@lastname}\\%
        \vspace{.5cm}%
        {\itshape%
         \@init{ \rule{3cm}{1pt}}{\@vf{Soutenance le}{Defended} \@date}\\[.3cm]}%
        \vspace{.5cm}%
		\@vf{Projet réalisé du}{Project conducted from} \textbf{\@dateDebutPFE} \@vf{au}{to} \textbf{\@dateFinPFE}\\%
        \vspace{.5cm}%
        		\@vf{dans la structure d'accueil}{within the reception structure}\\
        \vspace{.5cm}%
		 \textbf{\@nomStructureAcceuil} (\@villeStructureAccuel)%
      \end{center}%
  \vspace{\fill}%
  \if@encadrantsPresent%
  \else%
     \encadrantsDefaut%
  \fi%
  \vbox{\unvcopy\@encadrantsBox}%
 \end{titlepage}%
    \voffset=-.3cm%
	\newpage\thispagestyle{empty}%
	\strut%
    \newpage%
  \setcounter{footnote}{0}%
  \global\let\thanks\relax%
  \global\let\maketitle\relax%
  \global\let\@thanks\@empty%
  \global\let\@date\@empty%
  \global\let\title\relax%
  \global\let\date\relax%
  \global\let\and\relax%
}


% table des matières avec une numérotation spéciale
\let\oldtableofcontents\tableofcontents
\renewcommand{\tableofcontents}{\pagenumbering{roman}\oldtableofcontents\cleardoublepage\pagenumbering{arabic}\setcounter{page}{1}}

% insertion de la section référence dans la table des matières
\let\oldbibliography\bibliography
\renewcommand{\bibliography}[1]{\oldbibliography{#1}\addcontentsline{toc}{section}{References bibliographiques}
}

% mise en place d'annexes
\let\oldappendix\appendix
\renewcommand{\appendix}{\cleardoublepage\oldappendix\makeatletter%
\def\@seccntformat##1{\@vf{Annexe}{Annex}~\csname the##1\endcsname:\quad}%
\makeatother
\begin{center}
\begin{huge}
Annexes
\end{huge}
\addtocontents{toc}{{\protect\centering\itshape\vspace*{3cm} Annexes\par}}
\end{center}
\vspace{4cm}
}

\AtBeginDocument{
      }%

\def\lastpage@putlabel{\addtocounter{page}{-1}%
   \immediate\write\@auxout{\string%
   \newlabel{last@page}{{}{\thepage}}{}{}{}}%
   \addtocounter{page}{1}%
   }

\AtEndDocument{%
  \clearemptydoublepage%
  \ResumesMotsCles%
  \clearpage%
}



\def\@titre{\ClassError{rapportPFE}{Il manque le titre en français}{
    Utilisez la macro \noexpand\titre}}
\def\@title{\ClassError{rapportPFE}{Il manque le titre en anglais}{
    Utilisez la macro \noexpand\title}}
\def\titre#1{\gdef\@titre{#1\ifRandD~[R\&D]\fi}}
\def\title#1{\gdef\@title{#1\ifRandD~[R\&D]\fi}}

\def\@firstname{\ClassError{RapportPFE}{Il manque le prenom de l'auteur}{Utilisez la macro \string\firstname}}
\def\@middlename{.}
\def\IFmiddlename{\if\@middlename.\else\@middlename\ \fi}
\def\@lastname{\ClassError{RapportPFE}{Il manque lenom de l'auteur}{Utilisez la macro \string\lastname}}
\def\firstname#1{\gdef\@firstname{#1}}
\def\middlename#1{\gdef\@middlename{#1}}
\def\lastname#1{\gdef\@lastname{\MakeUppercase{#1}}}



% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Quelques environnements 
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\theoremstyle{definition}
\newtheorem{Definition}{\@vf{D\'efinition}{Definition}}
\theoremstyle{plain}
\newtheorem{Theorem}{\@vf{Th\'eor\`eme}{Theorem}}
\newtheorem{Lemma}{Lemme}
\newtheorem{Proposition}{Proposition}
\newtheorem{Corollary}{Corollaire}



\endinput

%%% Local Variables: 
%%% mode: latex
%%% TeX-master: t
%%% End: 

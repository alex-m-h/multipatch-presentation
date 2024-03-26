
%% This is file `ipp-poster.cls' version 2.6 (2023/03/21),
%% it is part of IPP-bundle
%% Beamer-slides and tcolorbox-posters for IPP
%% ----------------------------------------------------------------------------
%%
%%  Copyright (C) 2020–2023 by Marei Peischl <marei@peitex.de>
%%
%% ============================================================================
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3c
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%% http://www.latex-project.org/lppl.txt
%% and version 1.3c or later is part of all distributions of LaTeX
%% version 2008/05/04 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%%
%% Thecurrent maintainer of this work is
%%   Marei Peischl <marei@peitex.de>
%%
%% ============================================================================
%%
\NeedsTeXFormat{LaTeX2e}
\RequirePackage{expl3}
\ProvidesExplPackage{ipp-poster}{2022/08/05}{2.3}{Scientific Poster Layout for IPP}

\RequirePackage{l3keys2e}
\RequirePackage{graphicx}
\RequirePackage[cmyk]{mpg-colors}

\prop_new:N \g_IPP_clsopts_prop
\tl_new:N \g_IPP_boxstyle_tl
\int_new:N \g_IPP_paper_int

\newif\if@IPP@eurofusion

\newsavebox\IPP@subinst@box

\box_new:N \l_ptxcd_machine_logo_box
\box_new:N \l_ptxcd_headline_logo_box

\tl_new:N \g_IPP_logo_tl
\tl_new:N \g__ptxcd_machine_logo_tl
\clist_new:N \g__ptxcd_headlinelogo_clist
\tl_new:N \g_IPP_logosuffix_tl

\keys_define:nn {IPP/poster} {
	unknown .code:n = {\prop_gput:NVn \g_IPP_clsopts_prop \l_keys_key_tl {#1}},
	fontsize .tl_gset:N = \g_IPP_fontsize_tl,
	fontsize .initial:n = 26bp,
	logofile .tl_gset:N = \g_IPP_logofile_tl,
	logofile .initial:n = MPI_PP_Logo_Vertical_cmyk-crop,
	logo .meta:n = {headlinelogos=,selectlogo = #1},
	selectlogo .choices:nn = {asdex,w7x} {
		\tl_gset_eq:NN  \g__ptxcd_machine_logo_tl \l_keys_choice_tl
		\tl_gset:Nn \g_IPP_logosuffix_tl {_green}
		\cs_if_exist_use:NT \__ptxcd_setup_headline_logo:NV {\l_ptxcd_machine_logo_box  \g__ptxcd_machine_logo_tl}
	},
	selectlogo / hepp .code:n = {\msg_warning:nnn  {ipp} {logo-replaced/removed}  {hepp}},
	selectlogo / false .meta:n = {selectlogo=},
	selectlogo / unknown .code:n = {
		\tl_gset:Nn \g__ptxcd_machine_logo_tl {#1}
		\tl_gclear:N \g_IPP_logosuffix_tl
		\cs_if_exist_use:NT \__ptxcd_setup_headline_logo:NV {\l_ptxcd_machine_logo_box  \g__ptxcd_machine_logo_tl}
	},
	headlinelogos .code:n = {
		\clist_gset:Nn \g__ptxcd_headlinelogo_clist {#1}
		\cs_if_exist_use:NT \__ptxcd_setup_headline_logo:NV {\l_ptxcd_headline_logo_box  \g__ptxcd_headlinelogo_clist}
	},
	eurofusion .code:n = \use:c{@IPP@eurofusion#1},
	eurofusion .default:n = true,
	eurofusion .initial:n = true,
	paper .code:n = \PassOptionsToPackage{paper=#1}{geometry},
	paper .initial:n = a0paper,
	papersize .code:n = \PassOptionsToPackage{papersize=#1}{geometry},
	paperheight .code:n = \PassOptionsToPackage{paperheight=#1}{geometry},
	paperwidth .code:n = \PassOptionsToPackage{paperwidth=#1}{geometry},
	margin .dim_gset:N =  \g_IPP_margin_dim,
	margin .initial:n = 20mm,
	footerheight .dim_gset:N = \g_IPP_footerheight_dim,
	footerheight .initial:n = 30mm,
}

\ProcessKeysOptions{IPP/poster}

\newcommand*{\IPPposterSetup}[1]{\keys_set:nn {IPP/poster} {#1}}
\newcommand*{\setHeadlineLogos}[1]{\keys_set:nn {IPP/poster}{headlinelogos={#1}}}

\tl_new:N \g_IPP_footnote_label_tl
\tl_gset:Nn \g_IPP_footnote_label_tl {arabic*}

\prop_gput:NnV \g_IPP_clsopts_prop {fontsize} \g_IPP_fontsize_tl



\prop_map_inline:Nn \g_IPP_clsopts_prop {
	\tl_if_empty:nTF {#2}
	{\exp_args:NnV\PassOptionsToClass{#1}\l_tmpa_tl}
	{\clist_map_inline:nn {#2} {\PassOptionsToClass{#1=##1}{scrartcl}}}
}



\ExplSyntaxOff
\LoadClass[parskip=half-]{scrartcl}
\RequirePackage{tikz}
\usetikzlibrary{calc}
\RequirePackage{tcolorbox}
\tcbuselibrary{poster}

%font setup
\RequirePackage{iftex}

\RequirePackage{anyfontsize}
\ExplSyntaxOn

\usepackage{merriweather}
\RequirePackage{mpg-fonts}

\PassOptionsToPackage{margin=\g_IPP_margin_dim}{geometry}
\RequirePackage{geometry}


%Font adjusments
\renewcommand*{\familydefault}{\sfdefault}

\setkomafont{disposition}{\bfseries}

\setkomafont{title}{
	\color{titlefgcolor}
	\fontsize{80bp}{96bp}\selectfont
	\bfseries
}

\setkomafont{section}{
	\fontsize{42bp}{51bp}\selectfont
}

\RedeclareSectionCommand[afterskip=1sp]{section}


\setkomafont{pageheadfoot}{
	\small
}

\setkomafont{publishers}{
	\fontsize{44bp}{49bp}\selectfont
}

\setkomafont{author}{\normalcolor\fontsize{32bp}{38bp}\selectfont}
\setkomafont{captionlabel}{\bfseries}




\dim_const:Nn \c_IPP_rule_dim {1mm}

\tl_new:N \g_IPP_thanks_tl
\newcommand*{\IPP@title@footnote}[2][1]{
	\begingroup
	\IPP_def_footnotelabel:
	\footnotemark[#1]\,#2\quad
	\endgroup
}

\tl_greplace_all:Nnn \g_IPP_footnote_label_tl {*} {{footnote}}
\clist_map_inline:nn {alph, arabic, fnsymbol, Alph, roman, Roman} {
	\tl_greplace_all:Nnn \g_IPP_footnote_label_tl {#1} {\use:c {#1}}
}

\cs_set:Nn \IPP_def_footnotelabel: {
	\renewcommand*{\thefootnote}{\g_IPP_footnote_label_tl}
}

\pagestyle{empty}
\renewcommand*{\title}[1]{\gdef \@title {#1}}

\tl_new:N \g_IPP_poster_foot_tl

\newcommand{\footer}[1]{
	\tl_gset:Nn \g_IPP_poster_foot_tl {#1}
}

\box_new:N \g_IPP_footergraphics_box
\newcommand*{\footergraphics}[1]{
	\begingroup
	\let\height\g_IPP_footerheight_dim
	\hbox_gset:Nn \g_IPP_footergraphics_box {#1}
	\endgroup
}

%redefine \author to manage \and and \thanks
\seq_new:N \g_IPP_author_seq

\renewcommand*\author[1]{
	\seq_gset_split:Nnn \g_IPP_author_seq {\and} {#1}
}

\renewcommand*{\@author}{
	\seq_use:Nn \g_IPP_author_seq {,~}
}

\seq_new:N \g_IPP_institute_seq
\newcommand*{\institute}[1]{
	\seq_gset_split:Nnn \g_IPP_institute_seq {\and} {#1}}
\newcommand*{\@institute}{
	\seq_use:Nn \g_IPP_institute_seq {,~}
}


\newcommand*{\inst}[1]{
	\clist_set:Nn \l_tmpa_clist {#1}
	\clist_pop:NN \l_tmpa_clist \l_tmpa_tl
	\footnotemark[\l_tmpa_tl]
	\clist_map_inline:Nn \l_tmpa_clist {\textsuperscript{,}\footnotemark[##1]}
}

\seq_new:N  \g_IPP_contact_address_seq
\newcommand*{\contact}[1]{
	\@contactaddressmark
	\seq_gput_right:Nn  \g_IPP_contact_address_seq {#1}
}

\int_new:N \g_IPP_contact_address_int
\def\@contactaddressmark{
	\int_gincr:N \g_IPP_contact_address_int
	\protected@xdef\@thefnmark{\@fnsymbol\g_IPP_contact_address_int}\@footnotemark
}
\newcommand*{\contactaddressname}{Corresponding~author\int_compare:nT {\seq_count:N  \g_IPP_contact_address_seq > 1} {s}}
\newcommand*{\contactaddresssep}{:\space}

\newcommand\titlegraphic[1]{\def\@titlegraphic{#1}}
\titlegraphic{}

\box_new:N \g_IPP_acknowledgement_box
\newcommand{\acknowledgement}[1]{
  \hbox_gset:Nn \g_IPP_acknowledgement_box {
	  \begin{minipage}{
			 \dim_min:nn {.555\linewidth} {.555\textheight}
			}
		\raggedright
		\fontsize{16bp}{22bp}\selectfont
		\if@IPP@eurofusion
		\begingroup
		\hbox_set:Nn \l_tmpa_box {
			\raisebox{\dimexpr-.5\height}{\includegraphics[height=4\baselineskip]{EUROfusion_rgb}}\qquad
			\raisebox{\dimexpr-.5\height}{\includegraphics[height=4\baselineskip]{EU-emblem_rgb}}
		}
		\leavevmode\raisebox{\dimexpr-.5\height+.5\depth}{\box_use:N \l_tmpa_box}\qquad%
		\raisebox{\dimexpr-.5\height+.5\depth}{
			\parbox{\dim_eval:n {\linewidth - \box_wd:N \l_tmpa_box-2em}}{
			\IPP@headerfont\EUROfusionInfo
		}}
		\endgroup%
		\fi
		\tl_if_empty:nF {#1} {\par
		\bigskip
		#1
		}
		\end{minipage}\hspace*{5mm}
	}
	\dim_gset:Nn \g_IPP_footerheight_dim {\dim_max:nn {\box_ht:N \g_IPP_acknowledgement_box + \box_dp:N \g_IPP_acknowledgement_box+3mm} {30mm}}
}

\newlength{\contentwidth}
\setlength{\contentwidth}{\textwidth}
\newlength{\contentheight}

\dim_const:Nn \c_ptxcd_logoheight_dim {92.7mm} %{176mm}
%initialize headline logo
\cs_set:Nn \__ptxcd_setup_headline_logo:Nn {
		\tl_if_blank:nTF {#2}  {
			\box_clear:N #1
		}{
		\bool_set_false:N \l_tmpa_bool
		\hbox_set:Nn #1 {
			\clist_map_inline:nn {#2} {
				\bool_if:NT \l_tmpa_bool {\rule{1ex}{0pt}}
				\bool_set_true:N \l_tmpa_bool
				\file_if_exist:nTF {img/##1\g_IPP_logosuffix_tl.pdf} {\tl_set:Nn \l_tmpa_tl {img/}} {\tl_clear:N \l_tmpa_tl}
				\file_if_exist:nTF {\l_tmpa_tl##1\g_IPP_logosuffix_tl.pdf}
					{\includegraphics[height=.5\c_ptxcd_logoheight_dim]{\l_tmpa_tl##1\g_IPP_logosuffix_tl}}
					{\includegraphics[height=.5\c_ptxcd_logoheight_dim]{##1}}
			}
		}
	}
}

\cs_generate_variant:Nn \__ptxcd_setup_headline_logo:Nn {NV}

\__ptxcd_setup_headline_logo:NV \l_ptxcd_machine_logo_box  \g__ptxcd_machine_logo_tl
\__ptxcd_setup_headline_logo:NV \l_ptxcd_headline_logo_box  \g__ptxcd_headlinelogo_clist

\def\raggedfooter{\raggedright}

\colorlet{poster-base}{MPG_green}
% Background Colors
\colorlet{backgroundcolor}{white}
\colorlet{framecolor}{MPG_green}
\colorlet{titlefgcolor}{MPG_green}
\colorlet{titlebgcolor}{white}
% Block Colors
\colorlet{blocktitlebgcolor}{white}
\colorlet{blocktitlefgcolor}{poster-base}
\colorlet{blockbodybgcolor}{white}
\colorlet{blockbodyfgcolor}{black}
% Innerblock Colors
\colorlet{innerblocktitlebgcolor}{black!15}
\colorlet{innerblocktitlefgcolor}{black}
\colorlet{innerblockbodybgcolor}{white}
\colorlet{innerblockbodyfgcolor}{black}

%%%%%%%%%%%%%%%%%%%%%%
%Declare TCBstyles for ipp-poster
% Unify header spacing
\dim_new:N \g__IPP_top_rule_dim

\dim_new:N \g_IPP_section@afterskip_dim 
\skip_set:Nn \l_tmpa_skip {\scr@section@afterskip}
\dim_gset:Nn \g_IPP_section@afterskip_dim  {\l_tmpa_skip}

%Adjust section to match block header
\renewcommand{\sectionlinesformat}[4]{%
	\@hangfrom{\hskip #2#3}{\__ipp_internal_modify_title:n {#4}}%
}

\cs_new:Nn \__ipp_internal_modify_title:n {\text_uppercase:n {#1}}

\tcbset {
	parbox=false,
	IPP/.style = {
		parbox=false,
		colbacktitle=MPG_grey_light,
		coltitle=MPG_green,
		halign~title=flush~left,
		colback=white,
		coltext=black,
		fonttitle=\usekomafont{disposition}\usekomafont{section}\tl_gset:Nx \kvtcb@title {\exp_not:N \__ipp_internal_modify_title:n {\exp_not:o{\kvtcb@title}}},
		toptitle=.5\g_IPP_section@afterskip_dim,bottomtitle=.5\g_IPP_section@afterskip_dim,	frame~hidden,
		boxrule=\z@,
		left=\z@,right=\z@,
		lefttitle=.4ex,righttitle=.4ex,
		top=\g_IPP_section@afterskip_dim,
	},
	framed/.style = {%compat only
		IPP,
	},
	abstract/.style =
		{
		IPP,
		colbacktitle=MPG_green,
		coltitle=white,
		},
	highlight/.style =
		{
		IPP,
		colback=MPG_#1!20,
		colbacktitle=MPG_#1,
		coltitle=white,
		left=.4ex,right=.4ex,
		},
	highlight/.default=blue_dark,
	conclusion/.style = {abstract},
	section/.code =  {\expandafter\let\csname tcb@parbox@false@indent\endcsname\relax\tcbset{top=0pt}}
}

\dim_new:N \g_IPP_footsepline_dim
\dim_gset:Nn \g_IPP_footsepline_dim {2bp}

\tcbset{
	poster/.cd,
	spacing=20mm
}

\dim_new:N \g_IPP_footer_colsep_dim

\tcbposterset{
	boxes={arc=5mm},
	coverage = {
		spread,
		boxrule=\g_IPP_margin_dim,
		bottomrule=3\g_IPP_margin_dim,
		enhanced,
		title~code={
			\node[inner~sep=2.5mm,inner~ysep=.1\c_ptxcd_logoheight_dim,anchor=north~east] (IPP-logo) at (title.north~east) {\includegraphics[height=\c_ptxcd_logoheight_dim]{\g_IPP_logofile_tl}};
			\node[anchor=east,minimum~height=.5\c_ptxcd_logoheight_dim,inner~sep=0pt](logo) at ([yshift=.2\c_ptxcd_logoheight_dim]IPP-logo.east){
				\box_use:N \l_ptxcd_machine_logo_box\hspace*{.8\c_ptxcd_logoheight_dim}
			};
			\node[anchor=north~east] at (IPP-logo.south~east) {
				\box_use:N \l_ptxcd_headline_logo_box
			};
		},
		toptitle=20mm,
		title=\IPP_poster_titlebox:n {\@title},
		top=\baselineskip,
		bottom=1cm,
		bottom=\g_IPP_footerheight_dim-\g_IPP_margin_dim,
		bottomrule=\g_IPP_footerheight_dim+\g_IPP_margin_dim,
		frame~code={\path[fill=framecolor]
			(frame.north~west) rectangle (title.north~east-|frame.north~east);
		\path[fill=framecolor]
		(frame.south~west) rectangle ++(\paperwidth,1cm);},
		overlay={
		\node[inner~sep=0pt,anchor=north~east] (acknowledgement) at ([yshift=-5mm]interior.south~east) {
			\box_use:N \g_IPP_acknowledgement_box
		};
		\node [anchor=north~west, inner~ sep=\z@] (footergraphics) at (interior.west|-acknowledgement.north) {\box_use:N \g_IPP_footergraphics_box\box_if_empty:NF \g_IPP_footergraphics_box {\hspace*{3mm}}};
		\node [anchor=west, inner~ sep=\z@] at
		(footergraphics.east)
		 {
			\parbox{
				\dim_eval:n {
					\dim_compare:nT {\box_wd:N \g_IPP_footergraphics_box > \c_zero_dim} {-3mm}
					+ \box_if_empty:NF \g_IPP_acknowledgement_box {.6}
						\textwidth
					-\box_wd:N \g_IPP_footergraphics_box
				}
			}{
				\raggedfooter
				\usekomafont{pageheadfoot}
				\seq_if_empty:NF \g_IPP_contact_address_seq {\contactaddressname\contactaddresssep
					\int_gzero:N \g_IPP_contact_address_int
					\seq_map_inline:Nn  \g_IPP_contact_address_seq {\@contactaddressmark
						####1;\space
					}
					\par
				}
				\g_IPP_poster_foot_tl
			}
		};
		}
	},
	%select default block style
	boxes = IPP,
}

\ExplSyntaxOff
\newcommand*{\EUROfusionInfo}{%
	This work has been carried out within the framework of the EUROfusion
	Consortium, funded by the European Union via the Euratom Research and
	Training Programme (Grant Agreement No 101052200 — EUROfusion). Views and
	opinions expressed are however those of the author(s) only and do not
	necessarily reflect those of the European Union or the European Commission.
	Neither the European Union nor the European Commission can be held
	responsible for them.
}
\ExplSyntaxOn

%backwards compat for TeX Live 2020
\cs_if_exist:NF \box_ht_plus_dp:N  {
	\cs_new:Nn \box_ht_plus_dp:N  {\dim_eval:n {\box_ht:N #1 + \box_ht:N #1}}
}

\cs_new:Nn \IPP_poster_titlebox:n {
	\rule[\dim_eval:n {
		\box_if_empty:NF \l_ptxcd_headline_logo_box {
			-\box_ht_plus_dp:N \l_ptxcd_headline_logo_box -.15\c_ptxcd_logoheight_dim}
		-.65\c_ptxcd_logoheight_dim}
	]{0pt}{0pt}
	\parbox[t]{\dimexpr\linewidth-\dim_max:nn {\box_wd:N \l_ptxcd_headline_logo_box} {2.5\c_ptxcd_logoheight_dim}\relax}{
		\raggedright
		{\usekomafont{disposition}\usekomafont{title}\@title\par}
		\par\vspace{15mm}
		{\usekomafont{author}\@author\par}
		\tl_gset:No \g_IPP_thanks_tl {\@thanks}
		\par
		\usekomafont{author}
		\@institute\par
		\let\footnotetext\IPP@title@footnote
		\g_IPP_thanks_tl
	}
	\par
}

\AtBeginDocument{
	\skip_set:Nn \l_tmpa_skip {\scr@section@afterskip}
	\dim_gset:Nn \g_IPP_section@afterskip_dim  {\l_tmpa_skip}
	\skip_set:Nn \l_tmpa_skip {\scr@section@afterskip}
	\dim_add:Nn \l_tmpa_skip {\parskip}
	\dim_gset:Nn \g_IPP_section@afterskip_dim {\l_tmpa_skip}
	\dim_gset:Nn \g_IPP_footer_colsep_dim {\tcb@poster@colspacing}
	\if@IPP@eurofusion
	\acknowledgement{}
	\fi
}


\ExplSyntaxOff

\setcounter{secnumdepth}{-1}

\def\@listi{\leftmargin1em
	\parsep 4\p@ \@plus2\p@ \@minus\p@
	\topsep 8\p@ \@plus2\p@ \@minus4\p@
	\itemsep4\p@ \@plus2\p@ \@minus\p@}
\let\@listI\@listi

\endinput
%end of ipp-poster.cls

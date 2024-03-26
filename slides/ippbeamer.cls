%% This is file `ippbeamer.cls' version 2.6 (2023/03/21),
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
\def\fileversion{v2.3}
\def\filedate{2022/08/05}
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ippbeamer}
 [\filedate\space\fileversion\space]

\RequirePackage{l3keys2e}
\RequirePackage{graphicx}

\ExplSyntaxOn

\dim_new:N \g_ptxcd_beamer_paperwidth_dim
\dim_new:N \g_ptxcd_beamer_paperheight_dim

\newif\if@IPP@eurofusion
\bool_new:N \g_ptxcd_titlegraphic_bool
\bool_new:N \g__ptxcd_high_resolution_bool
\tl_new:N \g_ptxcd_titlegraphic_tl
\tl_new:N \g_ptxcd_aspectratio_tl
\clist_new:N \g_ptxcd_headlinelogo_clist
\tl_new:N \g_ptxcd_logo_tl
\tl_new:N \g_ptxcd_logosuffix_tl

\msg_new:nnn {ippbeamer} {unknown-titlegraphic} {
	I~could~not~find~a~titlegraphic~for~your~logo.\\
	I~will~set~titlegraphic=false.\\
	Use~\titlegraphic~to~configure~a~custom~setup.
}

%Declare automatic titlegraphic mechanism
\cs_new:Nn \IPP_setup_titlegraphic: {
	\bool_if:NT \g_ptxcd_titlegraphic_bool {
		\tl_if_empty:NTF \g_ptxcd_titlegraphic_tl {
			\ifx\inserttitlegraphic\@empty
			\msg_warning:nn {ippbeamer} {unknown-titlegraphic}
			\fi
		} {
		\titlegraphic{
			\tl_if_empty:NT \g_ptxcd_titlegraphic_tl
			% Automatic image choice
			{
				\tl_gset:Nx \g_ptxcd_titlegraphic_tl {
					\g_ptxcd_logo_tl \bool_if:NT \g__ptxcd_high_resolution_bool {_high_resolution}
				}
			}
			\includegraphics[width=\width]{\g_ptxcd_titlegraphic_tl}
			}
		}
	}
}

\box_new:N \g__ptxcd_headline_subinst_box
\box_new:N \g__ptxcd_title_subinst_box

\msg_new:nnn {ipp} {aspectration-deprecated} {
	The~aspectration~option~is~no~longer~supported.~Only~169~is~allowed.~I~will~ignore~you~input.
}

\msg_new:nnn {ipp} {logo-replaced/removed} {
	The~selectlogo~option~no~longer~allows~use~of~the~value~#1.~Your~input~is~ignored.
}

\keys_define:nn {IPP/beamer} {
	aspectratio .choice:,
	aspectratio / 169 .code:n = {
		\tl_gset:Nn \g_ptxcd_aspectratio_tl {169}
		\dim_gset:Nn \g_ptxcd_beamer_paperwidth_dim {16.00cm}
		\dim_gset:Nn \g_ptxcd_beamer_paperheight_dim {9.00cm}
	},
	aspectratio / 43 .code:n = {
		\msg_warning:nn {ipp} {aspectration-deprecated}
	},
	aspectratio .initial:n = 169,
	logo .meta:n = {headlinelogos=, selectlogo = #1},
	selectlogo .choices:nn = {asdex,w7x} {
		\tl_gset_eq:NN \g_ptxcd_logo_tl \l_keys_choice_tl
		\cs_if_exist:NT \__ptxcd_setup_headline_logo:NnnV {
			\clist_if_empty:NT \g_ptxcd_headlinelogo_clist {
				\__ptxcd_setup_headline_logo:NnnV  \g__ptxcd_headline_subinst_box {_green} {1.5} \g_ptxcd_logo_tl
			}
			\__ptxcd_setup_headline_logo:NnnV  \g__ptxcd_title_subinst_box {_white} {2} \g_ptxcd_logo_tl
		}
	},
	selectlogo / hepp .code:n = {\msg_warning:nnn  {ipp} {logo-replaced/removed}  {hepp}},
	selectlogo / false .meta:n = {selectlogo=},
	selectlogo / unknown .code:n = {
		\tl_gset:Nn \g_ptxcd_logo_tl {#1}
		\cs_if_exist:NT \__ptxcd_setup_headline_logo:NnnV {
			\clist_if_empty:NT \g_ptxcd_headlinelogo_clist {
				\__ptxcd_setup_headline_logo:NnnV  \g__ptxcd_headline_subinst_box {_green} {1.5} \g_ptxcd_logo_tl
			}
			\__ptxcd_setup_headline_logo:NnnV  \g__ptxcd_title_subinst_box {_white} {2} \g_ptxcd_logo_tl
		}
	},
	titlelogos .code:n = {
		\clist_gset:Nn \g_ptxcd_headlinelogo_clist {#1}
		\cs_if_exist_use:NT \__ptxcd_setup_headline_logo:NnnV  {\g__ptxcd_title_subinst_box {_white} {2}  \g_ptxcd_headlinelogo_clist}
	},
	headlinelogos .code:n = {
		\clist_gset:Nn \g_ptxcd_headlinelogo_clist {#1}
		\cs_if_exist_use:NT \__ptxcd_setup_headline_logo:NnnV  {\g__ptxcd_headline_subinst_box {_green} {1.5} \g_ptxcd_headlinelogo_clist}
	},
	eurofusion .code:n = {
		\use:c{@IPP@eurofusion#1}
	},
	eurofusion .default:n = true,
	eurofusion .initial:n = false,
	titlegraphic .choice:,
	titlegraphic / true .code:n = {
		\bool_gset_true:N \g_ptxcd_titlegraphic_bool
		\tl_gclear:N \g_ptxcd_titlegraphic_tl
		\bool_gset_false:N \g__ptxcd_high_resolution_bool
		\cs_if_exist_use:NT \setbeamercolor {*{title}{fg=white,bg=MPG_blue_dark}}
	},
	titlegraphic / false .code:n = {
		\bool_gset_false:N \g_ptxcd_titlegraphic_bool
		\tl_gclear:N \g_ptxcd_titlegraphic_tl
		\bool_gset_false:N \g__ptxcd_high_resolution_bool
		\cs_if_exist_use:NT \setbeamercolor {*{title}{fg=white,bg=MPG_green_dark}}
	},
	titlegraphic / high-resolution .code:n = {
		\bool_gset_true:N \g_ptxcd_titlegraphic_bool
		\tl_gclear:N \g_ptxcd_titlegraphic_tl
		\bool_gset_true:N \g__ptxcd_high_resolution_bool
	},
	titlegraphic .default:n = true,
	titlegraphic / unknown  .code:n = {
		\bool_gset_true:N \g_titlegraphic_bool
		\tl_gset:Nn \g_ptxcd_titlegraphic_tl {#1}
	},
	logofile .tl_gset:N = \g_ptxcd_logofile_tl,
	logofile .initial:n = IPP_Logo_cmyk,
}

\DeclareOption*{%
	\PassOptionsToClass{\CurrentOption}{beamer}
}

\ProcessKeysOptions{IPP/beamer}

\ProcessOptions*

\newcommand{\IPPbeamerSetup}[1]{\keys_set:nn {IPP/beamer} {#1}}
\ExplSyntaxOff


%% Load the latex-beamer class
\LoadClass[t]{beamer}



\ExplSyntaxOn
\setlength\beamer@paperwidth{\g_ptxcd_beamer_paperwidth_dim}
\setlength\beamer@paperheight{\g_ptxcd_beamer_paperheight_dim}

\geometry{
	papersize={\beamer@paperwidth,\beamer@paperheight},
}

\dim_if_exist:NF \c_ptxcd_grid_dim {\dim_const:Nn \c_ptxcd_grid_dim {0.025\paperwidth}}
\dim_if_exist:NF \c_ptxcd_logoheight_dim  {\dim_const:Nn \c_ptxcd_logoheight_dim {.11\paperheight}}

\cs_set:Nn \__ptxcd_setup_headline_logo:Nnnn {
	\tl_if_blank:nTF {#4}  {
		\box_clear:N #1
	}{
		\bool_set_false:N \l_tmpa_bool
		\hbox_set:Nn #1 {
			\clist_map_inline:nn {#4} {
				\bool_if:NT \l_tmpa_bool {\rule{1ex}{0pt}}
				\bool_set_true:N \l_tmpa_bool
				\file_if_exist:nTF {img/##1#2.pdf} {\tl_set:Nn \l_tmpa_tl {img/}} {\tl_clear:N \l_tmpa_tl}
				\file_if_exist:nTF {\l_tmpa_tl##1#2.pdf}
					{\includegraphics[height=#3\c_ptxcd_grid_dim]{\l_tmpa_tl##1#2}}
					{\includegraphics[height=#3\c_ptxcd_grid_dim]{##1}}
			}
		}
	}
}

\cs_generate_variant:Nn \__ptxcd_setup_headline_logo:Nnnn {NnnV}


\RequirePackage{mpg-fonts}

\ExplSyntaxOff

\AtEndOfClass{%
  \usetheme{IPP}%
}

\renewcommand*{\framesubtitle}{\ClassError{ippbeamer}{The mechanism of framesubtitles must not be used with ippbeamer.}}

\ExplSyntaxOn
\clist_if_empty:NTF \g_ptxcd_headlinelogo_clist {
		\__ptxcd_setup_headline_logo:NnnV  \g__ptxcd_headline_subinst_box {_green} {1.5} \g_ptxcd_logo_tl
} {
\__ptxcd_setup_headline_logo:NnnV  \g__ptxcd_headline_subinst_box {_green} {1.5} \g_ptxcd_headlinelogo_clist
}
\__ptxcd_setup_headline_logo:NnnV  \g__ptxcd_title_subinst_box {_white} {2} \g_ptxcd_logo_tl
\ExplSyntaxOff

\endinput
;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Herberth Amaral"
      user-mail-address "herberthamaral@gmail.com")

(setq safe-local-variable-values '((lsp-pyright-venv-path . "/home/herberth/bidx1/bidx1/.venv")))
;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-roam-directory "~/org/roam")
(setq org-noter-notes-search-path "~/org/notes")
(setq org-archive-location "~/org/archive/%s_archive::")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; (use-package! flycheck
;;   :init
;;   (setq-default flycheck-disabled-checkers '(python-pylint lsp))
;;   (setq-default flycheck-checkers  '(python-flake8 python-mypy)))

(use-package! org-wild-notifier)


;; org

(after! org

  (setq org-todo-keywords
        (quote ((sequence "TODO(t)" "STARTED(s)" "DOING(d)" "WAITING(w)" "|" "DONE(o)" "CANCELLED(c)" "DELEGATED(e)")
                (sequence "CALL(c)" "INCALL(i)" "|" "CALLED(d)" "CANCELLED(x)")
                (sequence "BUFFER(b)" "BUFFERING(u)" "BUFFERED(f)" "|" "RELEASED(r)" "DROPPED(r)"))))

  (setq org-todo-keyword-faces
        '(
          ("TODO" . org-warning)
          ("CALL" . org-warning)
          ("BUFFER" . org-warning)
          ("DOING" . (:foreground "orange" :weight bold))
          ("INCALL" . (:foreground "orange" :weight bold))
          ("BUFFERING" . (:foreground "orange" :weight bold))
          ("WAITING" . "magenta")
          ("BUFFERED" . "magenta")
          ("DONE" . "green")
          ("RELEASED" . "green")
          ("DELEGATED" . "green")))


  (setq org-priority-faces '((?A . (:foreground "red"))
                             (?B . (:foreground "yellow"))
                             (?C . (:foreground "green"))))
  (setq org-enforce-todo-checkbox-dependencies 1)

  ;; hl-todo
  (setq hl-todo-keyword-faces
        `(("TODO"  . ,(face-foreground 'warning))
          ("FIXME" . ,(face-foreground 'error))
          ("DEPRECATED" . "#FFA500")
          ("WARNING" . "#FFA500")
          ("REFACTOR" . "#FF0000")
          ("NOTE"  . "#D9FF00")))

  (org-babel-do-load-languages
   'org-babel-load-languages
   '((dot . t))))



;; formatter
(setq-hook! 'python-mode-hook +format-with-lsp nil)
(set-formatter! 'black "black -q -l 120 \-")

;; projectile

(map! :n "SPC t i" #'projectile-toggle-between-implementation-and-test)
(map! :n "SPC p E" #'projectile-discover-projects-in-directory)

;; lsp-mode
(setf lsp-diagnostic-filter (lambda (param work)
            (puthash "diagnostics"
                     (cl-remove-if (lambda (diag) (gethash "tags" diag))
                 (gethash "diagnostics" param))
               param)
            param))

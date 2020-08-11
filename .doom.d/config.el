;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Herberth Amaral"
      user-mail-address "herberthamaral@gmail.com")

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
(setq org-todo-keywords
      (quote ((sequence "TODO(t)" "STARTED(s)" "DOING(d)" "WAITING(w)" "|" "DONE(o)" "CANCELLED(c)" "DELEGATED(e)")
        (sequence "CALL(c)" "INCALL(i)" "|" "CALLED(d)" "CANCELLED(x)")
        (sequence "BUFFER(b)" "BUFFERING(u)" "BUFFERED(f)" "|" "RELEASED(r)" "DROPPED(r)"))))

(setq org-todo-keyword-faces
      '(
  ("TODO" . org-warning)
  ("BUFFER" . org-warning)
  ("DOING" . (:foreground "orange" :weight bold))
  ("BUFFERING" . (:foreground "orange" :weight bold))
  ("WAITING" . "magenta")
  ("BUFFERED" . "magenta")
  ("DONE" . "green")
  ("RELEASED" . "green")
  ("DELEGATED" . "green")
  ))

(setq org-priority-faces '((?A . (:foreground "red"))
                           (?B . (:foreground "yellow"))
                           (?C . (:foreground "green"))))
(setq org-enforce-todo-checkbox-dependencies 1)

;; hl-todo
(setq hl-todo-keyword-faces
      `(("TODO"  . ,(face-foreground 'warning))
        ("FIXME" . ,(face-foreground 'error))
        ("DEPRECATED" . "#FFA500")
        ("REFACTOR" . "#FF0000")
        ("NOTE"  . "#D9FF00")))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((dot . t)))

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

(use-package! auto-virtualenv
    :init
    (add-hook 'python-mode-hook 'auto-virtualenv-set-virtualenv))

(use-package! flycheck
  :init
  (setq-default flycheck-disabled-checkers '(python-pylint lsp))
  (setq-default flycheck-checkers  '(python-flake8 python-mypy)))

(use-package! org-wild-notifier)

;; k8s
(use-package! kubernetes
  :ensure t
  :commands (kubernetes-overview))

(use-package! kubernetes-evil
  :ensure t
  :after kubernetes)

;; custom config
(require 'iso-transl)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("912cac216b96560654f4f15a3a4d8ba47d9c604cbc3b04801e465fb67a0234f0" "0cb1b0ea66b145ad9b9e34c850ea8e842c4c4c83abe04e37455a1ef4cc5b8791" "9b01a258b57067426cc3c8155330b0381ae0d8dd41d5345b5eddac69f40d409b" "d71aabbbd692b54b6263bfe016607f93553ea214bc1435d17de98894a5c3a086" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" default))
 '(package-selected-packages '(kubernetes-evil kubernetes))
 '(safe-local-variable-values
   '((blacken-skip-string-normalization . t)
     (blacken-allow-py36 . t)
     (blacken-line-length . 100)
     (encoding . utf-8))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

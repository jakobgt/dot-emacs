(setenv "PATH" (getenv "PATH"))
(global-set-key "\C-x\C-a" 'auto-fill-mode)

;;;; package.el
(require 'package)
(setq package-user-dir "~/.emacs.d/elpa/")
(add-to-list 'package-archives
'("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
'("melpa" . "http://melpa.milkbox.net/packages/") t)
;(add-to-list 'package-archives
;'("quasi-melpa" . "http://quasi.milkbox.net/packages/") t)
(package-initialize)

(defvar abachm-packages
  '(
  powerline
  ido-ubiquitous
  ido-vertical-mode
  find-file-in-project
  magit
  yasnippet
  dropdown-list
  js2-mode
  mmm-mode
  git-commit-mode
  gist
  go-mode
  json-mode
  jedi
  python-mode
  solarized-theme
  puppet-mode
  pep8
  flymake-python-pyflakes
  flymake-cursor
  yaml-mode
  markdown-mode
  ))

(defun abachm-install-packages ()
  "Install my list of packages."
  (interactive)
  (package-refresh-contents)
  (mapc #'(lambda (package)
            (unless (package-installed-p package)
              (package-install package)))
        abachm-packages))

(setq default-directory "~/.")

(setq tab-width 2)
 ;;; Prevent Extraneous Tabs
(setq-default indent-tabs-mode nil)
;; rebind quit emacs to C-x-q (I keep hitting C-x-c by accident)
(global-unset-key [(control x)(control c)])
(global-set-key [(control x)(control q)]  'save-buffers-kill-emacs)

;;}}}

;;{{{ Helper functions 
;;; Commentary
;;
;; This section contain some functions that I find useful

;;; Reload Emacs config
;;  By http://www.emacswiki.org/cgi-bin/wiki/JesseWeinstein
(defun load-.emacs () 
  "Runs load-file on ~/.emacs" 
  (interactive)
  (load-file "~/.emacs"))

;; Flyspell activation for text mode
(add-hook 'text-mode-hook 
	  (lambda () (flyspell-mode 1)))

;; (add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'c-mode-hook (lambda () (hs-minor-mode 1)))
;;To use danish characters as they are in Mac OS X
(global-unset-key "\M-'")
(global-unset-key "\M-a")
(global-unset-key "\M-o")
(global-set-key  "\M-a" '(lambda () (interactive) (insert "å")))
(global-set-key  "\M-o" '(lambda () (interactive) (insert "ø")))
(global-set-key  "\M-'" '(lambda () (interactive) (insert "æ")))
;;And now for the upper case chars
(global-set-key  "\M-A" '(lambda () (interactive) (insert "Å")))
(global-set-key  "\M-O" '(lambda () (interactive) (insert "Ø")))
(global-set-key  "\M-\"" '(lambda () (interactive) (insert "Æ")))
(global-set-key  "\C-z" 'just-one-space) 
;; C-w to kill word, move kill region to C-x-k
;;(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'backward-kill-word)
;; (global-set-key "\C-c\C-k" 'kill-region)
;;Delete char on mac
;;For Mac, to change the binding of the delete button
(global-set-key  (kbd "<kp-delete>") 'delete-char)
(global-set-key  "\C-j" 'delete-backward-char)
(global-set-key  "\M-j" 'backward-kill-word)

(setq-default TeX-master nil) ; Query for master file.

(defun my-set-ctrl-j-to-delete-back-char ()
  "My hook for for setting \C-j to delete backward char."
  (local-set-key "\C-j" 'delete-backward-char)
  )

;; dOvs.el -*- emacs-lisp -*-
;; dot-emacs -*- emacs-lisp -*-
(setq load-path (cons "/opt/local/share/emacs/site-lisp/" (cons "~/.emacs.d" load-path)))


; Code for highlighting column 90
(require 'fill-column-indicator)
(defun show-column-at-90-chars ()
  "A hook for showing a vertical ruler at character 90"
   (setq fci-rule-column 90)
   (fci-mode 1))
;  (

;; SML
;(autoload 'sml-mode "sml-mode" () t)
(autoload 'sml-mode "sml-mode-color" () t)
(setq auto-mode-alist (cons '("\\.sml$" . sml-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.sig$" . sml-mode) auto-mode-alist))
(add-hook 'sml-shell-hook 
  #'(lambda ()  
      (send-string sml-process-name
        "use \"~/.emacs.d/print.sml\";\n")))


;; Scheme.
(setq load-path (cons "~/.emacs.d" load-path))

(autoload 'petite-chez-scheme-mode "petite-chez-scheme-mode-color" () t)
(setq auto-mode-alist
      (cons '("\\.scm$" . petite-chez-scheme-mode)
	    (cons '("\\.sim$" . petite-chez-scheme-mode)
		  auto-mode-alist)))


;; (require 'tex-site)
;; AUCTeX setup, will turn on reftex mode when editing LaTeX documents
;; (setq TeX-auto-save t)     ;; Enable parse on load.
;; (setq TeX-parse-self t)    ;; Enable parse on save. will create the .auto directory
;; (setq TeX-auto-untabify t) ;; Automatically remove all tabs from file on save
;; (setq-default TeX-master nil)

;; (add-hook 'latex-mode-hook 'turn-on-reftex)
;; (add-hook 'latex-mode-hook 'turn-on-auto-fill)
;; (add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;; (add-hook 'LaTeX-mode-hook 'turn-on-auto-fill)
;; (add-hook 'LaTeX-mode-hook 'my-set-ctrl-j-to-delete-back-char)
;; (add-hook 'bibtex-mode-hook 'my-set-ctrl-j-to-delete-back-char)
;; (setq reftex-plug-into-auctex t)
;; (custom-set-variables
;;   custom-set-variables was added by Custom.
;;   If you edit it by hand, you could mess it up, so be careful.
;;   Your init file should contain only one such instance.
;;   If there is more than one, they won't work right.
;; '(TeX-PDF-mode t))
;;(custom-set-faces
;;   custom-set-faces was added by Custom.
;;   If you edit it by hand, you could mess it up, so be careful.
;;   Your init file should contain only one such instance.
;;   If there is more than one, they won't work right.
;;)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Auto-complete words
;;;;;;;;;;;;;;;;;;;;;;;;;;;
 (global-set-key "\C-q" 'dabbrev-expand)



;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Ispell
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; ASpell
(setq ispell-program-name "/opt/local/bin/aspell")

(autoload 'ispell-word "ispell"
         "Check the spelling of word in buffer." t)
      (global-set-key "\e$" 'ispell-word)
      (autoload 'ispell-region "ispell"
         "Check the spelling of region." t)
      (autoload 'ispell-buffer "ispell"
         "Check the spelling of buffer." t)
      (autoload 'ispell-complete-word "ispell"
         "Look up current word in dictionary and try to complete it." t)
      (autoload 'ispell-change-dictionary "ispell"
         "Change ispell dictionary." t)
      (autoload 'ispell-message "ispell"
         "Check spelling of mail message or news post.")
      (autoload 'ispell-minor-mode "ispell"
         "Toggle mode to automatically spell check words as they are typed in.")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Changing backup place
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Setting backup dir - store all bacup files in a central place so they
;; are not all over the place
(require 'backup-dir)
(setq bkup-backup-directory-info '((t "~/.emacs.d/backup" ok-create full-path)))



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; "Bedre" find-file function
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; To get the alternative switch-to-buffer and find-file functions in
;; this package bound to keys, do
(ido-mode t)




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Thanks to Ian Zernys .emacs
;; http://www.zerny.dk/emacs/dot-emacs.el
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;{{{ Miscellaneous customizations

;; This section contains miscellaneous customizations that have no
;; other logical home.
;;
;; Requirements: None

(setq inhibit-startup-message t)        ; dont show the GNU splash screen
(transient-mark-mode t)			; show selection from mark
;;(menu-bar-mode -1)                      ; disable menu bar
(mouse-avoidance-mode 'jump)		; jump mouse away when typing
(setq visible-bell 1)			; turn off bip warnings
(show-paren-mode t)			; turn on highlight paren mode
(auto-compression-mode 1)		; browse tar archives
(put 'upcase-region 'disabled nil)	; enable ``upcase-region''
(put 'set-goal-column 'disabled nil)    ; enable column positioning
(setq case-fold-search t)               ; make search ignore case
(fset 'yes-or-no-p 'y-or-n-p)
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(TeX-PDF-mode nil))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 )


;; Protocol buffers

;;(require 'protobuf-mode)

;; PHP
(require 'php-mode)

;;; Scroll line-by-line
;;
;; Used to make scroll-wheel/track-point work.
;; see x11 loader
(defun scroll-up-one-line ()
      (interactive)
      (scroll-up 1))
(defun scroll-down-one-line ()
      (interactive)
      (scroll-down 1))

;;CMake

  (setq load-path (cons (expand-file-name "~/.emacs.d/cmake-mode.el") load-path))
  (require 'cmake-mode)
  (setq auto-mode-alist
        (append '(("CMakeLists\\.txt\\'" . cmake-mode)
                  ("\\.cmake\\'" . cmake-mode))
                auto-mode-alist))


;;This makes C-c C-c call make.sh, when in LaTeX mode
;;(eval-after-load "tex" 
;;  '(setcdr (assoc "LaTeX" TeX-command-list)
;;          '("%`make%' %t"
;;          '("%`%l%(mode) -shell-escape%' %t"
;;          TeX-run-TeX nil (latex-mode doctex-mode) :help "Run LaTeX")
;;    )
;;  )

;;Haskell

;;(load "~/.emacs.d/haskell-mode/haskell-site-file")

;;(add-hook 'haskell-mode-hook 'turn-on-haskell-doc-mode)
;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indentation)
    ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-indent)
    ;;(add-hook 'haskell-mode-hook 'turn-on-haskell-simple-indent)




;;; Bison and flex mode

(autoload 'bison-mode "bison-mode.el")
(setq auto-mode-alist (cons '("\\.y$" . bison-mode) 
			    (cons '("\\.ypp$" . bison-mode) 
				  (cons '("\\.yy$" . bison-mode) auto-mode-alist))))

(autoload 'flex-mode "flex-mode")
(setq auto-mode-alist (cons '("\\.l$" . flex-mode) auto-mode-alist))


;;{{{ C and C++ 

(require 'cc-mode)
;;(add-hook 'c-mode-hook (lambda () (c++-mode)))
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (flyspell-prog-mode)
	    (setq tab-width 2)
	    (setq c-basic-offset tab-width)
	    (setq indent-tabs-mode nil)))

;;}}}



;; COQ
;; (load-file "~/.emacs.d/ProofGeneral-4.1/generic/proof-site.el")
;; ;;(load-file "/opt/local/share/ProofGeneral/generic/proof-site.el")
;; (setq auto-mode-alist (cons '("\\.v$" . coq-mode) auto-mode-alist))
;; (autoload 'coq-mode "coq" "Major mode for editing Coq vernacular." t)
;; (autoload 'run-coq "inferior-coq" "Run an inferior Coq process." t)
;; (autoload 'run-coq-other-window "inferior-coq"
;;   "Run an inferior Coq process in a new window." t)
;; (autoload 'run-coq-other-frame "inferior-coq"
;;   "Run an inferior Coq process in a new frame." t)
;(require 'pretty-mode)
;(global-pretty-mode 1)

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))
(add-hook 'yaml-mode-hook
      '(lambda ()
        (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'yaml-mode-hook 'my-set-ctrl-j-to-delete-back-char)
(add-hook 'yaml-mode-hook 'show-column-at-90-chars)

;; Ruby
(add-hook 'ruby-mode-hook 'my-set-ctrl-j-to-delete-back-char)
(add-hook 'ruby-mode-hook 'show-column-at-90-chars)
;; We set up highlighting of code blocks
(require 'hrb-mode)
;; highlight keywords if both are visible, highlight complete block otherwise
(setq hrb-highlight-mode 'mixed)
;; enable hrb-mode
(hrb-mode t)


;; SCSS (SASS language)
;;(add-to-list 'load-path (expand-file-name "~/.emacs.d/folder-where-you-put-scss-mode-el"))
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.scss.erb\\'" . scss-mode))
(setq scss-output-directory "/tmp/sass")
(setq css-indent-offset 2)
(add-hook 'scss-mode-hook 'show-column-at-90-chars)
(require 'aj-compilation)
(require 'lorem-ipsum)

;; Coffee Script
(add-to-list 'load-path "~/.emacs.d/elpa/coffee-mode-0.4.1")
(require 'coffee-mode)
(setq whitespace-action '(auto-cleanup)) ;; automatically clean up bad whitespace
(setq whitespace-style '(trailing space-before-tab indentation empty space-after-tab)) ;; only show bad whitespace

; Emacs key binding
(define-key coffee-mode-map "\C-c\C-c"  'coffee-compile-file)
;(define-key coffee-mode-map  [(control c)(control )] 'coffee-compile-file)
(global-set-key (kbd "C-;")  'comment-or-uncomment-region)

(require 'haml-mode)
; HAML mode
(add-hook 'haml-mode-hook
               (lambda ()
                 (setq indent-tabs-mode nil)
                 (define-key haml-mode-map "\C-m" 'newline-and-indent)))
(add-hook 'haml-mode-hook 'show-column-at-90-chars)
(column-number-mode 1)


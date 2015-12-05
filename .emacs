; hide toolbar and menu
(tool-bar-mode -1)
(menu-bar-mode -1)

; do not show splash screen
(setq inhibit-splash-screen 1)

; highlight matching parenteses
(show-paren-mode 1)

; show line and column number
(global-linum-mode 1)
(column-number-mode 1)

;; ---------------------------------------------------------------------------------
;; list the packages to install
(setq package-list '(color-theme highlight-indentation evil evil-numbers dtrt-indent))
;; ---------------------------------------------------------------------------------

; list the repositories containing them
(require 'package)
(setq package-archives '(("marmalade" . "http://marmalade-repo.org/packages/")
    ("melpa" . "http://melpa.milkbox.net/packages/")
    ("gnu" . "http://elpa.gnu.org/packages/")))

; activate all the packages (in particular autoloads)
(package-initialize)

; fetch the list of packages available
(unless package-archive-contents
    (package-refresh-contents))

; install the missing packages
(dolist (package package-list)
    (unless (package-installed-p package)
        (package-install package)))

; theme
(require 'color-theme)
(color-theme-initialize)
(color-theme-tty-dark)
(eval-after-load "color-theme" '(color-theme-tty-dark))

;; -----------------------------------------------------------------------------------
;; customizations

; evil mode
(require 'evil)
(evil-mode 1)
(eval-after-load "evil"
    '(progn
        (define-key evil-normal-state-map (kbd "C-w <left>") 'evil-window-left)
        (define-key evil-normal-state-map (kbd "C-w <down>") 'evil-window-down)
        (define-key evil-normal-state-map (kbd "C-w <up>") 'evil-window-up)
        (define-key evil-normal-state-map (kbd "C-w <right>") 'evil-window-right)
        (define-key evil-normal-state-map (kbd "C-w t") 'elscreen-create) ;creat tab
        (define-key evil-normal-state-map (kbd "C-w x") 'elscreen-kill) ;kill tab
        (define-key evil-normal-state-map "gT" 'elscreen-previous) ;previous tab
        (define-key evil-normal-state-map "gt" 'elscreen-next) ;next tab
        ))

; use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq tab-width 4)

; show whitespaces
(global-whitespace-mode 1)
(setq whitespace-style (quote (face tabs tab-mark trailing lines-tail)))
(setq whitespace-display-mappings
;; all numbers are Unicode codepoint in decimal. try (insert-char 182 ) to see it
'(
    (space-mark 32 [183] [46]) ; 32 SPACE, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
    (newline-mark 10 [182 10]) ; 10 LINE FEED
    (tab-mark 9 [9655 9] [92 9]) ; 9 TAB, 9655 WHITE RIGHT-POINTING TRIANGLE 「▷」
))
(set-face-attribute 'whitespace-space nil :background "black" :foreground "gray15")
(setq whitespace-line-column 120)

; vim style indentation
(require 'dtrt-indent)
(dtrt-indent-mode 1)
(define-key global-map (kbd "RET") 'newline-and-indent)

; indentation highlight
(require 'highlight-indentation)
(add-hook 'prog-mode-hook 'highlight-indentation-mode)


;; ---------------------------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("1c50040ec3b3480b1fec3a0e912cac1eb011c27dd16d087d61e72054685de345" "0aca3a26459bbb43a77f34bc22851c05c0a5d70d3230cbcdbda4fec20fef77e6" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

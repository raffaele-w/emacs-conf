;; System options
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#212526" "#ff4b4b" "#b4fa70" "#fce94f" "#729fcf" "#e090d7" "#8cc4ff" "#eeeeec"])
 '(custom-enabled-themes (quote (deeper-blue)))
 '(custom-safe-themes
   (quote
    ("7dd0db710296c4cec57c39068bfffa63861bf919fb6be1971012ca42346a417f" "c0dd5017b9f1928f1f337110c2da10a20f76da0a5b14bb1fec0f243c4eb224d4" "0788bfa0a0d0471984de6d367bb2358c49b25e393344d2a531e779b6cec260c5" "e8586a76a96fd322ccb644ca0c3a1e4f4ca071ccfdb0f19bef90c4040d5d3841" "fbcdb6b7890d0ec1708fa21ab08eb0cc16a8b7611bb6517b722eba3891dfc9dd" "e87a2bd5abc8448f8676365692e908b709b93f2d3869c42a4371223aab7d9cf8" default)))
 '(rainbow-identifiers-cie-l*a*b*-lightness 70)
 '(rainbow-identifiers-cie-l*a*b*-saturation 20)
 '(scroll-bar-mode nil)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; My favorite font
(set-default-font "Monaco-12")

;; My emacs packages
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; Melpa package repo
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'multi-term)
(setq multi-term-program "/bin/zsh")

;; Powerline
(require 'powerline)
(powerline-reset)
;; We set the set-face-attribute here instead of in powerline.el
;; to deal with eval-buffer bug
(set-face-attribute 'mode-line nil
		    :background "DarkOrange"
		    :box nil)
(set-face-attribute 'mode-line-inactive nil
		    :box nil)
(powerline-default-theme)

;; Evil mode (Vim) for Emacs
(require 'evil)
;;(evil-mode 1)

;;(require 'powerline-evil)
;;(powerline-reset)
;;(powerline-evil-center-color-theme)

(require 'popwin)
(popwin-mode 1)

(require 'relative-line-numbers)
(global-relative-line-numbers-mode)

;; Gtags, load it when needed
(autoload 'ggtags-mode "ggtags" "" t)
(setq c-mode-hook '(lambda () (ggtags-mode 1)))
(setq c++-mode-hook '(lambda () (ggtags-mode 1)))
(setq java-mode-hook '(lambda () (ggtags-mode 1)))


;; Keyboard binding
;; Add keyboard binding for window switching
(global-set-key (kbd "M-[") (lambda () (interactive) (other-window -1)))
(global-set-key (kbd "M-]") (lambda () (interactive) (next-multiframe-window)))

;; Evil mode key switch
(global-set-key (kbd "C-c ]") (lambda () (interactive) (evil-normal-state) (evil-mode 0)))
(global-set-key (kbd "C-c [") (lambda () (interactive) (evil-mode 1)))
;;(key-chord-define evil-insert-state-map "jj" 'evil-normal-state)

;; Change mode-line color by evil state
(lexical-let
  ((default-color (cons (face-background 'mode-line)
			(face-foreground 'mode-line))))
  (add-hook 'post-command-hook
	    (lambda ()
	      (let ((color (cond ((minibufferp) default-color)
				 ((evil-normal-state-p) '("#ff0000" . "#000000"))
				 ((evil-insert-state-p) '("#ffffff" . "#000000"))
				 ((evil-visual-state-p) '("#ffff00" . "#000000"))
				 (t default-color))))
		(set-face-attribute 'mode-line nil :background (car color) :box nil)
		(powerline-reset)
		))))

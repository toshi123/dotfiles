;;(setq load-path (cons (expand-file-name "~/elisp") load-path))
(setq load-path
      (append (list nil "~/elisp"
                    "~/.emacs.d/auto-install"
                    "~/.emacs.d/site-lisp")
              load-path))

; 色指定
;; (custom-set-faces
;;  '(default ((t
;;              (:background "black" :foreground "#55FF55")
;; ;             (:background "black" :foreground "#FFFFFF")
;;              )))
;;  '(cursor ((((class color)
;;              (background dark))
;;             (:background "#00AA00"))
;;            (((class color)
;;              (background light))
;;             (:background "#999999"))
;;            (t ())
;;            )))

; using color-theme.el
(load "color-theme")
(color-theme-initialize)
;(color-theme-clarity)
(color-theme-dark-laptop)

;;タブ幅を 4 に設定
(setq-default tab-width 4)
;;タブではなくスペースを使う
(setq-default indent-tabs-mode nil)
(setq indent-line-function 'indent-relative-maybe)

;;ウインドウ移動
(define-key global-map "\C-t" 'other-window)

;;バッファ入れ替え
;;F2でカーソルを残したまま
;;F2+shiftでカーソルごと
(defun swap-screen()
  "Swap two screen,leaving cursor at current window."
  (interactive)
  (let ((thiswin (selected-window))
        (nextbuf (window-buffer (next-window))))
    (set-window-buffer (next-window) (window-buffer))
    (set-window-buffer thiswin nextbuf)))
(defun swap-screen-with-cursor()
  "Swap two screen,with cursor in same buffer."
  (interactive)
  (let ((thiswin (selected-window))
        (thisbuf (window-buffer)))
    (other-window 1)
    (set-window-buffer thiswin (window-buffer))
    (set-window-buffer (selected-window) thisbuf)))
(global-set-key [f2] 'swap-screen)
(global-set-key [S-f2] 'swap-screen-with-cursor)


;; auto-install
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(auto-install-update-emacswiki-package-name t)
(auto-install-compatibility-setup)

;; anything
(require 'anything-startup)
;; recentf-ext
(require 'recentf-ext)
;; key bind for anything-for-file
;;(define-key global-map (kbd "\C-;") 'anything-for-files)
(define-key global-map (kbd "C-x b") 'anything-for-files)

;;ac-mode.el
(load "ac-mode")
(setq ac-mode-exception '(dired-mode hex-mode))
(add-hook 'find-file-hooks 'ac-mode-without-exception)
(setq ac-mode-goto-end-of-word t)

;; cperl-mode.el
;;; perl-modeにcperl-modeをエイリアス
(defalias 'perl-mode 'cperl-mode)
(setq auto-mode-alist
      (append '(("\\.\\([pP][Llm]\\|al\\)$" . cperl-mode))  auto-mode-alist ))
(setq interpreter-mode-alist (append interpreter-mode-alist
                                     '(("miniperl" . cperl-mode))))
(add-hook 'cperl-mode-hook
          (lambda ()
            (set-face-bold-p 'cperl-array-face nil)
            (set-face-background 'cperl-array-face "black")
            (set-face-bold-p 'cperl-hash-face nil)
            (set-face-italic-p 'cperl-hash-face nil)
            (set-face-background 'cperl-hash-face "black")
            ))

(setq cperl-close-paren-offset -4)
(setq cperl-continued-statement-offset 4)
(setq cperl-indent-level 4)
(setq cperl-indent-parens-as-block t)
(setq cperl-tab-always-indent t)


; ruby-mode の設定
(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(setq auto-mode-alist
      (append '(("\\.rb$" . ruby-mode)) auto-mode-alist))
(setq interpreter-mode-alist (append '(("ruby" . ruby-mode))
                                     interpreter-mode-alist))
(autoload 'run-ruby "inf-ruby"
  "Run an inferior Ruby process")
(autoload 'inf-ruby-keys "inf-ruby"
  "Set local key defs for inf-ruby in ruby-mode")
(add-hook 'ruby-mode-hook
          '(lambda ()
             (inf-ruby-keys)))

;; R-mode
;; (load "~/ess-5.11/lisp/ess-site")
(load "~/.emacs.d/site-lisp/ess-5.11/lisp/ess-site")
;;(setq load-path (cons (expand-file-name "~/elisp/ess") load-path))
(require 'ess)
(setq auto-mode-alist
     (cons (cons "\\.[rR]$" 'R-mode) auto-mode-alist))
(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)
(setq-default inferior-R-program-name "/usr/local/bin/R")

;; 対応するカッコを自動挿入する ← なぜかシングルクォーテーションが入力できなくなる。
;; (load "brackets.el")
;; (add-hook 'cperl-mode-hook
;;           '(lambda()
;;              (progn
;;                (define-key cperl-mode-map "{" 'insert-braces)
;;                (define-key cperl-mode-map "(" 'insert-parens)
;;                (define-key cperl-mode-map "\"" 'insert-double-quotation)
;;                (define-key cperl-mode-map "\'" 'insert-single-quotation)
;;                (define-key cperl-mode-map "[" 'insert-brackets)
;;                (define-key cperl-mode-map "\C-c}" 'insert-braces-region)
;;                (define-key cperl-mode-map "\C-c)" 'insert-parens-region)
;;                (define-key cperl-mode-map "\C-c]" 'insert-brackets-region)
;;                (define-key cperl-mode-map "\C-c\"" 'insert-double-quotation-region))))

;; 対応するカッコを自動挿入する
(require 'flex-autopair)
(flex-autopair-mode 1)


;; flymake (Emacs22から標準添付されている)
(require 'flymake)

;; set-perl5lib
;; 開いたスクリプトのパスに応じて、@INCにlibを追加してくれる
;; 以下からダウンロードする必要あり
;; http://svn.coderepos.org/share/lang/elisp/set-perl5lib/set-perl5lib.el
(require 'set-perl5lib)

;; エラー、ウォーニング時のフェイス
(set-face-background 'flymake-errline "#5F5")
(set-face-foreground 'flymake-errline "black")
(set-face-background 'flymake-warnline "yellow")
(set-face-foreground 'flymake-warnline "black")

;; エラーをミニバッファに表示
;; http://d.hatena.ne.jp/xcezx/20080314/1205475020
;(defun flymake-display-err-minibuf ()
;  "Displays the error/warning for the current line in the minibuffer"
;  (interactive)
;  (let* ((line-no             (flymake-current-line-no))
;         (line-err-info-list  (nth 0 (flymake-find-err-info flymake-err-info line-no)))
;         (count               (length line-err-info-list)))
;    (while (> count 0)
;      (when line-err-info-list
;        (let* ((file       (flymake-ler-file (nth (1- count) line-err-info-list)))
;               (full-file  (flymake-ler-full-file (nth (1- count) line-err-info-list)))
;               (text (flymake-ler-text (nth (1- count) line-err-info-list)))
;               (line       (flymake-ler-line (nth (1- count) line-err-info-list))))
;          (message "[%s] %s" line text)))
;      (setq count (1- count)))))

;; Perl用設定
;; http://unknownplace.org/memo/2007/12/21#e001
(defvar flymake-perl-err-line-patterns
  '(("\\(.*\\) at \\([^ \n]+\\) line \\([0-9]+\\)[,.\n]" 2 3 nil 1)))

(defconst flymake-allowed-perl-file-name-masks
  '(("\\.pl$" flymake-perl-init)
    ("\\.pm$" flymake-perl-init)
    ("\\.t$" flymake-perl-init)))

(defun flymake-perl-init ()
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "perl" (list "-wc" local-file))))

(defun flymake-perl-load ()
  (interactive)
  (defadvice flymake-post-syntax-check (before flymake-force-check-was-interrupted)
    (setq flymake-check-was-interrupted t))
  (ad-activate 'flymake-post-syntax-check)
  (setq flymake-allowed-file-name-masks (append flymake-allowed-file-name-masks flymake-allowed-perl-file-name-masks))
  (setq flymake-err-line-patterns flymake-perl-err-line-patterns)
  (set-perl5lib)
  (flymake-mode t))

(add-hook 'cperl-mode-hook 
	  '(lambda ()
             (flymake-mode t)))

(defun next-flymake-error ()
  (interactive)
  (flymake-goto-next-error)
  (let ((err (get-char-property (point) 'help-echo)))
    (when err
      (message err))))
(global-set-key "\C-ce" 'next-flymake-error)


; for powerline.el
(defun arrow-right-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 18 2 1\",
\".c %s\",
\" c %s\",
\".           \",
\"..          \",
\"...         \",
\"....        \",
\".....       \",
\"......      \",
\".......     \",
\"........    \",
\".........   \",
\".........   \",
\"........    \",
\".......     \",
\"......      \",
\".....       \",
\"....        \",
\"...         \",
\"..          \",
\".           \"};"  color1 color2))

(defun arrow-left-xpm (color1 color2)
  "Return an XPM right arrow string representing."
  (format "/* XPM */
static char * arrow_right[] = {
\"12 18 2 1\",
\".c %s\",
\" c %s\",
\"           .\",
\"          ..\",
\"         ...\",
\"        ....\",
\"       .....\",
\"      ......\",
\"     .......\",
\"    ........\",
\"   .........\",
\"   .........\",
\"    ........\",
\"     .......\",
\"      ......\",
\"       .....\",
\"        ....\",
\"         ...\",
\"          ..\",
\"           .\"};"  color2 color1))

(defconst color0 "#ed3161")
(defconst color1 "#999")
(defconst color2 "#555")

(defvar arrow-right-0 (create-image (arrow-right-xpm color0 color1) 'xpm t :ascent 'center))
(defvar arrow-right-1 (create-image (arrow-right-xpm color1 color2) 'xpm t :ascent 'center))
(defvar arrow-right-2 (create-image (arrow-right-xpm color2 "None") 'xpm t :ascent 'center))
(defvar arrow-left-1  (create-image (arrow-left-xpm color2 color1) 'xpm t :ascent 'center))
(defvar arrow-left-2  (create-image (arrow-left-xpm "None" color2) 'xpm t :ascent 'center))

(setq-default mode-line-format
 (list  '(:eval (concat (propertize " %* %b " 'face 'mode-line-color-0)
                        (propertize " " 'display arrow-right-0)))
        '(:eval (concat (propertize " %Z " 'face 'mode-line-color-1)
                        (propertize " " 'display arrow-right-1)))
        '(:eval (concat (propertize " %m " 'face 'mode-line-color-2)
                        (propertize " " 'display arrow-right-2)))

        ;; Justify right by filling with spaces to right fringe - 16
        ;; (16 should be computed rahter than hardcoded)
        '(:eval (propertize " " 'display '((space :align-to (- right-fringe 17)))))

        '(:eval (concat (propertize " " 'display arrow-left-2)
                        (propertize " %p " 'face 'mode-line-color-2)))
        '(:eval (concat (propertize " " 'display arrow-left-1)
                        (propertize "%4l:%2c  " 'face 'mode-line-color-1)))
)) 

(make-face 'mode-line-color-0)
(set-face-attribute 'mode-line-color-0 nil
                    :foreground "#fff"
                    :background color0)

(make-face 'mode-line-color-1)
(set-face-attribute 'mode-line-color-1 nil
                    :foreground "#fff"
                    :background color1)

(make-face 'mode-line-color-2)
(set-face-attribute 'mode-line-color-2 nil
                    :foreground "#fff"
                    :background color2)

(set-face-attribute 'mode-line nil
                    :foreground "#fff"
                    :background "#000"
                    :box nil)
(set-face-attribute 'mode-line-inactive nil
                    :foreground "#fff"
                    :background "#000")
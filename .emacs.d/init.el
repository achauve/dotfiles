;; Remove splash screen
(setq inhibit-splash-screen t)

(setq frame-background-mode 'dark)
(set-cursor-color "yellow")
(add-to-list 'default-frame-alist '(background-color . "black"))
(add-to-list 'default-frame-alist '(foreground-color . "light grey"))

(setq kill-whole-line t)
(global-set-key "\M-g" 'goto-line)

(setq-default column-number-mode t)
(windmove-default-keybindings)

(delete-selection-mode 1)

(add-to-list 'default-frame-alist '(foreground-color . "light grey"))

(require 'ido)
(ido-mode t)
(require 'uniquify)

(setq auto-mode-alist (cons '("\\.h$" . c++-mode) auto-mode-alist))

(tool-bar-mode 0)


;;;;;;;;;;;;;;Grep
(defun hg-grep (s)
  (interactive "sSearch project for: ")

  (require 'vc-hg)
  (if (vc-hg-root buffer-file-name)
      ((setq cmd (concat  "hg hgrep \"" s "\" \n"))
       (compilation-start cmd 'grep-mode))
    (vc-git-grep s "*" (vc-git-root buffer-file-name)))
)

(defun hg-grep-region (start end)
  (interactive "r")
  (hg-grep (buffer-substring start end))
)

; keybindings
(global-set-key (quote [f4]) (quote hg-grep))
(global-set-key (quote [C-f4]) (quote hg-grep-region))
;;;;;;;;;;;;;;;;;;;;;;;End grep


;;;;;;;;;;;;;; org-mode
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;;;;;;;;;;;;;;;;;;;;;; bundles

;;;;;; evil
(add-to-list 'load-path "~/.emacs.d/bundle/evil/")
(require 'evil)
(evil-mode 1)

;; evil config


; "jk" is a replacement for ESC
(define-key evil-insert-state-map "j" #'cofi/maybe-exit)
 
(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "j")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?k)
               nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?k))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                          (list evt))))))))

; other shortcuts
(define-key evil-normal-state-map [f5] 'save-buffer) ; save
(define-key evil-insert-state-map [f5] 'save-buffer) ; save


;;;;;; clojure-mode
(add-to-list 'load-path "~/.emacs.d/bundle/clojure-mode/")
(require 'clojure-mode)

;;;;;; paredit
(add-to-list 'load-path "~/.emacs.d/bundle/paredit/")
(require 'paredit)

(defun turn-on-paredit () (paredit-mode 1))
(add-hook 'clojure-mode-hook 'turn-on-paredit)

;;;;;; fsharp-mode
(add-to-list 'load-path "~/.emacs.d/bundle/fsharp/")
(setq auto-mode-alist (cons '("\\.fs[iylx]?$" . fsharp-mode) auto-mode-alist))
(autoload 'fsharp-mode "fsharp" "Major mode for editing F# code." t)
(autoload 'run-fsharp "inf-fsharp" "Run an inferior F# process." t)
(setq inferior-fsharp-program "fsharpi --readline-")
(setq fsharp-compiler "fsharpc")

;;;;;; auto-complete
(add-to-list 'load-path "~/.emacs.d/bundle/auto-complete/")
(setq ac-dictionary-directories '("~/.emacs.d/bundle/auto-complete/dict"))
(require 'auto-complete-config)
(ac-config-default)


;;;;;;;;;;;;;;;;;;;;;; end of bundles


;;;;;;;;;;;;;;;;;
;;; ReST mode
;;;;;;;;;;;;;;;;;
(setq auto-mode-alist
      (append '(("\\.rst$" . rst-mode)
		("\\.rest$" . rst-mode)) auto-mode-alist))



;;;;;;;;;;;;;;;;;;;;;;;;
;; Trailing whitespaces
;;;;;;;;;;;;;;;;;;;;;;;;

(defun toggle-show-trailing-whitespace ()
  (interactive)
  "Toggle show trailing whitespaces."
  (if (equal show-trailing-whitespace nil)
      (setq show-trailing-whitespace t)
    (setq show-trailing-whitespace nil))
  (redraw-display)
)


(global-set-key (kbd "<f1>") 'toggle-show-trailing-whitespace)
(global-set-key (kbd "<f2>") 'delete-trailing-whitespace)

;;;;;;;;;;;;;;;Custom
(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(fill-column 80)
 '(gdb-many-windows t)
 '(grep-command "grep -nHr -e ")
 '(indent-tabs-mode nil)
 '(menu-bar-mode nil)
 '(safe-local-variable-values (quote ((py-indent-offset . 4))))
 '(scroll-bar-mode nil)
 '(show-paren-mode t)
 '(show-trailing-whitespace t)
 '(tab-width 4)
 '(transient-mark-mode t)
 '(uniquify-buffer-name-style (quote post-forward) nil (uniquify))
 '(vc-follow-symlinks nil)
 '(which-function-mode t))
(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(diff-added ((t (:foreground "#559944"))))
 '(diff-context ((t nil)))
 '(diff-file-header ((((class color) (min-colors 88) (background dark)) (:foreground "RoyalBlue1"))))
 '(diff-function ((t (:foreground "#00bbdd"))))
 '(diff-header ((((class color) (min-colors 88) (background dark)) (:foreground "RoyalBlue1"))))
 '(diff-hunk-header ((t (:foreground "#fbde2d"))))
 '(diff-nonexistent ((t (:inherit diff-file-header :strike-through nil))))
 '(diff-refine-change ((((class color) (min-colors 88) (background dark)) (:background "#182042"))))
 '(diff-removed ((t (:foreground "#de1923")))))


;;; Fix junk characters in shell mode
(add-hook 'shell-mode-hook
         'ansi-color-for-comint-mode-on)




;;;;;;; global shortcuts
(global-set-key (kbd "M-z") 'kill-this-buffer)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-n") 'forward-paragraph)
(global-set-key (kbd "M-p") 'backward-paragraph)

(fset 'press-left (kbd "<left>"))
(global-set-key (kbd "M-h") 'press-left)
(fset 'press-right (kbd "<right>"))
(global-set-key (kbd "M-l") 'press-right)
(fset 'press-up (kbd "<up>"))
(global-set-key (kbd "M-j") 'press-up)
(fset 'press-down (kbd "<down>"))
(global-set-key (kbd "M-k") 'press-down)

(global-set-key (kbd "<f1>") 'toggle-show-trailing-whitespace)
(global-set-key (kbd "<f2>") 'delete-trailing-whitespace)

(global-set-key (kbd "C-<f1>") 'delete-other-windows)
(global-set-key (kbd "C-<f2>") 'split-window-vertically)
(global-set-key (kbd "C-<f3>") 'split-window-horizontally)
(global-set-key (quote [f4]) (quote hg-grep))
(global-set-key (quote [C-f4]) (quote hg-grep-region))
(global-set-key (kbd "<f5>") 'compilation-minor-mode)

(global-set-key (kbd "C-<f10>") 'previous-error)
(global-set-key (kbd "C-<f11>") 'next-error)

(global-set-key (kbd "C-M-/") 'comment-dwim)

(global-set-key (kbd "M-é") (lambda () (interactive) (switch-to-buffer "*shell*") ))
(global-set-key (kbd "M-\"") (lambda () (interactive) (switch-to-buffer-other-window "*shell*") ))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;; CPP
;;;

;;;;;;;;;;;;EBrowse
(defun create-ebrowse (dir-name)
  "Create browse file."
  (interactive "DDirectory: ")
  (let (
        (absolute-dir-name (expand-file-name dir-name))
        )
    (shell-command
     (format "find %s -not -path '%s/build-*' -and '(' -name '*.hpp' -or -name '*.h' -or -name '*.cpp' -or -name '*.txx' ')' | ebrowse -o %s/BROWSE" absolute-dir-name absolute-dir-name absolute-dir-name))

    (message (concat "Created ebrowse file in dir " absolute-dir-name))
    )
)

(defun load-ebrowse (dir-name)
  (interactive "DDirectory: ")
  (find-file-noselect (format "%s/BROWSE" dir-name))
  (message (concat "Loaded ebrowse file in dir " dir-name))
)


(defun refresh-ebrowse ()
  (interactive)
  (let (tree-buffer-name tree-file-name tree-buffer tree-dir-name)
    (setq tree-buffer-name "*Tree*")
    (setq tree-buffer (get-buffer tree-buffer-name))
    (if tree-buffer
        (progn
          (setq tree-file-name (buffer-file-name tree-buffer))
          (message (concat "Tree file name: " tree-file-name))
          (kill-buffer (get-buffer tree-buffer-name))
          (setq tree-dir-name (file-name-directory tree-file-name))
          (create-ebrowse tree-dir-name)
          (load-ebrowse tree-dir-name)
          )
        )
    )
)



(defun my-kbd-config ()
  (define-key c-mode-base-map (kbd "C-,") 'ebrowse-back-in-position-stack)
  (define-key c-mode-base-map (kbd "C-;") 'ebrowse-forward-in-position-stack)

  (define-key c-mode-base-map (kbd "C-<f5>") 'ebrowse-tags-find-definition-other-window)
  (define-key c-mode-base-map (kbd "C-<f6>") 'ebrowse-tags-find-declaration-other-window)
  (define-key c-mode-base-map (kbd "M-<f5>") 'ebrowse-tags-find-definition)
  (define-key c-mode-base-map (kbd "M-<f6>") 'ebrowse-tags-find-declaration)

  (define-key c-mode-base-map (kbd "C-<f7>") (lambda () (interactive) (ff-find-other-file 1)))
  (define-key c-mode-base-map (kbd "M-<f7>") 'ff-find-other-file)

  (local-set-key (kbd "C-c b c") 'create-ebrowse)
  (local-set-key (kbd "C-c b l") 'load-ebrowse)

  (local-set-key (kbd "C-<f8>") 'refresh-ebrowse)
  (local-set-key (kbd "C-<f9>") 'compile)
  (local-set-key (kbd "C-<f10>") 'previous-error)
  (local-set-key (kbd "C-<f11>") 'next-error)
  (local-set-key (kbd "C-<f12>") 'gdb)
)


(defun my-c-mode-hook ()
  (my-kbd-config)

  ;;;style
  (setq c-basic-offset 4)
)

(add-hook 'c++-mode-hook 'my-c-mode-hook)




(c-add-style "microsoft"
             '("stroustrup"
               (c-offsets-alist
                (innamespace . -)
                (inline-open . 0)
                ;(inher-cont . c-lineup-multi-inher)
                ;(arglist-cont-nonempty . +)
                (template-args-cont . +))))
(setq c-default-style "microsoft")


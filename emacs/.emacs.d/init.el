;; --- パッケージ設定（MELPAを使えるようにする） ---
(require 'package)
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu"   . "https://elpa.gnu.org/packages/")))
(package-initialize)

;; --- use-package（設定を整理して書くための道具） ---
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

;; --- Evil本体 ---
(use-package evil
  :init
  ;; ここは「Vimっぽさ」を強める定番オプション
  (setq evil-want-integration t
        evil-want-keybinding nil
        evil-want-C-u-scroll t
        evil-want-C-i-jump t)
  :config
  (evil-mode 1))

;; --- Emacs標準機能などにもEvilキーバインドを適用（便利） ---
(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; --- ナビゲーション設定 ---
(use-package which-key
  :config
  (which-key-mode 1))

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
;; 
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
 '(package-selected-packages '(evil-collection grip-mode markdown-mode valign)))
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

;; --- 日本語フォントを Noto Sans CJK JP にする --- 
(set-fontset-font t 'japanese-jisx0208 (font-spec :family "Noto Sans CJK JP"))
(set-fontset-font t 'japanese-jisx0212 (font-spec :family "Noto Sans CJK JP"))
(set-fontset-font t 'katakana-jisx0201 (font-spec :family "Noto Sans CJK JP"))
(set-fontset-font t 'han               (font-spec :family "Noto Sans CJK JP"))

;; ---  起動時に常にタブバーを有効化 --- 
(tab-bar-mode 1)

;; --- 起動時にテーマ適用 ---
(load-theme 'tango-dark t)

;; --- markdown: シンタックスハイライト,見出し及びリンク操作 ---
(use-package markdown-mode
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init
  ;; 見出しの見え方を少しよくする（好みで）
  (setq markdown-fontify-code-blocks-natively t))

;; --- markdown: table format ---
(use-package valign
  :hook ((markdown-mode . valign-mode)))

;; --- markdown: table format ---
(use-package grip-mode
  :commands (grip-mode))

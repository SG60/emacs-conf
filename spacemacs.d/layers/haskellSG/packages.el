(defconst haskellSG-packages
  '(
    lsp-mode
    ;; lsp-ui
    ;; (company-lsp :toggle (configuration-layer/package-usedp 'company))
    haskell-mode
    )
  )

(defun haskellSG/init-lsp-mode ()
  (use-package lsp-mode
    :config
    (progn
      (lsp-define-stdio-client lsp-haskell "haskell"
                               (lambda ()
                                 (condition-case nil
                                       (projectile-project-root)
                                     (error default-directory)))
                               '("hie" "--lsp" "-d" "-l" "/tmp/hie.log")))
    ))

;; (defun haskellSG/post-init-lsp-mode ()
;;   (progn
;;     (lsp-define-stdio-client lsp-haskell-mode "haskell"
;;                              (lambda () (condition-case nil
;;                                             (projectile-project-root)
;;                                           (error default-directory)))
;;                              '("hie" "--lsp" "-d" "-l" "/tmp/hie.log"))
;;     (add-hook 'haskell-mode-hook #'lsp-haskell-mode-enable)))

;; (defun haskellSG/init-company-lsp ()
;;   (use-package company-lsp
;;     :defer t
;;     :init
;;     (push 'company-lsp company-backends-haskell-mode)))

(defun haskellSG/init-haskell-mode ()
  (use-package haskell-mode
    :defer t
    :init
    (with-eval-after-load "lsp-mode"
      (add-hook 'haskell-mode-hook #'lsp-haskell-enable))))

;; (defun haskellSG/init-lsp-ui ()
;;   (use-package lsp-ui
;;     :after lsp-mode
;;     :hook (lsp-mode . lsp-ui-mode)))

;; (lsp-define-stdio-client
;;  ;; This can be a symbol of your choosing. It will be used as a the
;;  ;; prefix for a dynamically generated function "-enable"; in this
;;  ;; case: lsp-prog-major-mode-enable
;;  lsp-prog-major-mode
;;  "language-id"
;;  ;; This will be used to report a project's root directory to the LSP
;;  ;; server.
;;  (lambda () default-directory)
;;  ;; This is the command to start the LSP server. It may either be a
;;  ;; string containing the path of the command, or a list wherein the
;;  ;; car is a string containing the path of the command, and the cdr
;;  ;; are arguments to that command.
;;  '("/my/lsp/server" "and" "args"))

;; ;; Here we'll add the function that was dynamically generated by the
;; ;; call to lsp-define-stdio-client to the major-mode hook of the
;; ;; language we want to run it under.
;; ;;
;; ;; This function will turn lsp-mode on and call the command given to
;; ;; start the LSP server.
;; (add-hook 'prog-major-mode #'lsp-prog-major-mode-enable)

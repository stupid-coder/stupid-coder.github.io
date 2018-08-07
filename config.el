(add-to-list 'load-path "lib/htmlize")

(set-face-foreground 'font-lock-keyword-face "DeepSkyBlue")
(set-face-foreground 'font-lock-string-face "Goldenrod")
(require 'ox-publish)
(require 'htmlize)
;; to have things work correctly in batch-mode
(require 'font-lock)
(require 'cc-mode)
(require 'ox-org)
(c-after-font-lock-init)

(setq make-backup-files nil
      vc-handled-backends nil)

(setq org-export-default-language "zh-CN"
      org-export-html-extension "html"
      org-export-with-timestamps nil
      org-export-with-section-numbers nil
      org-export-with-tags 'not-in-toc
      org-export-skip-text-before-1st-heading nil
      org-export-with-sub-superscripts '{}
      org-export-with-LaTeX-fragments t
      org-export-with-archived-trees nil
      org-export-highlight-first-table-line t
      org-export-latex-listings-w-names nil
      org-html-head-include-default-style nil
      org-html-head ""
      org-export-htmlize-output-type 'css
      org-startup-folded nil
      org-export-allow-BIND t
      org-publish-list-skipped-files t
      org-publish-use-timestamps-flag t
      org-export-babel-evaluate nil
      org-confirm-babel-evaluate nil
      org-export-with-broken-links t)

(setq blog-base "~/Documents/stupid-coder.github.io/")
(setq blog-html-root (concat blog-base "publish/"))
(setq blog-base-directory (concat blog-base "notes/"))
(setq blog-base-code-directory (concat blog-base "codes/"))
(setq blog-base-color-themes-directory (concat blog-base "color-themes/"))
(setq blog-base-images-directory (concat blog-base "images/"))
(setq blog-publish-directory blog-html-root)
(setq blog-publish-code-directory (concat blog-html-root "codes/"))
(setq blog-publish-sources-directory (concat blog-html-root "sources/"))
;; (setq org-publish-use-timestamps-flag nil) ; close the timestamp
(setf org-html-mathjax-options             ; set the mathjax to local
      '((path "/assets/MathJax/MathJax.js")
        (scale "100") (align "center") (indent "2em")
        (mathml nil)))
(defun set-org-publish-project-alist ()
  ""
  (interactive)
  (setq org-publish-project-alist
        `(("stupid-coder-blog" :components ("stupid-coder-sitemap" "stupid-coder-pages" "stupid-coder-code" "stupid-coder-images"))
          ("stupid-coder-pages"
           :base-directory ,blog-base-directory
           :base-extension "org"
           :exclude "FIXME"
           :makeindex t
           :auto-sitemap nil
           :sitemap-ignore-case t
           :html-extension "html"
           :publishing-directory ,blog-publish-directory
           :publishing-function (org-html-publish-to-html) ;; org-org-publish-to-org)
           :htmlized-source t
           :section-numbers nil
           :table-of-contents nil
           :html-head "<link rel=\"stylesheet\" title=\"Standard\" href=\"/assets/worg.css\" type=\"text/css\" />
           <link rel=\"alternate stylesheet\" title=\"Zenburn\" href=\"/assets/worg-zenburn.css\" type=\"text/css\" />
           <link rel=\"alternate stylesheet\" title=\"Classic\" href=\"/assets/worg-classic.css\" type=\"text/css\" />"
           :recursive t
           :html-preamble ""
           :html-postamble "")
          ("stupid-coder-sitemap"
           :base-directory ,blog-base-directory
           :base-extension "org"
           :exclude "FIXME\\|theindex.org\\|index.org"
           :recursive t
           :auto-sitemap t
           :publishing-directory ,blog-publish-directory
           :publishing-function (org-html-publish-to-html)
           :sitemap-ignore-case t
           :sitemap-sort-folders 'last
           :sitemap-sort-files 'anti-chronologically
           :sitemap-title "stupid-coder's blogs"
           :sitemap-file-entry-format "%t %d")
          ("stupid-coder-code"
           :base-directory ,blog-base-code-directory
           :base-extension "html\\|css\\|png\\|js\\|bz2\\|el\\|sty\\|awk\\|pl\\|ss"
           :html-extension "html"
           :publishing-directory ,blog-publish-code-directory
           :recursive t
           :publishing-function org-publish-attachment)
          ("stupid-coder-images"
           :base-directory ,blog-base-directory
           :base-extension "png\\|jpg\\|gif\\|pdf\\|csv\\|css\\|tex"
           :publishing-directory ,blog-publish-directory
           :recursive t
           :publishing-function org-publish-attachment)
          )))

(defun blog-publish nil
  (interactive)
  (set-org-publish-project-alist)
  (org-publish-project "stupid-coder-blog"))

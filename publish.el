;;; publish.el --- Generate a simple static HTML blog
;;; Commentary:
;;
;;    Define the routes of the static website.  Each of which
;;    containing the pattern for finding Org-Mode files, which HTML
;;    template to be used, as well as their output path and URL.
;;
;;; Code:

;; Setup package management
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Install and configure dependencies
(use-package weblorg :ensure t)
(use-package templatel :ensure t)
(use-package htmlize
  :ensure t
  :config
  (setq org-html-htmlize-output-type 'css))

(require 'weblorg)

;; Defaults to localhost:8000
(if (string= (getenv "ENV") "prod")
    (setq weblorg-default-url "https://emacs.love/weblorg-template"))
(if (string= (getenv "ENV") "local")
    (setq weblorg-default-url "http://localhost:8000"))

;; Generate blog posts
(weblorg-route
 :name "posts"
 :input-pattern "src/posts/*.org"
 :template "post.html"
 :output "docs/posts/{{ slug }}.html"
 :url "/posts/{{ slug }}.html")

;; Generate pages
(weblorg-route
 :name "pages"
 :input-pattern "src/pages/*.org"
 :template "page.html"
 :output "docs/{{ slug }}/index.html"
 :url "/{{ slug }}")

;; Generate posts summary
(weblorg-route
 :name "index"
 :input-pattern "src/posts/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "blog.html"
 :output "docs/index.html"
 :url "/")

(weblorg-route
 :name "feed"
 :input-pattern "src/posts/*.org"
 :input-aggregate #'weblorg-input-aggregate-all-desc
 :template "feed.xml"
 :output "docs/feed.xml"
 :url "/feed.xml")

(weblorg-copy-static
 :output "docs/static/{{ file }}"
 :url "/static/{{ file }}")

(weblorg-export)
;;; publish.el ends here

.PHONY: dev build watch

dev:; emacs --script publish.el

deploy:; ENV='prod' emacs --script publish.el

watch:; watch -n 0.1 make

.PHONY: dev build watch

dev:; emacs --script publish.el

build:; ENV='prod' emacs --script publish.el

watch:; watch -n 0.1 make

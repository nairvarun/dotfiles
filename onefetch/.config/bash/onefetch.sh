#!/bin/bash

# disabled-fields: [possible values: project, description, head, pending, version, created, languages, dependencies, authors, last-change, contributors, url, commits, churn, lines-of-code, size, license]

alias onefetch="onefetch \
	--disabled-fields head authors churn size \
	--number-of-languages 9 \
	--text-colors 4 7 7 4 4 7 \
	--number-separator comma \
	--true-color never \
	--image /home/nv/Pictures/onefetch/image.jpeg \
	--image-protocol sixel \
	--no-color-palette \
	--nerd-fonts"

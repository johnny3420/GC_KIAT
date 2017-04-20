#!/bin/bash

file=`ls -d Zero* | sed 's/\.dir//'`

for name in ${file}
	do
	cd ${name}.dir
	faSplit sequence ${name} 100 ${name}_
	cd ..
	done

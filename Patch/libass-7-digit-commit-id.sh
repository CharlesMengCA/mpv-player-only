#!/bin/bash
echo $0 $@
sed -i -e 's/ --abbrev=40//g ; s/ --dirty//g ; s/ --broken//g' configure.ac

#sed -i -e 's/ --abbrev=40//g' configure.ac
#sed -i -e 's/ --dirty//g' configure.ac
#sed -i -e 's/ --broken//g' configure.ac
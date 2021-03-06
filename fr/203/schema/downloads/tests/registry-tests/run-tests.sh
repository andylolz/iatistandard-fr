#!/bin/bash
########################################################################
# Registry record schema tests.
########################################################################

SCHEMA=../../iati-registry-record-schema.xsd
exitcode=0

function fail {
    echo -n '['
    tput setf 4
    echo -n FAIL
    tput setf 0
    echo -n '] '
    echo $1
}

function pass {
    echo -n '['
    tput setf 2
    echo -n PASS
    tput setf 0
    echo -n '] '
    echo $1
}


for f in should-fail/*.xml; do
    xmllint -noout --schema $SCHEMA $f >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        fail $f
        exitcode=1
    else
        pass $f
    fi
done

for f in should-pass/*.xml; do
    xmllint -noout --schema $SCHEMA $f >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        pass $f
    else
        fail $f
        exitcode=1
    fi
done

exit $exitcode

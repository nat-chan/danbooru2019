#!/bin/bash
cat $1|grep '^.*[02468]$' > ${1%.dat}_even.dat
cat $1|grep '^.*[13579]$' > ${1%.dat}_odd.dat

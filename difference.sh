#!/bin/bash
cat $1 $2 $2|sort|uniq -u

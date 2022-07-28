#!/bin/bash
for i in $(seq 100000 100100); do
 dd if=/dev/zero of=tmp/$i bs=$i count=1
done

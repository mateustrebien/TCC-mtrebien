#!/bin/sh
for i in `seq 1 10`;
        do
                perf stat ./qemu/x86_64-linux-user/qemu-x86_64 ./stringsearch/search_small
        done

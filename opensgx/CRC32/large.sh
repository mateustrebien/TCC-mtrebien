#!/bin/sh
for i in `seq 1 10`;
        do
                perf stat ./qemu/x86_64-linux-user/qemu-x86_64 ./CRC32/crc CRC32/large.pcm
        done

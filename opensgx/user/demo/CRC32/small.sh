#!/bin/sh
for i in `seq 1 10`;
        do
                perf stat ./opensgx user/demo/CRC32/crc_32.sgx user/demo/CRC32/crc_32.conf user/demo/CRC32/small.pcm
        done

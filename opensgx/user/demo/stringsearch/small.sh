#!/bin/sh
for i in `seq 1 10`;
        do
                perf stat ./opensgx user/demo/stringsearch/pbmsrch_small.sgx user/demo/stringsearch/pbmsrch_small.conf
        done

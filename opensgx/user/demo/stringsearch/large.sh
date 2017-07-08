#!/bin/sh
for i in `seq 1 2`;
        do
                perf stat ./opensgx user/demo/stringsearch/pbmsrch_large.sgx user/demo/stringsearch/pbmsrch_large.conf
        done

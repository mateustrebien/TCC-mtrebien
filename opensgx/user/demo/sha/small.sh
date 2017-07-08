#!/bin/sh
for i in `seq 1 10`;
        do
                perf stat ./opensgx user/demo/sha/sha_driver.sgx user/demo/sha/sha_driver.conf user/demo/sha/input_small.asc
        done

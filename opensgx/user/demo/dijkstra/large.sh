#!/bin/sh
for i in `seq 1 10`;
        do
                perf stat ./opensgx user/demo/dijkstra/dijkstra_large.sgx user/demo/dijkstra/dijkstra_large.conf user/dijkstra/input.dat
        done

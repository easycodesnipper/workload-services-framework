#!/bin/bash

while [ $(wget --server-response --no-check-certificate http://$IPERF_SERVICE_NAME:80 2>&1 | awk '/ HTTP/{print $2}') -ne 200 ]; do
    echo Waiting...
    sleep 5s
done

/run_iperf.sh
sleep infinity

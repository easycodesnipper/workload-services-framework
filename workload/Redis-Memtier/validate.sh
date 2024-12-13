#!/bin/bash -e
#
# Apache v2 license
# Copyright (C) 2023 Intel Corporation
# SPDX-License-Identifier: Apache-2.0
#

# Testcases overwrite, the exported paras values most significantly 
# except pkm and gated, these two have fixed parameters
if [[ "${TESTCASE}" =~ "pkm"$ ]]; then
    MEMTIER_TEST_TIME=240
elif [[ "${TESTCASE}" =~ "gated"$ ]]; then
    CPU_USED=1
    MEMTIER_REQUESTS=0
    MEMTIER_TEST_TIME=10
    MEMTIER_THREADS=1
    MEMTIER_CLIENTS=1
    RUN_SINGLE_NODE=true
elif [[ "${TESTCASE}" =~ "write"$ ]]; then
    MEMTIER_RATIO=${MEMTIER_RATIO:-"1:0"}
elif [[ "${TESTCASE}" =~ "20read"$ ]]; then
    MEMTIER_RATIO=${MEMTIER_RATIO:-"8:2"}
elif [[ "${TESTCASE}" =~ "50read"$ ]]; then
    MEMTIER_RATIO=${MEMTIER_RATIO:-"1:1"}
elif [[ "${TESTCASE}" =~ "80read"$ ]]; then
    MEMTIER_RATIO=${MEMTIER_RATIO:-"2:8"}
elif [[ "${TESTCASE}" =~ "read"$ ]]; then
    MEMTIER_RATIO=${MEMTIER_RATIO:-"0:1"}
elif [[ "${TESTCASE}" =~ "single_node"$ ]]; then
    RUN_SINGLE_NODE=true
fi

# workload configuration
PLATFROM=${PLATFORM:=SPR}
WORKLOAD=${WORKLOAD:=Redis_Memtier}
TIMEOUT=${TIMEOUT:=3000}
HOST_NETWORK_ENABLE=${HOST_NETWORK_ENABLE:=true}
CONFIG_CENTER_PORT=${CONFIG_CENTER_PORT:=16379}
CPU_USED=${CPU_USED:=1}
START_NUMA_NODE=${START_NUMA_NODE:=0}
CLIENT_COUNT=${CLIENT_COUNT:=1}
RUN_SINGLE_NODE=${RUN_SINGLE_NODE:=false}
REDIS_NUMACTL_STRATEGY=${REDIS_NUMACTL_STRATEGY:=2}
# customer numactl parameters
# customer parameters take effect in single-node scenarios, these two are the most significiant parameters 
# and will overwrite all numa-related parameters. You can set it as using `numactl` dirctly
# e.g. REDIS_SERVER_NUMACTL_OPTIONS="-N 1 -M 1"; MEMTIER_CLIENT_NUMACTL_OPTIONS="-N 0 -M 0"
REDIS_SERVER_NUMACTL_OPTIONS=${REDIS_SERVER_NUMACTL_OPTIONS:=""}
MEMTIER_CLIENT_NUMACTL_OPTIONS=${MEMTIER_CLIENT_NUMACTL_OPTIONS:=""}
### EVENT_TRACE_PARAMS for collecting emon data
EVENT_TRACE_PARAMS="roi,start region of interest,end region of interest"
RPS_TUNE=${RPS_TUNE:=false}

# redis server configuration
REDIS_SERVICE=${REDIS_SERVICE:=redis-server-service}
REDIS_NATIVE_TRANSPORT_PORT=${REDIS_NATIVE_TRANSPORT_PORT:=6379}
SERVER_POD_LEVEL=${SERVER_POD_LEVEL:=""}
SERVER_POD_MEMORY=${SERVER_POD_MEMORY:=""}
SERVER_POD_CPU=${SERVER_POD_CPU:=""}
REDIS_SERVER_IO_THREADS=${REDIS_SERVER_IO_THREADS:=0}
REDIS_SERVER_IO_THREADS_DO_READS=${REDIS_SERVER_IO_THREADS_DO_READS:="false"}
REDIS_PERSISTENCE_POLICY=${REDIS_PERSISTENCE_POLICY:="default"} ## with value of "false/AOF/RDB/default" ##
REDIS_APPENDFSYNC_MODE=${REDIS_APPENDFSYNC_MODE:="everysec"} ## with value of "always/everysec/no" ##
REDIS_RDB_SECONDS=${REDIS_RDB_SECONDS:=60} ## 60
REDIS_RDB_CHANGES=${REDIS_RDB_CHANGES:=1000} ## 1000
REDIS_SERVER_IO_THREADS_CPU_AFFINITY=${REDIS_SERVER_IO_THREADS_CPU_AFFINITY:="false"} ## false or a string, like 0-7:2 ##
REDIS_EVICTION_POLICY=${REDIS_EVICTION_POLICY:="false"} ## false/noeviction/allkeys-lru/volatile-lru/allkeys-random/volatile-random/volatile-ttl

# memtier configuration
MEMTIER_CLIENT_POD_LEVEL=${MEMTIER_CLIENT_POD_LEVEL:=""}
MEMTIER_CLIENT_POD_CPU=${MEMTIER_CLIENT_POD_CPU:=""}
MEMTIER_CONFIG=${MEMTIER_CONFIG:=""}
MEMTIER_NODE=${MEMTIER_NODE:="redis-server-service"}
MEMTIER_UNIX_SOCKET=${MEMTIER_UNIX_SOCKET:=""}
MEMTIER_PROTOCOL=${MEMTIER_PROTOCOL:=""}
MEMTIER_AUTHENTICATE=${MEMTIER_AUTHENTICATE:=""}
MEMTIER_TLS=${MEMTIER_TLS:=""}
MEMTIER_KEY=${MEMTIER_KEY:=""}
MEMTIER_CACERT=${MEMTIER_CACERT:=""}
MEMTIER_TLS_SKIP_VERIFY=${MEMTIER_TLS_SKIP_VERIFY:=""}
MEMTIER_SNI=${MEMTIER_SNI:=""}
MEMTIER_RUN_COUNT=${MEMTIER_RUN_COUNT:=""}
MEMTIER_DEBUG=${MEMTIER_DEBUG:=""}
MEMTIER_CLIENT_STATS=${MEMTIER_CLIENT_STATS:=""}
MEMTIER_OUT_FILE=${MEMTIER_OUT_FILE:=""}
MEMTIER_JSON_OUT_FILE=${MEMTIER_JSON_OUT_FILE:=""}
MEMTIER_HDR_FILE_PREFIX=${MEMTIER_HDR_FILE_PREFIX:=""}
MEMTIER_SHOW_CONFIG=${MEMTIER_SHOW_CONFIG:=""}
MEMTIER_HIDE_HISTOGRAM=${MEMTIER_HIDE_HISTOGRAM:=""}
MEMTIER_PRINT_PERCENTILES=${MEMTIER_PRINT_PERCENTILES:=""}
MEMTIER_CLUSTER_MODE=${MEMTIER_CLUSTER_MODE:=""}
MEMTIER_POPULATE_REQUESTS=${MEMTIER_POPULATE_REQUESTS:=""}
MEMTIER_REQUESTS=${MEMTIER_REQUESTS:=""}
MEMTIER_CLIENTS=${MEMTIER_CLIENTS:=""}
MEMTIER_THREADS=${MEMTIER_THREADS:=""}
MEMTIER_TEST_TIME=${MEMTIER_TEST_TIME:=""}
MEMTIER_RATIO=${MEMTIER_RATIO:=""}
MEMTIER_PIPELINE=${MEMTIER_PIPELINE:=""}
MEMTIER_RECONNECT_INTERVAL=${MEMTIER_RECONNECT_INTERVAL:=""}
MEMTIER_MULTI_KEY_GET=${MEMTIER_MULTI_KEY_GET:=""}
MEMTIER_SELECT_DB=${MEMTIER_SELECT_DB:=""}
MEMTIER_DISTINCT_CLIENT_SEED=${MEMTIER_DISTINCT_CLIENT_SEED:=""}
MEMTIER_RANDOMIZE=${MEMTIER_RANDOMIZE:=""}
MEMTIER_DATA_SIZE=${MEMTIER_DATA_SIZE:=""}
MEMTIER_DATA_OFFSET=${MEMTIER_DATA_OFFSET:=""}
MEMTIER_RANDOM_DATA=${MEMTIER_RANDOM_DATA:=""}
MEMTIER_DATA_SIZE_RANGE=${MEMTIER_DATA_SIZE_RANGE:=""}
MEMTIER_DATA_SIZE_LIST=${MEMTIER_DATA_SIZE_LIST:=""}
MEMTIER_DATA_SIZE_PATTERN=${MEMTIER_DATA_SIZE_PATTERN:=""}
MEMTIER_EXPIRY_RANGE=${MEMTIER_EXPIRY_RANGE:=""}
MEMTIER_DATA_IMPORT=${MEMTIER_DATA_IMPORT:=""}
MEMTIER_DATA_VERIFY=${MEMTIER_DATA_VERIFY:=""}
MEMTIER_VERIFY_ONLY=${MEMTIER_VERIFY_ONLY:=""}
MEMTIER_GENERATE_KEYS=${MEMTIER_GENERATE_KEYS:=""}
MEMTIER_NO_EXPIRY=${MEMTIER_NO_EXPIRY:=""}
MEMTIER_KEY_PREFIX=${MEMTIER_KEY_PREFIX:=""}
MEMTIER_KEY_MINIMUM=${MEMTIER_KEY_MINIMUM:=""}
MEMTIER_KEY_MAXIMUM=${MEMTIER_KEY_MAXIMUM:=""}
MEMTIER_KEY_PATTERN=${MEMTIER_KEY_PATTERN:=""}
MEMTIER_KEY_STDDEV=${MEMTIER_KEY_STDDEV:=""}
MEMTIER_KEY_MEDIAN=${MEMTIER_KEY_MEDIAN:=""}
MEMTIER_WAIT_RATIO=${MEMTIER_WAIT_RATIO:=""}
MEMTIER_NUM_SLAVES=${MEMTIER_NUM_SLAVES:=""}
MEMTIER_WAIT_TIMEOUT=${MEMTIER_WAIT_TIMEOUT:=""}

UBUNTU_OS=${UBUNTU_OS:="2404"}

## sysconfig
CORE_FREQUENCY_ENABLE=${CORE_FREQUENCY_ENABLE:="false"}
CORE_FREQUENCY=${CORE_FREQUENCY:=""}
UNCORE_FREQUENCY_ENABLE=${UNCORE_FREQUENCY_ENABLE:="false"}
UNCORE_FREQUENCY=${UNCORE_FREQUENCY:=""}

# Logs Setting
DIR="$( cd "$( dirname "$0" )" &> /dev/null && pwd )"
. "$DIR/../../script/overwrite.sh"

REDIS_SERVER_NUMACTL_OPTIONS=$(echo $REDIS_SERVER_NUMACTL_OPTIONS | sed 's/[ ][ ]*/+/g')
MEMTIER_CLIENT_NUMACTL_OPTIONS=$(echo $MEMTIER_CLIENT_NUMACTL_OPTIONS | sed 's/[ ][ ]*/+/g')
# K8s topology parameter
let MAX_SKEW=(CPU_USED + CLIENT_COUNT - 1)/CLIENT_COUNT

# image arch
case $PLATFORM in
    ARMv8 | ARMv9 )
        IMAGE_ARCH="-arm64"
        ;;
    MILAN | ROME )
        IMAGE_ARCH=""
        ;; 
    * )
        IMAGE_ARCH=""
        ;;       
esac

# Workload Setting
WORKLOAD_PARAMS=(
RUN_SINGLE_NODE
CLIENT_COUNT
REDIS_SERVER_NUMACTL_OPTIONS
MEMTIER_CLIENT_NUMACTL_OPTIONS
HOST_NETWORK_ENABLE
RPS_TUNE
CONFIG_CENTER_PORT
CPU_USED
START_NUMA_NODE
MAX_SKEW
REDIS_SERVICE
REDIS_NATIVE_TRANSPORT_PORT
SERVER_POD_LEVEL
SERVER_POD_MEMORY
SERVER_POD_CPU
REDIS_NUMACTL_STRATEGY
REDIS_SERVER_IO_THREADS
REDIS_SERVER_IO_THREADS_DO_READS
REDIS_PERSISTENCE_POLICY
REDIS_APPENDFSYNC_MODE
REDIS_RDB_SECONDS
REDIS_RDB_CHANGES
REDIS_SERVER_IO_THREADS_CPU_AFFINITY
REDIS_EVICTION_POLICY
MEMTIER_CLIENT_POD_LEVEL
MEMTIER_CLIENT_POD_CPU
MEMTIER_CONFIG
MEMTIER_NODE
MEMTIER_UNIX_SOCKET
MEMTIER_PROTOCOL
MEMTIER_AUTHENTICATE
MEMTIER_TLS
MEMTIER_KEY
MEMTIER_CACERT
MEMTIER_TLS_SKIP_VERIFY
MEMTIER_SNI
MEMTIER_RUN_COUNT
MEMTIER_DEBUG
MEMTIER_CLIENT_STATS
MEMTIER_OUT_FILE
MEMTIER_JSON_OUT_FILE
MEMTIER_HDR_FILE_PREFIX
MEMTIER_SHOW_CONFIG
MEMTIER_HIDE_HISTOGRAM
MEMTIER_PRINT_PERCENTILES
MEMTIER_CLUSTER_MODE
MEMTIER_POPULATE_REQUESTS
MEMTIER_REQUESTS
MEMTIER_CLIENTS
MEMTIER_THREADS
MEMTIER_TEST_TIME
MEMTIER_RATIO
MEMTIER_PIPELINE
MEMTIER_RECONNECT_INTERVAL
MEMTIER_MULTI_KEY_GET
MEMTIER_SELECT_DB
MEMTIER_DISTINCT_CLIENT_SEED
MEMTIER_RANDOMIZE
MEMTIER_DATA_SIZE
MEMTIER_DATA_OFFSET
MEMTIER_RANDOM_DATA
MEMTIER_DATA_SIZE_RANGE
MEMTIER_DATA_SIZE_LIST
MEMTIER_DATA_SIZE_PATTERN
MEMTIER_EXPIRY_RANGE
MEMTIER_DATA_IMPORT
MEMTIER_DATA_VERIFY
MEMTIER_VERIFY_ONLY
MEMTIER_GENERATE_KEYS
MEMTIER_NO_EXPIRY
MEMTIER_KEY_PREFIX
MEMTIER_KEY_MINIMUM
MEMTIER_KEY_MAXIMUM
MEMTIER_KEY_PATTERN
MEMTIER_KEY_STDDEV
MEMTIER_KEY_MEDIAN
MEMTIER_WAIT_RATIO
MEMTIER_NUM_SLAVES
MEMTIER_WAIT_TIMEOUT
CORE_FREQUENCY_ENABLE
CORE_FREQUENCY
UNCORE_FREQUENCY_ENABLE
UNCORE_FREQUENCY)

if [[ "${TESTCASE}" =~ ^test.*_ubuntu2404.* ]]; then
        UBUNTU_OS="2404"
elif [[ "${TESTCASE}" =~ ^test.*_ubuntu2204.* ]]; then
        UBUNTU_OS="2204"
fi

# Docker Setting
DOCKER_IMAGE=""
DOCKER_OPTIONS=""

# Kubernetes Setting
RECONFIG_OPTIONS="\
-DRUN_SINGLE_NODE=$RUN_SINGLE_NODE \
-DCLIENT_COUNT=$CLIENT_COUNT \
-DREDIS_SERVER_NUMACTL_OPTIONS=$REDIS_SERVER_NUMACTL_OPTIONS \
-DMEMTIER_CLIENT_NUMACTL_OPTIONS=$MEMTIER_CLIENT_NUMACTL_OPTIONS \
-DHOST_NETWORK_ENABLE=$HOST_NETWORK_ENABLE \
-DRPS_TUNE=$RPS_TUNE \
-DCONFIG_CENTER_PORT=$CONFIG_CENTER_PORT \
-DCPU_USED=$CPU_USED \
-DSTART_NUMA_NODE=$START_NUMA_NODE \
-DMAX_SKEW=$MAX_SKEW \
-DREDIS_SERVICE=$REDIS_SERVICE \
-DREDIS_NATIVE_TRANSPORT_PORT=$REDIS_NATIVE_TRANSPORT_PORT \
-DSERVER_POD_LEVEL=$SERVER_POD_LEVEL \
-DSERVER_POD_MEMORY=$SERVER_POD_MEMORY \
-DSERVER_POD_CPU=$SERVER_POD_CPU \
-DREDIS_NUMACTL_STRATEGY=$REDIS_NUMACTL_STRATEGY \
-DREDIS_SERVER_IO_THREADS=$REDIS_SERVER_IO_THREADS \
-DREDIS_SERVER_IO_THREADS_DO_READS=$REDIS_SERVER_IO_THREADS_DO_READS \
-DREDIS_PERSISTENCE_POLICY=$REDIS_PERSISTENCE_POLICY \
-DREDIS_APPENDFSYNC_MODE=$REDIS_APPENDFSYNC_MODE \
-DREDIS_RDB_SECONDS=$REDIS_RDB_SECONDS \
-DREDIS_RDB_CHANGES=$REDIS_RDB_CHANGES \
-DREDIS_SERVER_IO_THREADS_CPU_AFFINITY=$REDIS_SERVER_IO_THREADS_CPU_AFFINITY \
-DREDIS_EVICTION_POLICY=$REDIS_EVICTION_POLICY \
-DMEMTIER_CLIENT_POD_LEVEL=$MEMTIER_CLIENT_POD_LEVEL \
-DMEMTIER_CLIENT_POD_CPU=$MEMTIER_CLIENT_POD_CPU \
-DMEMTIER_CONFIG=$MEMTIER_CONFIG \
-DMEMTIER_NODE=$MEMTIER_NODE \
-DMEMTIER_UNIX_SOCKET=$MEMTIER_UNIX_SOCKET \
-DMEMTIER_PROTOCOL=$MEMTIER_PROTOCOL \
-DMEMTIER_AUTHENTICATE=$MEMTIER_AUTHENTICATE \
-DMEMTIER_TLS=$MEMTIER_TLS \
-DMEMTIER_KEY=$MEMTIER_KEY \
-DMEMTIER_CACERT=$MEMTIER_CACERT \
-DMEMTIER_TLS_SKIP_VERIFY=$MEMTIER_TLS_SKIP_VERIFY \
-DMEMTIER_SNI=$MEMTIER_SNI \
-DMEMTIER_RUN_COUNT=$MEMTIER_RUN_COUNT \
-DMEMTIER_DEBUG=$MEMTIER_DEBUG \
-DMEMTIER_CLIENT_STATS=$MEMTIER_CLIENT_STATS \
-DMEMTIER_OUT_FILE=$MEMTIER_OUT_FILE \
-DMEMTIER_JSON_OUT_FILE=$MEMTIER_JSON_OUT_FILE \
-DMEMTIER_HDR_FILE_PREFIX=$MEMTIER_HDR_FILE_PREFIX \
-DMEMTIER_SHOW_CONFIG=$MEMTIER_SHOW_CONFIG \
-DMEMTIER_HIDE_HISTOGRAM=$MEMTIER_HIDE_HISTOGRAM \
-DMEMTIER_PRINT_PERCENTILES=$MEMTIER_PRINT_PERCENTILES \
-DMEMTIER_CLUSTER_MODE=$MEMTIER_CLUSTER_MODE \
-DMEMTIER_REQUESTS=$MEMTIER_REQUESTS \
-DMEMTIER_POPULATE_REQUESTS=$MEMTIER_POPULATE_REQUESTS \
-DMEMTIER_CLIENTS=$MEMTIER_CLIENTS \
-DMEMTIER_THREADS=$MEMTIER_THREADS \
-DMEMTIER_TEST_TIME=$MEMTIER_TEST_TIME \
-DMEMTIER_RATIO=$MEMTIER_RATIO \
-DMEMTIER_PIPELINE=$MEMTIER_PIPELINE \
-DMEMTIER_RECONNECT_INTERVAL=$MEMTIER_RECONNECT_INTERVAL \
-DMEMTIER_MULTI_KEY_GET=$MEMTIER_MULTI_KEY_GET \
-DMEMTIER_SELECT_DB=$MEMTIER_SELECT_DB \
-DMEMTIER_DISTINCT_CLIENT_SEED=$MEMTIER_DISTINCT_CLIENT_SEED \
-DMEMTIER_RANDOMIZE=$MEMTIER_RANDOMIZE \
-DMEMTIER_DATA_SIZE=$MEMTIER_DATA_SIZE \
-DMEMTIER_DATA_OFFSET=$MEMTIER_DATA_OFFSET \
-DMEMTIER_RANDOM_DATA=$MEMTIER_RANDOM_DATA \
-DMEMTIER_DATA_SIZE_RANGE=$MEMTIER_DATA_SIZE_RANGE \
-DMEMTIER_DATA_SIZE_LIST=$MEMTIER_DATA_SIZE_LIST \
-DMEMTIER_DATA_SIZE_PATTERN=$MEMTIER_DATA_SIZE_PATTERN \
-DMEMTIER_EXPIRY_RANGE=$MEMTIER_EXPIRY_RANGE \
-DMEMTIER_DATA_IMPORT=$MEMTIER_DATA_IMPORT \
-DMEMTIER_DATA_VERIFY=$MEMTIER_DATA_VERIFY \
-DMEMTIER_VERIFY_ONLY=$MEMTIER_VERIFY_ONLY \
-DMEMTIER_GENERATE_KEYS=$MEMTIER_GENERATE_KEYS \
-DMEMTIER_NO_EXPIRY=$MEMTIER_NO_EXPIRY \
-DMEMTIER_KEY_PREFIX=$MEMTIER_KEY_PREFIX \
-DMEMTIER_KEY_MINIMUM=$MEMTIER_KEY_MINIMUM \
-DMEMTIER_KEY_MAXIMUM=$MEMTIER_KEY_MAXIMUM \
-DMEMTIER_KEY_PATTERN=$MEMTIER_KEY_PATTERN \
-DMEMTIER_KEY_STDDEV=$MEMTIER_KEY_STDDEV \
-DMEMTIER_KEY_MEDIAN=$MEMTIER_KEY_MEDIAN \
-DMEMTIER_WAIT_RATIO=$MEMTIER_WAIT_RATIO \
-DMEMTIER_NUM_SLAVES=$MEMTIER_NUM_SLAVES \
-DMEMTIER_WAIT_TIMEOUT=$MEMTIER_WAIT_TIMEOUT \
-DIMAGE_ARCH=${IMAGE_ARCH} \
-DCORE_FREQUENCY_ENABLE=$CORE_FREQUENCY_ENABLE \
-DCORE_FREQUENCY=$CORE_FREQUENCY \
-DUNCORE_FREQUENCY_ENABLE=$UNCORE_FREQUENCY_ENABLE \
-DUNCORE_FREQUENCY=$UNCORE_FREQUENCY"

JOB_FILTER="job-name=benchmark"

. "$DIR/../../script/validate.sh"
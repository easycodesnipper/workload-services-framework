##########################################################################
#                                                                        #
#     Control parameters for SPECjbb2013 benchmark                       #
#                                                                        #
##########################################################################
specjbb.controller.type = {{specjbb_run_type}}

specjbb.controller.rtcurve.start={{specjbb_rt_curve_start}}
specjbb.controller.rtcurve.warmup.step={{specjbb_rt_curve_warmup_step}}
specjbb.forkjoin.workers.Tier1={{specjbb_tier_1_threads}}
specjbb.forkjoin.workers.Tier2={{specjbb_tier_2_threads}}
specjbb.forkjoin.workers.Tier3={{specjbb_tier_3_threads}}
specjbb.group.count={{specjbb_group_count}}
specjbb.comm.connect.client.pool.size={{specjbb_client_pool_size}}
specjbb.comm.connect.selector.runner.count={{specjbb_selector_runner_count}}
specjbb.mapreducer.pool.size={{specjbb_mapreducer_pool_size}}
specjbb.comm.connect.worker.pool.min={{specjbb_worker_pool_min}}
specjbb.comm.connect.worker.pool.max={{specjbb_worker_pool_max}}
specjbb.controller.loadlevel.duration.min = {{specjbb_duration}}
specjbb.controller.loadlevel.duration.max = {{specjbb_duration}}
specjbb.controller.preset.ir={{specjbb_preset_ir}}
specjbb.controller.preset.duration={{specjbb_duration}}


specjbb.controller.loadlevel.start={{specjbb_loadlevel_start}}
specjbb.controller.loadlevel.step={{specjbb_loadlevel_step}}
specjbb.comm.connect.timeouts.connect=600000
specjbb.comm.connect.timeouts.read=600000
specjbb.comm.connect.timeouts.write=600000
specjbb.customerDriver.threads={{specjbb_customer_driver_threads}}
specjbb.customerDriver.threads.saturate={{specjbb_customer_driver_threads_saturate}}
specjbb.customerDriver.threads.probe={{specjbb_customer_driver_threads_probe}}

specjbb.sm.replenish.localPercent={{specjbb_sm_replenish_localpercent}}





#specjbb.controller.maxir.maxFailedPoints=3
#specjbb.controller.rtcurve.maxRetriesOverall=10

#specjbb.customer.RemoteCustomerShare = 0.<<REMOTECS>>
#specjbb.sm.replenish.localPercent = <<LOCALP>>

#specjbb.customer.RemoteCustomerShare = 0.0
#specjbb.sm.replenish.localPercent = 100

#Next two lines for COD disabled and close remote traffic !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# Set remote customer % to 0 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#specjbb.customer.RemoteCustomerShare = 0.0
#Sets replenish amounts to 100 % local !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
#specjbb.sm.replenish.localPercent = 100

#specjbb.customer.RemoteCustomerShare = .2
#specjbb.sm.replenish.localPercent = 95

#specjbb.comm.connect.selector.runner.count=4
#specjbb.comm.connect.timeouts.connect=<<TO>>
#specjbb.comm.connect.timeouts.read=<<TO>>
#specjbb.comm.connect.timeouts.write=<<TO>>
#specjbb.comm.connect.worker.pool.max=<<WPMax>>
#specjbb.comm.connect.worker.pool.min=<<WPMin>>
#specjbb.mapreducer.pool.size=<<MR>>
#specjbb.customerDriver.threads=<<TH1>>
#specjbb.customerDriver.threads.saturate=<<THS>>
#specjbb.customerDriver.threads.probe=<<THP>>



#specjbb.comm.messageOnTier=2
#specjbb.comm.connect.connpool.size = 420
#specjbb.comm.connect.pool.max = 480

#specjbb.comm.connect.timeouts.connect=300000
#specjbb.comm.connect.timeouts.read=300000
#specjbb.comm.connect.timeouts.connect=300000

#specjbb.comm.connect.timeouts.read=300000
#specjbb.comm.connect.timeouts.write=300000
#specjbb.comm.connect.timeouts.write=300000


#specjbb.sm.product.order.property.threshold=90
#specjbb.MinQuantityReplenish=50
#specjbb.MaxQuantityReplenish=500
#specjbb.sm.passed.scan.percent=99



# New props for Elena
#specjbb.comm.messageOnTier=<<SMTHRESHOLD>>
#specjbb.forkjoin.workers.Tier2=<<REPLMAX>>
#specjbb.maxTiers=<<SMPASS>>
#specjbb.forkjoin.workers=<<REPLMIN>>


#specjbb.profiling.mode=NON_INTRUSIVE
#
#specjbb.comm.connect.connpool.size=420
#specjbb.comm.connect.connpool.size=256
#specjbb.comm.connect.pool.max=480
#specjbb.comm.connect.pool.max=256

#
#
#specjbb.customerDriver.threads=64


#  Each parameter is preceded by an explanatory comments section
#  containing the following information:
#   - a short description of the parameter
#   - the default value (used if the parameter is commented out)
#   - the range of compliant values
#   - property propagation specifics
#   - optional additional information on meaning or usage
#   - optional examples of parameter usage.
#
#  Benchmark parameters are actually java properties and may also
#  be passed from command line as -Dproperty=value.
#
#  If a property is set using the launch command line as well as in
#  the property file, launch command has higher priority.
#
#  Most properties are passed by Controller to all agents. These
#  properties only need to be defined in prop files for Controller
#  or at the Controller launch command line.
#
#  Some properties called Controller independent, are not propagated
#  by Controller because other components need these before handshake
#  with the Controller. These properties must be defined in prop file
#  of all components or at the launch command line of these components.
#
#  Rest of the document is organized using following structure:
#  Part-I:  Changeable input parameters for compliant runs
#     Section I:  Properties NOT propagated by Controller
#     Section II: Properties propagated by Controller
#  Part-II: Non-changeable input parameters
#
#  For "Part-I: Changeable input parameters for compliant runs" below,
#  modification of the values to the values outside the compliant ranges,
#  will result in the benchmark runs and results which are not compliant
#  with the benchmark run rules.
#  Information, data or conclusions produced from the runs which are
#  not in compliance with the run rules should not be represented as
#  SPECjbb2013 benchmark results either privately or publicly.
#  It is a violation of your license agreement to do so.
#  Please consult the run rules document for additional
#  requirements for compliant benchmark runs and publication.
#
#  For "Part-II: Non-changeable input parameters", any modification
#  of the values from default will make the run non-compliant.
#  These are advanced options for testing and research purpose ONLY.
#  Only some important properties are listed here.
#  For detailed list and description, refer to
#  Advanced Options and Research section on the SPECjbb2013 website.

##########################################################################
#                                                                        #
#     Part-I: Changeable input parameters for compliant runs             #
#                                                                        #
##########################################################################

##########################################################################
# Section I:                                                             #
# If changing from default, the value should be passed to every          #
# launching component either through property file or command line.      #
# SPECjbb2013-Composite and SPECjbb2013-MultiJVM are run from same dir   #
# using same property file. In this case setting them in just one        #
# property file will work.                                               #
# SPECjbb2013-Distributed runs across OS images and will require these   #
# properties to be set for every launching benchmark component either    #
# from property file or command line.                                    #
##########################################################################

##  Description:     IP address / host name of the machine where Controller program will be launched.
##  Default value:   localhost
##  Compliant value: Any
##  Specifics:       Should be set to the same value for every launching benchmark component either
##                   from property file or command line.
##  Additional:      The value needs updating for the Distributed mode run when Controller is located
##                   outside of the System Under Test.
##  Example value:   192.0.2.1
#specjbb.controller.host=localhost

##  Description:     The network port to which Controller listener will bind.
##  Default value:   24000
##  Compliant value: Any positive integer value
##  Specifics:       Should be set to the same value for every launching benchmark component either
##                   from property file or command line.
##  Example value:   332
#specjbb.controller.port=24000

##  Description:     Network connection pool size, i.e. number of sockets for I/O communication for each Agent.
##  Default value:   256
##  Compliant value: Any positive integer value
##  Specifics:       Should be set for every launching benchmark component either from property file or command line.
##  Additional:      Recommended value is >= specjbb.customerDriver.threads * 3
#specjbb.comm.connect.connpool.size=256

##  Description:     Minimum number of threads in the network connection pool.
##  Default value:   1
##  Compliant value: Any positive integer value
##  Specifics:       Should be set for every launching benchmark component either from property file or command line.
#specjbb.comm.connect.pool.min=1

##  Description:     Maximum number of threads in the network connection pool.
##  Default value:   256
##  Compliant value: Any positive integer value
##  Specifics:       Should be set for every launching benchmark component either from property file or command line.
##  Additional:      Recommended value is >= specjbb.txi.pergroup.count * specjbb.customerDriver.threads * 3 + 10
#specjbb.comm.connect.pool.max=256

##  Description:     Timeout (in milliseconds) for I/O connection operation.
##  Default value:   60*1000
##  Compliant value: Any positive integer value
##  Specifics:       Should be set for every launching benchmark component either from property file or command line.
##  Additional:      The value may need increasing in case of big response or initialization time.
#specjbb.comm.connect.timeouts.connect=60000

##  Description:     Timeout (in milliseconds) for I/O read operation.
##  Default value:   60*1000
##  Compliant value: Any positive integer value
##  Specifics:       Should be set for every launching benchmark component either from property file or command line.
##  Additional:      The value may need increasing in case of big response or initialization time.
#specjbb.comm.connect.timeouts.read=60000

##  Description:     Timeout (in milliseconds) for I/O write operation.
##  Default value:   60*1000
##  Compliant value: Any positive integer value
##  Specifics:       Should be set for every launching benchmark component either from property file or command line.
##  Additional:      The value may need increasing in case of big response or initialization time.
#specjbb.comm.connect.timeouts.write=60000

##########################################################################
# Section II:                                                            #
# If changing from default, user may just update properties file on the  #
# Controller host or update Controller launching command even for the    #
# SPECjbb2013-Distributed run.                                           #
# If needed, user should set these properties on Controller only as      #
# these will be propagated to all agents (TxIs and Backends) correctly.  #
# If user sets these properties on Controller side as well as other      #
# agents, property values set on Controller will override values set on  #
# agents side.
##########################################################################

##  Description:     Number of Groups for the run, where Group is TxInjector(s) mapped to Backend.
##  Default value:   1
##  Compliant value: 1 for Composite mode, any positive integer value otherwise
##  Additional:      Number of Groups actually corresponds to the number of requested Backends
##                   since the only one Backend per Group is allowed for compliant run.
## specjbb.group.count=4

##  Description:     Number of TxInjectors per Backend in one Group.
##  Default value:   1
##  Compliant value: Any positive integer value
##  Additional:      It makes sense to increase this value in case of the [IR is under limit] failure,
##                   which indicates that TxInjector(s) cannot produce the required injection rate.
## specjbb.txi.pergroup.count=1

##  Description:     Maximum number of worker threads in ForkJoinPool in each tier on the Backend side.
##  Default value:   Runtime.getRuntime().availableProcessors()
##  Compliant value: Any positive integer value
##  Additional:      It may be useful to redefine this value when doing multiple Groups run with affinity set for each Group/Backend.
## specjbb.forkjoin.workers=60

##  Description:     Injection rate for warming up before response-time curve building defined as the percent of the high-bound.
##  Default value:   0.1 (means that warm up injection rate is 10% of high-bound)
##  Compliant value: 0.1 <= value <= 0.9, otherwise requires explanation
##  Additional:      Default value may need updating if warm up is not sufficient.
#specjbb.controller.rtcurve.warmup.step=0.1

##  Description:     Number of points to try after max-jOPS was found to ensure there are no more passes and max-jOPS value is correct.
##  Default value:   3
##  Compliant value: Any non-negative integer value
##  Additional:      Reduce this value to avoid System Under Test overloading when trying injection rate exceeding max-jOPS.
##  Example value:   0
#specjbb.controller.maxir.maxFailedPoints=3

##  Description:     Directory for storing binary log file of the run.
##  Default value:   .
##  Compliant value: Any
##  Additional:      The binary log file name is generated automatically.
##  Example value:   /export/users/my/specjbb2013/result1
#specjbb.run.datafile.dir=.

##  Description:     Maximum number of threads in ThreadPoolExecutor for all three probe/saturate/service requests on the TxInjector side.
##  Default value:   64
##  Compliant value: Integer value >= 64
##  Additional:      Setting specjbb.customerDriver.threads= will set for all three of them probe/saturate/service
##                   ThreadPoolExecutors for probe/saturate/service requests may also be controlled separately.
##                   It makes sense to increase the value for probe requests in case 'Number of probes' criteria fails.
##                      For example: specjbb.customerDriver.threads.probe=128
##                   One may also try increasing the value for saturate requests in case of [IR is under limit] failure.
##                      For example: specjbb.customerDriver.threads.saturate=128
##                   Only in rare case, there may be need to increase service requests.
##                      For example: specjbb.customerDriver.threads.service=128
## specjbb.customerDriver.threads.probe=2

##  Description:     Controller ForkJoinPool size supporting parallel work of TxInjector/Backend agents.
##  Default value:   max(Runtime.getRuntime().availableProcessors(), specjbb.group.count * (specjbb.txi.pergroup.count + 1))
##  Compliant value: Any positive integer value
#specjbb.mapreducer.pool.size=2

##  Description:     Timeout (in milliseconds) for initial Controller <-> Agent handshaking.
##  Default value:   600*1000
##  Compliant value: Any positive integer value
##  Additional:      Run will fail if required number of agents are not connected during the specified time
##                   The value may need increasing in case of big number of Agents or slow Agent initialization.
#specjbb.controller.handshake.timeout=600000
#specjbb.controller.handshake.timeout=<<HS>> Agata!!!!!!!!!!!!!!!!!!!!!!!!!!

##  Description:     Time period (in milliseconds) for logging status of the initial Controller <-> Agent handshaking.
##  Default value:   5*1000
##  Compliant value: Any positive integer value
##  Additional:      Increasing the value in case of big number of Agents or its slow initialization may help to reduce Controller out.
#specjbb.controller.handshake.period=5000

##  Description:     How often (in milliseconds) Controller sends heartbeat message to an Agent checking it is alive
##  Default value:   10*1000
##  Compliant value: Any positive integer value
#specjbb.heartbeat.period=10000

##  Description:     How much time (in milliseconds) await for heartbeat response from an Agent.
##  Default value:   100*1000
##  Compliant value: Any positive integer value
##  Additional:      The value may need increasing in case heartbeat error message appears in the log.
##                   and it corresponds to some big pause on Controller or an Agent
#specjbb.heartbeat.threshold=100000

##########################################################################

##########################################################################
# For compliant runs, input parameters below, MUST NOT be changed.       #
#                                                                        #
# All input parameters below, are advanced options which are intended    #
# for testing and research purpose ONLY.                                 #
#                                                                        #
# Note: If a property is propagated by Controller to all agents or       #
#       not propagated, is specified in "property type" field            #
##########################################################################

##########################################################################
#                                                                        #
#     Part-II: Non-changeable input parameters                           #
#                                                                        #
##########################################################################

##  Description:     Controls phases being controlled by Controller.
##  Default value:   HBIR_RT
##  Input values:    HBIR_RT: Finds High Bound IR(HBIR) and builds RT curve
##                   HBIR: Finds only HBIR and exits.
##                   HBIR_RT_LOADLEVELS: Finds HBIR, builds RT curve and then Load levels
##                                       By default 10 load levels as % of max-jOPS
##                                       unless load levels changed using property
##                   PRESET: Takes HBIR set by specjbb.controller.preset.ir and
##                           runs for specjbb.controller.preset.duration milliseconds
##                   FIXED_RT: Takes preset value as HBIR and builds RT curve
##                   FIXED_RT_LOADLEVELS: Take preset value as HBIR, builds RT curve and then load levels
##                   FIXED_LOADLEVELS: Takes preset value as HBIR and performs load levels
##  Note:            Only needed for Controller
#specjbb.controller.type=HBIR_RT

##  Description:     Sets IR for preset for controller type
##                   PRESET, FIXED_RT, FIXED_RT_LOADLEVELS, FIXED_LOADLEVELS
##  Default value:   1000
##  Input values:    Non-negative integer
##  Note:            Only needed for Controller
#specjbb.controller.preset.ir=1000

##  Description:     Sets duration in milliseconds for preset for controller type
##                   PRESET, FIXED_RT, FIXED_RT_LOADLEVELS, FIXED_LOADLEVELS
##  Default value:   600000
##  Input values:    Positive integer
##  Note:            Only needed for Controller
#specjbb.controller.preset.duration=600000

##  Description:     Each RT step level has settle period + steady period
##                   Sets duration of steady period of RT step level in milliseconds
##                   Often steady period ends at min values.
##                   When changing values maintain (max-min=30000)
##  Default value:   min: 60000 , max:90000
##  Input values:    Positive integer
##  Note:            Only needed for Controller
## specjbb.controller.rtcurve.duration.min=300000
## specjbb.controller.rtcurve.duration.max=330000

##  Description:     Each RT step level has settle period + steady period
##                   Sets duration of settle period of RT step level in milliseconds
##                   Often steady period ends at min values.
##                   When changing values maintain (max-min=27000)
##  Default value:   min: 3000 , max:30000
##  Input values:    Positive integer
##  Note:            Only needed for Controller
#specjbb.controller.settle.time.min=3000
#specjbb.controller.settle.time.max=30000

##  Description:     RT curve starts from RT step level of 0% of HBIR and
##                   for next RT step level IR is incremented by % set by 'step'
##                   Both values are float RT step level in milliseconds
##                   Often steady period ends at min values.
##                   When changing values maintain (max-min=27000)
##  Default value:   start: 0 (0% of HBIR) , step= 0.01 (1% of HBIR)
##  Input values:    Float, as example start=0.2 (start from 20% of HBIR)
##                   step=0.05 (increment by 5% of HBIR)
##  Note:            Only needed for Controller
#specjbb.controller.rtcurve.start=0
#specjbb.controller.rtcurve.step=0.01

##  Description:     Total number of customers
##  Default value:   100000
##  Input values:    Positive integer
##  Note:            Controller propagates to all agents
#specjbb.input.number_customers=100000

##  Description:     Number of products in each Supermarket
##  Default value:   100000
##  Input values:    Positive integer
##  Note:            Controller propagates to all agents
#specjbb.input.number_products=100000

##  Description:     Log level output
##  Default value:   INFO
##  Input values:    INFO / FINE
##  Note:            Needed for all agents
#specjbb.logLevel=INFO

##########################################################################
#  Only some important properties are listed above in Part-II.           #
#  For detailed list and description, refer to                           #
#  Advanced Options and Research section on the SPECjbb2013 website.     #
##########################################################################

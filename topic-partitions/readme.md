
Create topic with two partitions 
1. `oc create -f 0-topic.yaml -n kafka`

Deploy producer 

2. `oc create -f 1-dep-kubakp.yaml`

Deploy consumers 

3. `oc create -f 2-dep-kubakc.yaml`

Send some requests, records are load balanced between consumers equally 

Scale up 

4. `oc scale --replicas=3 sts kubakc`

Send some requests, records are load balanced between two consumers, the third consumer doesn't receive any records. 

Add new consumer with different consumer group 

4. `oc create -f 3-dep-kubakc.yaml`
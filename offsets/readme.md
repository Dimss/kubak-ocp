

## Offsets demo
Create a topic 
1. `oc create -f 0-topic.yaml -n kafka`

Deploy producer 

2. `oc create -f 1-dep-kubakp.yaml`

Wait until producer deployed, then deploy `STS` consumers 

3. `oc create -f 2-sts-kubakc.yaml`

Send 4 request from Postman, make sure new squares are appears on http://kubakv/index.html, if all correct,
create `dep` with `earliest` offset

4. `oc create -f 3-dep-kubakc-earliest.yaml`

All records should be replayed, now deploy `dep` with `latest` offset, no new records should appears 

5. `oc create -f 4-dep-kubakc-latest.yaml`

Clean all

```
./clean.sh
oc delete -f 0-topic.yaml
```


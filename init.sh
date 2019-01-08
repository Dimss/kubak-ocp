APP_PROJECT=kubak
KAFKA_PROJECT=kafka

# Create kafka project
oc new-project ${KAFKA_PROJECT}
# Set namespace name for the Kafka operator 
cd kafka && sed -i '' "s/namespace: .*/namespace: ${KAFKA_PROJECT}/" install/cluster-operator/*RoleBinding*.yaml && cd ../
# Create Kafka operator
oc create -f kafka/install/cluster-operator -n ${KAFKA_PROJECT}
# Deploy Kafka cluster
oc create -f kafka/2-kafka-ephemeral.yaml -n ${KAFKA_PROJECT}

# Create new project 
oc new-project ${APP_PROJECT}
oc project kubak
# Allow privilged and anyuuid containeres 
oc adm policy add-scc-to-user anyuid -z default -n ${APP_PROJECT}
oc adm policy add-scc-to-user privileged -z default -n ${APP_PROJECT}
# Create image streams and build configs 
oc create -f init/
#Sync Java IS
sleep 20
# Build docker images 
oc start-build kubakp --follow
oc start-build kubakc --follow
oc start-build kubakv --follow
# Clean build jobs 
oc get pods | awk '{print $1}' | grep build | xargs oc delete pod

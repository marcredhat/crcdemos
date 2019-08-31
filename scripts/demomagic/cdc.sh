########################
. demo-magic.sh

# hide the evidence
clear

p "CodeReady Containers - OpenShift 4.1 - Change Data Capture solution (Debezium, Kafka, AMQ Streams/Strimzi)"

p "Get ClusterIP for MySQL"

pe "oc get svc | grep  mysql"

p "Create Debezium Connector"

pe "cat ./createdebeziumconnector.sh"

pe "./createdebeziumconnector.sh"

p "Update the Customers table by setting email = email101@redhat.com for ID = 1001"

p "Previous emails are email4 and email100"

pe "oc exec -it mysql-2-22h2q -- bash -c 'mysql -u mysqluser  -pmysqlpw  inventory'"

# UPDATE customers SET email="m@redhat.com" WHERE ID = 1001;

# this command is typed and executed

p "Check that Debezium sent the correct before and after values"

pe "cat ./before.sh"

pe "./before.sh"

pe "cat ./after.sh"

pe "./after.sh"

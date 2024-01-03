apply: init
	terraform apply -auto-approve
destroy:
	terraform destroy
init:
	terraform init
output:
	terraform output
deploy:
	./docker-demo/deploy.sh

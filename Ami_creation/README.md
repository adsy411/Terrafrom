Step 1 ==>Need to replace the iam user Access/secret key path
            
            provider "aws" {
                access_key = "${file("`PATH TO FILE`")}"
                secret_key = "${file("`PATH TO FILE`")}"
                region = "${var.region}"
            } 
Step 2 ==>Need to perform terraform init so that it will download the module aws from the global library
            
            `_terraform init_` 
            
Step 3 ==>Need to perform terraform plan so that terrafrom will read .tf scripts and show the plan what resources you are going to use
            
            _`terraform plan`_ 
            
Step 4 ==>Need to perform the final one terraform apply and it will create and user resources according to script

            _`terraform apply`_
            
Step 5 ==>Here you will get the output of you ami image id with name as output you need to copy and store it as separate file, now your provisioned image ready use for k8s cluster, now you have to delete the instance 

            `_terraform destroy_`
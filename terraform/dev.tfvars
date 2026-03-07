region                = "us-east-1"
project_name          = "task-manager-dev"
vpc_cidr              = "10.0.0.0/16"
azs                   = ["us-east-1a", "us-east-1b", "us-east-1c"]
public_subnets        = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
web_private_subnets   = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
app_private_subnets   = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
db_private_subnets    = ["10.0.31.0/24", "10.0.32.0/24", "10.0.33.0/24"]
bastion_ami           = "ami-04b70fa74e45c3917" # Ubuntu 24.04 LTS in us-east-1
bastion_instance_type = "t2.micro"
key_name              = "my-key"
db_username           = "yasindu"
db_password           = "yasindusql"
db_instance_class     = "db.t3.micro"
db_allocated_storage  = 20
sns_topic_arn         = "arn:aws:sns:us-east-1:123456789012:my-topic"
web_image_id          = "ami-04b70fa74e45c3917" # Ubuntu 24.04 LTS in us-east-1
web_instance_type     = "t2.micro"
app_image_id          = "ami-04b70fa74e45c3917" # Ubuntu 24.04 LTS in us-east-1
app_instance_type     = "t2.micro"
web_user_data_base64  = "IyEvYmluL2Jhc2gKZWNobyAnV2ViIHNlcnZlciBydW5uaW5nJyA+IC90bXAvd2ViLnR4dAo="
app_user_data_base64  = "IyEvYmluL2Jhc2gKZWNobyAnQXBwIHNlcnZlciBydW5uaW5nJyA+IC90bXAvYXBwLnR4dAo="


region                = "eu-north-1"
project_name          = "task-manager-dev"
vpc_cidr              = "10.0.0.0/16"
azs                   = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
public_subnets        = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
web_private_subnets   = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
app_private_subnets   = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
db_private_subnets    = ["10.0.31.0/24", "10.0.32.0/24", "10.0.33.0/24"]
bastion_ami           = "ami-073130f74f5ffb161" # Ubuntu 24.04 LTS in eu-north-1
bastion_instance_type = "t3.micro"
key_name              = "3-tier-key"
db_username           = "yasindu"
db_password           = "yasindusql"
db_instance_class     = "db.t3.micro"
db_allocated_storage  = 20
sns_topic_arn         = "arn:aws:sns:eu-north-1:697568497825:3-tier-sns"
web_image_id          = "ami-073130f74f5ffb161" # Ubuntu 24.04 LTS in eu-north-1
web_instance_type     = "t3.micro"
app_image_id          = "ami-073130f74f5ffb161" # Ubuntu 24.04 LTS in eu-north-1
app_instance_type     = "t3.micro"
web_user_data_base64  = "IyEvYmluL2Jhc2gKYXB0LWdldCB1cGRhdGUgLXkKYXB0LWdldCBpbnN0YWxsIC15IG5naW54IGF3c2NsaQoKc3lzdGVtY3RsIHN0YXJ0IG5naW54CnN5c3RlbWN0bCBlbmFibGUgbmdpbngKCmF3cyBzMyBjcCBzMzovLzMtdGllci1zMy1idWNrZXQteWFzYS9mcm9udGVuZC8gL3Zhci93d3cvaHRtbC8gLS1yZWN1cnNpdmUKCmZpbmQgL3Zhci93d3cvaHRtbC8gLXR5cGUgZiAtbmFtZSAiKi5qcyIgLWV4ZWMgc2VkIC1pICJzfF9fQVBQX0FMQl9ETlNfX3xfX0FQUF9BTEJfRE5TX198ZyIge30gKwoKc3lzdGVtY3RsIHJlc3RhcnQgbmdpbng="
app_user_data_base64  = "IyEvYmluL2Jhc2gKYXB0LWdldCB1cGRhdGUgLXkKYXB0LWdldCBpbnN0YWxsIC15IG9wZW5qZGstMTctamRrIGF3c2NsaQoKYXdzIHMzIGNwIHMzOi8vMy10aWVyLXMzLWJ1Y2tldC15YXNhL2JhY2tlbmQvYXBwLmphciAvaG9tZS91YnVudHUvYXBwLmphcgoKZXhwb3J0IERCX1VSTD0iamRiYzpteXNxbDovL19fREJfRU5EUE9JTlRfXzozMzA2L3Rhc2tfbWFuYWdlcj9jcmVhdGVEYXRhYmFzZUlmTm90RXhpc3Q9dHJ1ZSZ1c2VTU0w9ZmFsc2UmYWxsb3dQdWJsaWNLZXlSZXRyaWV2YWw9dHJ1ZSIKZXhwb3J0IERCX1VTRVI9Il9fREJfVVNFUl9fIgpleHBvcnQgREJfUEFTUz0iX19EQl9QQVNTX18iCgpub2h1cCBqYXZhIC1qYXIgL2hvbWUvdWJ1bnR1L2FwcC5qYXIgPiAvaG9tZS91YnVudHUvYXBwLmxvZyAyPiYxICY="


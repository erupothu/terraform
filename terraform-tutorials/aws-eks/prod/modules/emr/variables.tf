# variable "region" {
#   type        = string
#   description = "AWS region"
#   default =  "ap-south-1"
# }

# variable "name" {
#   type        = string
#   default = "emr-cluster"
#   description = "EMR Cluster Name (cluster_name)"
# }

# variable "stage" {
#   type        = string
#   default = "test"
#   description = "EMR Cluster Stage (test)"
# }

# variable "namespace" {
#   type        = string
#   default = "eg"
#   description = "EMR Cluster Namespace (eg)"
# }

# variable "availability_zones" {
#   type        = list(string)
#   default = ["ap-south-1a","ap-south-1b","ap-south-1c"]
#   description = "List of availability zones"
# }

# variable "ebs_root_volume_size" {
#   type        = number
#   default = 20
#   description = "Size in GiB of the EBS root device volume of the Linux AMI that is used for each EC2 instance. Available in Amazon EMR version 4.x and later"
# }

# variable "visible_to_all_users" {
#   type        = bool
#   default = true
#   description = "Whether the job flow is visible to all IAM users of the AWS account associated with the job flow"
# }

# variable "release_label" {
#   type        = string
#   default = "emr-6.1.0"
#   description = "The release label for the Amazon EMR release (emr-6.1.0). https://docs.aws.amazon.com/emr/latest/ReleaseGuide/emr-release-5x.html"
# }

# variable "applications" {
#   type        = list(string)
#   default = ["Spark","Hive", "Presto", "Hadoop"]
#   description = "A list of applications for the cluster. Valid values are: Flink, Ganglia, Hadoop, HBase, HCatalog, Hive, Hue, JupyterHub, Livy, Mahout, MXNet, Oozie, Phoenix, Pig, Presto, Spark, Sqoop, TensorFlow, Tez, Zeppelin, and ZooKeeper (as of EMR 5.25.0). Case insensitive"
# }

# variable "configurations_json" {
#   type        = string
#   description = "A JSON string for supplying list of configurations for the EMR cluster"
#   default     = <<EOF
#   [
#     {
#       "Classification": "hadoop-env",
#       "Configurations": [
#         {
#           "Classification": "export",
#           "Properties": {
#             "JAVA_HOME": "/usr/lib/jvm/java-1.8.0"
#           }
#         }
#       ],
#       "Properties": {}
#     },
#     {
#       "Classification": "spark-env",
#       "Configurations": [
#         {
#           "Classification": "export",
#           "Properties": {
#             "JAVA_HOME": "/usr/lib/jvm/java-1.8.0"
#           }
#         }
#       ],
#       "Properties": {}
#     }
#   ]
# EOF
# }

# variable "core_instance_group_instance_type" {
#   type        = string
#   default = "m4.large"
#   description = "EC2 instance type for all instances in the Core instance group"
# }

# variable "core_instance_group_instance_count" {
#   type        = number
#   default = 1
#   description = "Target number of instances for the Core instance group. Must be at least 1"
# }

# variable "core_instance_group_ebs_size" {
#   type        = number
#   default = 1
#   description = "Core instances volume size, in gibibytes (GiB)"
# }

# variable "core_instance_group_ebs_type" {
#   type        = string
#   default = "gp2"
#   description = "Core instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1`"
# }

# variable "core_instance_group_ebs_volumes_per_instance" {
#   type        = number
#   default = 1
#   description = "The number of EBS volumes with this configuration to attach to each EC2 instance in the Core instance group"
# }

# variable "master_instance_group_instance_type" {
#   type        = string
#   default = "m4.large"
#   description = "EC2 instance type for all instances in the Master instance group"
# }

# variable "master_instance_group_instance_count" {
#   type        = number
#   default = 1
#   description = "Target number of instances for the Master instance group. Must be at least 1"
# }

# variable "master_instance_group_ebs_size" {
#   type        = number
#   default = 20
#   description = "Master instances volume size, in gibibytes (GiB)"
# }

# variable "master_instance_group_ebs_type" {
#   type        = string
#   default = "gp2"
#   description = "Master instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1`"
# }

# variable "master_instance_group_ebs_volumes_per_instance" {
#   type        = number
#   default = 1
#   description = "The number of EBS volumes with this configuration to attach to each EC2 instance in the Master instance group"
# }

# variable "create_task_instance_group" {
#   type        = bool
#   default = false
#   description = "Whether to create an instance group for Task nodes. For more info: https://www.terraform.io/docs/providers/aws/r/emr_instance_group.html, https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-master-core-task-nodes.html"
# }

# variable "ssh_public_key_path" {
#   type        = string
#   default = "/secrets"
#   description = "Path to SSH public key directory (e.g. `/secrets`)"
# }

# variable "generate_ssh_key" {
#   type        = bool
#   default = true
#   description = "If set to `true`, new SSH key pair will be created"
# }
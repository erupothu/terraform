variable "project" {
  default = "emr-automation"
}
variable "environment" {
  description = "Dev/Prod/Stage"
  default = "dev"
}


variable "name" {
  description = "Name of the EMR cluster to be created"
  default = "Terraform-Automation"
  }


variable "step_concurrency_level" {
  default = 1
  }
variable "release_label" {
  description = "EMR Version"
  default = "emr-6.2.0"
}
variable "autoscaling_role" {
  default = "arn:aws:iam::470702883802:role/aws-service-role/autoscaling.amazonaws.com/AWSServiceRoleForAutoScaling"
  
}
variable "applications" {
  type    = list(string)
  description = "Name the applications to be installed"
  default = [ "Hadoop",
              "Hive",
              "Hue",
              "JupyterHub",
              "Pig",
              "Presto",
              "Spark"]
  
}
#------------------------------Master Instance Group------------------------------
variable "master_instance_group_name" {
  type        = string
  description = "Name of the Master instance group"
  default = "MasterGroup"
}
variable "master_instance_group_instance_type" {
  type        = string
  description = "EC2 instance type for all instances in the Master instance group"
  default = "m4.large"
}


variable "master_instance_group_instance_count" {
  type        = number
  description = "Target number of instances for the Master instance group. Must be at least 1"
  default     = 1
}


variable "master_instance_group_ebs_size" {
  type        = number
  description = "Master instances volume size, in gibibytes (GiB)"
  default = 30
}


variable "master_instance_group_ebs_type" {
  type        = string
  description = "Master instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1`"
  default     = "gp2"
}


variable "master_instance_group_ebs_iops" {
  type        = number
  description = "The number of I/O operations per second (IOPS) that the Master volume supports"
  default     = null
}


variable "master_instance_group_ebs_volumes_per_instance" {
  type        = number
  description = "The number of EBS volumes with this configuration to attach to each EC2 instance in the Master instance group"
  default     = 1
}


variable "master_instance_group_bid_price" {
  type        = string
  description = "Bid price for each EC2 instance in the Master instance group, expressed in USD. By setting this attribute, the instance group is being declared as a Spot Instance, and will implicitly create a Spot request. Leave this blank to use On-Demand Instances"
  default     = 0.3
}
#----------------------Core Instance Group-----------------------------------#
variable "core_instance_group_name" {
  type        = string
  description = "Name of the Master instance group"
  default = "CoreGroup"
}


variable "core_instance_group_instance_type" {
  type        = string
  description = "EC2 instance type for all instances in the Core instance group"
  default = "m4.large"
}


variable "core_instance_group_instance_count" {
  type        = number
  description = "Target number of instances for the Core instance group. Must be at least 1"
  default     = 1
}


variable "core_instance_group_ebs_size" {
  type        = number
  description = "Core instances volume size, in gibibytes (GiB)"
  default = 30
}


variable "core_instance_group_ebs_type" {
  type        = string
  description = "Core instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1`"
  default     = "gp2"
}


variable "core_instance_group_ebs_iops" {
  type        = number
  description = "The number of I/O operations per second (IOPS) that the Core volume supports"
  default     = null
}


variable "core_instance_group_ebs_volumes_per_instance" {
  type        = number
  description = "The number of EBS volumes with this configuration to attach to each EC2 instance in the Core instance group"
  default     = 1
}


variable "core_instance_group_bid_price" {
  type        = string
  description = "Bid price for each EC2 instance in the Core instance group, expressed in USD. By setting this attribute, the instance group is being declared as a Spot Instance, and will implicitly create a Spot request. Leave this blank to use On-Demand Instances"
  default     = 0.3
}


variable "core_instance_group_autoscaling_policy" {
  type        = string
  description = "String containing the EMR Auto Scaling Policy JSON for the Core instance group"
  default     = "./additional_files/core_instance_group-autoscaling_policy.json.tpl"
}


#-----------------Task Instance Group----------------
variable "task_instance_group_name" {
  type        = string
  description = "Name of the Master instance group"
  default = "taskGroup"
}


variable "task_instance_group_instance_type" {
  type        = string
  description = "EC2 instance type for all instances in the task instance group"
  default = "m5.xlarge"
}


variable "task_instance_group_instance_count" {
  type        = number
  description = "Target number of instances for the task instance group. Must be at least 1"
  default     = 1
}


variable "task_instance_group_ebs_size" {
  type        = number
  description = "task instances volume size, in gibibytes (GiB)"
  default = 30
}


variable "task_instance_group_ebs_type" {
  type        = string
  description = "task instances volume type. Valid options are `gp2`, `io1`, `standard` and `st1`"
  default     = "gp2"
}


variable "task_instance_group_ebs_iops" {
  type        = number
  description = "The number of I/O operations per second (IOPS) that the task volume supports"
  default     = null
}


variable "task_instance_group_ebs_volumes_per_instance" {
  type        = number
  description = "The number of EBS volumes with this configuration to attach to each EC2 instance in the task instance group"
  default     = 1
}


variable "task_instance_group_bid_price" {
  type        = string
  description = "Bid price for each EC2 instance in the task instance group, expressed in USD. By setting this attribute, the instance group is being declared as a Spot Instance, and will implicitly create a Spot request. Leave this blank to use On-Demand Instances"
  default     = 0.3
}


variable "task_instance_group_autoscaling_policy" {
  type        = string
  description = "String containing the EMR Auto Scaling Policy JSON for the task instance group"
  default = "./additional_files/task_instance_group-autoscaling_policy.json.tpl"
}
#-------------------------------------------------------------------------------#


variable "key_name" {
  default = "key-pair-name"
  }
variable "subnet_id" {
  default = "subnet-08fe57afe749296f2"
  }
variable "instance_profile" {
  default =  "arn:aws:iam::470702883802:instance-profile/EMR_EC2_DefaultRole"
  }
variable "service_access_security_group"{
  default =  "eg-test-emr-cluster-master"
  }
  
variable "emr_managed_master_security_group" {
  default = "sg-002f04051bcba17bc"
  }
variable "emr_managed_slave_security_group" {
  default = "sg-002f04051bcba17bc"
  }
variable "service_role" {
  default = "arn:aws:iam::470702883802:role/EMR_DefaultRole"
  }
variable "configurations_json" {
  type        = string
  description = "A JSON string for supplying list of configurations for the EMR cluster"
  default = "./additional_files/configuration.json.tpl"
}  

variable "log_uri" {
  default = "s3://emr-automation/emr-logs/"
  }
variable "steps" {
  type        = string
  description = "Steps to execute after creation of EMR"
  default = "./additional_files/steps.json.tpl"
  
}
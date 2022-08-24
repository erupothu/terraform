   [
    {
      "action_on_failure" : "CONTINUE",
      "hadoop_jar_step" : 
        {
          "jar" : "command-runner.jar",  
          "args" : [
            "spark-submit",
            "s3://vaya-emr-automation/code/required-jars.jar"
          ]
        },      
      "name" : "Custom Jars"
    }
]
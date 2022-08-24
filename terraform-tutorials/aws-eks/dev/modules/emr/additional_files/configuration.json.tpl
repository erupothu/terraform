[
    {
    "classification":"emrfs-site", 
    "properties":{"fs.s3.consistent.retryPeriodSeconds":"10", "fs.s3.consistent":"true", "fs.s3.consistent.retryCount":"5", "fs.s3.consistent.metadata.tableName":"EmrFSMetadata"}, "configurations":[]
    },
    {
    "classification":"spark", 
    "properties":{"maximizeResourceAllocation":"true"}, 
    "configurations":[]
    },
    {
    "classification":"hive-site", 
    "properties":{"hive.metastore.client.factory.class":"com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory"}, 
    "configurations":[]
    },
    {
    "classification":"presto-connector-hive", 
    "properties":{"hive.metastore.glue.datacatalog.enabled":"true"}, 
    "configurations":[]
    },
    {
    "classification":"spark-hive-site", 
    "properties":{"hive.metastore.client.factory.class":"com.amazonaws.glue.catalog.metastore.AWSGlueDataCatalogHiveClientFactory"}, 
    "configurations":[]
    },
    {
    "Classification": "hadoop-env", 
            "Configurations": [
                {
                    "Classification": "export", 
                    "Configurations": [], 
                    "Properties": {"JAVA_HOME": "/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64/"}
                }
            ], 
            "Properties": {}
    },
    {
            "Classification": "spark-env", 
            "Configurations": [
                {
                    "Classification": "export", 
                    "Configurations": [], 
                    "Properties": {"JAVA_HOME": "/usr/lib/jvm/java-1.8.0-amazon-corretto.x86_64/"}
                }
            ], 
            "Properties": {}
    }
    ]
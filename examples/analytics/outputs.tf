#==============================================================================
# ANALYTICS OUTPUTS
#==============================================================================

output "module_names" {
  description = "Module names included in this example"
  value = [
    "athena",
    "clean_rooms",
    "data_exchange",
    "data_pipeline",
    "datazone",
    "emr",
    "firehose",
    "flink",
    "glue",
    "kinesis",
    "lake_formation",
    "msk",
    "opensearch",
    "quicksight",
  ]
}

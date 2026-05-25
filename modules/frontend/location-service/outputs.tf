#==============================================================================
# LOCATION SERVICE OUTPUTS
#==============================================================================

output "map_arns" {
  description = "Map of Location Service map ARNs"
  value       = { for k, v in aws_location_map.this : k => v.arn }
}

output "place_index_arns" {
  description = "Map of Location Service place index ARNs"
  value       = { for k, v in aws_location_place_index.this : k => v.arn }
}

output "route_calculator_arns" {
  description = "Map of Location Service route calculator ARNs"
  value       = { for k, v in aws_location_route_calculator.this : k => v.arn }
}

output "tracker_arns" {
  description = "Map of Location Service tracker ARNs"
  value       = { for k, v in aws_location_tracker.this : k => v.arn }
}

output "geofence_collection_arns" {
  description = "Map of Location Service geofence collection ARNs"
  value       = { for k, v in aws_location_geofence_collection.this : k => v.arn }
}

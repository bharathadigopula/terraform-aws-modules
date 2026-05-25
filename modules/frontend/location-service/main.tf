#==============================================================================
# LOCATION SERVICE MAPS
#==============================================================================

resource "aws_location_map" "this" {
  for_each = { for map in var.maps : map.name => map }

  map_name    = each.value.name
  description = each.value.description
  tags        = merge(var.tags, each.value.tags)

  configuration {
    style = each.value.style
  }
}

#==============================================================================
# LOCATION SERVICE PLACE INDEXES
#==============================================================================

resource "aws_location_place_index" "this" {
  for_each = { for index in var.place_indexes : index.name => index }

  index_name  = each.value.name
  data_source = each.value.data_source
  description = each.value.description
  tags        = merge(var.tags, each.value.tags)

  dynamic "data_source_configuration" {
    for_each = each.value.intended_use != null ? [each.value.intended_use] : []

    content {
      intended_use = data_source_configuration.value
    }
  }
}

#==============================================================================
# LOCATION SERVICE ROUTE CALCULATORS
#==============================================================================

resource "aws_location_route_calculator" "this" {
  for_each = { for calculator in var.route_calculators : calculator.name => calculator }

  calculator_name = each.value.name
  data_source     = each.value.data_source
  description     = each.value.description
  tags            = merge(var.tags, each.value.tags)
}

#==============================================================================
# LOCATION SERVICE TRACKERS
#==============================================================================

resource "aws_location_tracker" "this" {
  for_each = { for tracker in var.trackers : tracker.name => tracker }

  tracker_name       = each.value.name
  description        = each.value.description
  kms_key_id         = each.value.kms_key_id
  position_filtering = each.value.position_filtering
  tags               = merge(var.tags, each.value.tags)
}

#==============================================================================
# LOCATION SERVICE GEOFENCE COLLECTIONS
#==============================================================================

resource "aws_location_geofence_collection" "this" {
  for_each = { for collection in var.geofence_collections : collection.name => collection }

  collection_name = each.value.name
  description     = each.value.description
  kms_key_id      = each.value.kms_key_id
  tags            = merge(var.tags, each.value.tags)
}

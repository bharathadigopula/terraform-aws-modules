#==============================================================================
# REKOGNITION COLLECTIONS
#==============================================================================

resource "aws_rekognition_collection" "this" {
  for_each = { for collection in var.collections : collection.collection_id => collection }

  collection_id = each.value.collection_id
  tags          = merge(var.tags, each.value.tags)
}

#==============================================================================
# REKOGNITION PROJECTS
#==============================================================================

resource "aws_rekognition_project" "this" {
  for_each = { for project in var.projects : project.name => project }

  name        = each.value.name
  feature     = each.value.feature
  auto_update = each.value.auto_update
  tags        = merge(var.tags, each.value.tags)
}

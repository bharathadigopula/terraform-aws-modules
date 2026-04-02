#==============================================================================
# LOCAL VALUES
#==============================================================================

locals {
  nat_gateway_count = var.enable_nat_gateway ? (
    var.single_nat_gateway ? 1 : (
      var.one_nat_gateway_per_az ? length(var.public_subnet_availability_zones) : length(var.private_subnets)
    )
  ) : 0
}

#==============================================================================
# PUBLIC SUBNETS
#==============================================================================

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id                  = var.vpc_id
  cidr_block              = var.public_subnets[count.index]
  availability_zone       = element(var.public_subnet_availability_zones, count.index)
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = merge(
    var.tags,
    var.public_subnet_tags,
    {
      Name = length(var.public_subnet_names) > 0 ? var.public_subnet_names[count.index] : "${var.name}-public-${element(var.public_subnet_availability_zones, count.index)}"
      Tier = "public"
    }
  )
}

#==============================================================================
# PRIVATE SUBNETS
#==============================================================================

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id            = var.vpc_id
  cidr_block        = var.private_subnets[count.index]
  availability_zone = element(var.private_subnet_availability_zones, count.index)

  tags = merge(
    var.tags,
    var.private_subnet_tags,
    {
      Name = length(var.private_subnet_names) > 0 ? var.private_subnet_names[count.index] : "${var.name}-private-${element(var.private_subnet_availability_zones, count.index)}"
      Tier = "private"
    }
  )
}

#==============================================================================
# DATABASE SUBNETS
#==============================================================================

resource "aws_subnet" "database" {
  count = length(var.database_subnets)

  vpc_id            = var.vpc_id
  cidr_block        = var.database_subnets[count.index]
  availability_zone = element(var.database_subnet_availability_zones, count.index)

  tags = merge(
    var.tags,
    var.database_subnet_tags,
    {
      Name = length(var.database_subnet_names) > 0 ? var.database_subnet_names[count.index] : "${var.name}-database-${element(var.database_subnet_availability_zones, count.index)}"
      Tier = "database"
    }
  )
}

resource "aws_db_subnet_group" "this" {
  count = length(var.database_subnets) > 0 && var.create_database_subnet_group ? 1 : 0

  name        = var.database_subnet_group_name != "" ? var.database_subnet_group_name : "${var.name}-db-subnet-group"
  description = "Database subnet group for ${var.name}"
  subnet_ids  = aws_subnet.database[*].id

  tags = merge(
    var.tags,
    { Name = var.database_subnet_group_name != "" ? var.database_subnet_group_name : "${var.name}-db-subnet-group" }
  )
}

#==============================================================================
# PUBLIC ROUTE TABLE
#==============================================================================

resource "aws_route_table" "public" {
  count = length(var.public_subnets) > 0 ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    { Name = "${var.name}-public-rt" }
  )
}

resource "aws_route" "public_internet" {
  count = length(var.public_subnets) > 0 && var.igw_id != "" ? 1 : 0

  route_table_id         = aws_route_table.public[0].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = var.igw_id
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public[0].id
}

#==============================================================================
# PRIVATE ROUTE TABLES
#==============================================================================

resource "aws_route_table" "private" {
  count = length(var.private_subnets) > 0 ? local.nat_gateway_count > 0 ? local.nat_gateway_count : 1 : 0

  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    { Name = local.nat_gateway_count > 1 ? "${var.name}-private-rt-${count.index}" : "${var.name}-private-rt" }
  )
}

resource "aws_route_table_association" "private" {
  count = length(var.private_subnets)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = element(aws_route_table.private[*].id, var.single_nat_gateway ? 0 : count.index)
}

#==============================================================================
# DATABASE ROUTE TABLE
#==============================================================================

resource "aws_route_table" "database" {
  count = length(var.database_subnets) > 0 ? 1 : 0

  vpc_id = var.vpc_id

  tags = merge(
    var.tags,
    { Name = "${var.name}-database-rt" }
  )
}

resource "aws_route_table_association" "database" {
  count = length(var.database_subnets)

  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database[0].id
}

#==============================================================================
# ELASTIC IPS FOR NAT GATEWAYS
#==============================================================================

resource "aws_eip" "nat" {
  count = local.nat_gateway_count

  domain = "vpc"

  tags = merge(
    var.tags,
    { Name = local.nat_gateway_count > 1 ? "${var.name}-nat-eip-${count.index}" : "${var.name}-nat-eip" }
  )
}

#==============================================================================
# NAT GATEWAYS
#==============================================================================

resource "aws_nat_gateway" "this" {
  count = local.nat_gateway_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    var.tags,
    { Name = local.nat_gateway_count > 1 ? "${var.name}-nat-${count.index}" : "${var.name}-nat" }
  )

  depends_on = [aws_subnet.public]
}

resource "aws_route" "private_nat" {
  count = var.enable_nat_gateway ? length(var.private_subnets) > 0 ? local.nat_gateway_count : 0 : 0

  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.this[*].id, count.index)
}

<!--
==============================================================================
TERRAFORM AWS MODULES README
==============================================================================
-->

# Terraform AWS Modules

Reusable Terraform modules for AWS infrastructure patterns used by the DevOps platform portfolio.

These modules are designed to be consumed by blueprint repositories, examples, and production-style platform implementations.

## Module Source Format

<!--
==============================================================================
MODULE SOURCE FORMAT
==============================================================================
-->

Use release tags when consuming modules from this repository.

```hcl
module "vpc" {
  source = "git::https://github.com/bharathadigopula/terraform-aws-modules.git//modules/networking/vpc?ref=v0.1.0"

  name       = "example-dev"
  cidr_block = "10.42.0.0/16"
}
```

## Release Tags

<!--
==============================================================================
RELEASE TAGS
==============================================================================
-->

This repository uses one release tag for the full module set.

```text
v0.1.0
```

Do not use individual module tags such as:

```text
vpc-v0.1.0
ecs-service-v0.1.0
iam-v0.1.0
```

A single repo-level tag keeps all modules on the same tested snapshot.

## Versioning Policy

<!--
==============================================================================
VERSIONING POLICY
==============================================================================
-->

Use semantic versioning at the repository level.

```text
Patch: bug fix without input or output changes
Minor: backward-compatible module feature
Major: breaking variable, output, behavior, or default change
```

Examples:

```text
v0.1.1
v0.2.0
v1.0.0
```

## Consumer Upgrade Pattern

<!--
==============================================================================
CONSUMER UPGRADE PATTERN
==============================================================================
-->

Consumers should pin module sources to a release tag.

```hcl
source = "git::https://github.com/bharathadigopula/terraform-aws-modules.git//modules/containers/ecs-service?ref=v0.1.0"
```

When a new module release is ready, update the tag intentionally.

```hcl
source = "git::https://github.com/bharathadigopula/terraform-aws-modules.git//modules/containers/ecs-service?ref=v0.2.0"
```


---
# generated by https://github.com/hashicorp/terraform-plugin-docs
page_title: "juju_secret Data Source - terraform-provider-juju"
subcategory: ""
description: |-
  A data source representing a Juju Secret.
---

# juju_secret (Data Source)

A data source representing a Juju Secret.

## Example Usage

```terraform
data "juju_model" "my_model" {
  name = "default"
}

data "juju_secret" "my_secret_data_source" {
  name  = "my_secret"
  model = data.juju_model.my_model.name
}

resource "juju_application" "ubuntu" {
  model = data.juju_model.my_model.name
  name  = "ubuntu"

  charm {
    name = "ubuntu"
  }

  config = {
    secret = data.juju_secret.my_secret_data_source.secret_id
  }
}

resource "juju_access_secret" "my_secret_access" {
  model = data.juju_model.my_model.name
  applications = [
    juju_application.ubuntu.name
  ]
  secret_id = data.juju_secret.my_secret_data_source.secret_id
}
```

<!-- schema generated by tfplugindocs -->
## Schema

### Required

- `model` (String) The name of the model containing the secret.
- `name` (String) The name of the secret.

### Read-Only

- `secret_id` (String) The ID of the secret.

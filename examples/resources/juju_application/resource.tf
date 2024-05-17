resource "juju_application" "this" {
  name = "my-application"

  model = juju_model.development.name

  charm {
    name     = "hello-kubecon"
    channel  = "edge"
    revision = 14
    series   = "trusty"
  }

  units = 3

  config = {
    external-hostname = "..."
  }
}

resource "juju_application" "placement_example" {
  name  = "placement-example"
  model = juju_model.development.name
  charm {
    name     = "hello-kubecon"
    channel  = "edge"
    revision = 14
    series   = "trusty"
  }

  units     = 3
  placement = "0,1,2"

  config = {
    external-hostname = "..."
  }
}

resource "juju_application" "jenkins-k8s" {
  name  = "jenkins-k8s"
  model = juju_model.development.name

  charm {
    name     = "jenkins-k8s"
    revision = 92
    channel  = "latest/edge"
    base     = "ubuntu@22.04" # required, otherwise will error: series "focal" not supported by charm
  }

  # 2GB of allocated memory will give jenkins 1GB of heap, change this if necessary.
  constraints = "arch=amd64 mem=2048M"

  storage_constraints = {
    jenkins-home = 2048
  }

  units = 1 # There cannot be more than 1 server unit.
}
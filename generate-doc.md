# How to generate module documentation

```bash
docker run --rm --volume "$(pwd):/terraform-docs" -u $(id -u) quay.io/terraform-docs/terraform-docs:0.16.0 markdown . > README.md

or

terraform-docs markdown . > README.md
```

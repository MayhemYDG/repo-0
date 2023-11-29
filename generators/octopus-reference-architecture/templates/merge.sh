#!/bin/sh

cat provider.tf > template.tf
cat locals.tf >> template.tf
cat library_variable_set.tf >> template.tf
cat environments.tf >> template.tf
cat feeds.tf >> template.tf
cat accounts.tf >> template.tf
cat worker_pools.tf >> template.tf
cat project_groups.tf >> template.tf
cat projects.tf >> template.tf

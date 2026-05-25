# Used to temporarily import a resource, then comment the import block for records
# Run the following to generate a config using terraform:
# terraform plan -generate-config-out=generated.tf

#import {    # Import history for minecraft bedrock (Dev box)
#  to = docker_container.minecraft-bedrock
#  id = "713a5e6bf82648438eb6696b705e697a42767453e34d359fa404e5b0735646f9"
#}
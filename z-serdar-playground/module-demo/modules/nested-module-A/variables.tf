variable bucket_name {
    description = "Name of the bucket, must be unique."
    type = string
}

variable tags {
    description = "Tags to set up for the bucket."
    type = map(string)
    default = {}
}
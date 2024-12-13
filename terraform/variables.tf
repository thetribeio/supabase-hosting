variable "scw_access_key" {
    type      = string
}

variable "scw_secret_key" {
    type      = string
    sensitive = true
}

variable "project_id" {
    type = string
    default = "facc0c77-31ff-4474-bf7d-29f4fe209bb6"
}

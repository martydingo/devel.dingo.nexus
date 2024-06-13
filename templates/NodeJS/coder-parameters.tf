data "coder_parameter" "github_repository" {
  name         = "github_repository"
  display_name = "Github Repository"
  description  = "The Github repository to clone into $HOME"
  mutable      = false
  type         = "string"
  validation {
    regex = "https://github.com.*$|^$"
    error = "URL must be an https github URL"
  }
}

data "coder_parameter" "load_balancer_ip" {
  name         = "load_balancer_ip"
  display_name = "Load Balancer IP"
  description  = "The IP address of the K8S load balancer to configure"
  mutable      = false
  type         = "string"
}

data "coder_parameter" "disk_size" {
  name         = "disk_size"
  display_name = "Disk Size"
  description  = "The size of the disk that holds user data"
  default      = "8"
  type         = "number"
  icon         = "/emojis/1f4be.png"
  mutable      = false
  validation {
    min = 1
    max = 32
  }
}

data "coder_parameter" "cpu_core_count" {
  name         = "cpu_core_count"
  display_name = "CPU Core Count"
  description  = "The number of CPU cores to configure"
  default      = "48"
  icon         = "/icon/memory.svg"
  mutable      = true
  option {
    name  = "2 Cores"
    value = "2"
  }
  option {
    name  = "4 Cores"
    value = "4"
  }
  option {
    name  = "6 Cores"
    value = "6"
  }
  option {
    name  = "8 Cores"
    value = "8"
  }
  option {
    name  = "10 Cores"
    value = "10"
  }
  option {
    name  = "12 Cores"
    value = "12"
  }
  option {
    name  = "14 Cores"
    value = "14"
  }
  option {
    name  = "16 Cores"
    value = "16"
  }
  option {
    name  = "18 Cores"
    value = "18"
  }
  option {
    name  = "20 Cores"
    value = "20"
  }
  option {
    name  = "22 Cores"
    value = "22"
  }
  option {
    name  = "24 Cores"
    value = "24"
  }
  option {
    name  = "26 Cores"
    value = "26"
  }
  option {
    name  = "28 Cores"
    value = "28"
  }
  option {
    name  = "30 Cores"
    value = "30"
  }
  option {
    name  = "32 Cores"
    value = "32"
  }
  option {
    name  = "34 Cores"
    value = "34"
  }
  option {
    name  = "36 Cores"
    value = "36"
  }
  option {
    name  = "38 Cores"
    value = "38"
  }
  option {
    name  = "40 Cores"
    value = "40"
  }
  option {
    name  = "42 Cores"
    value = "42"
  }
  option {
    name  = "44 Cores"
    value = "44"
  }
  option {
    name  = "46 Cores"
    value = "46"
  }
  option {
    name  = "48 Cores"
    value = "48"
  }
}

data "coder_parameter" "memory_allocation" {
  name         = "memory_allocation"
  display_name = "Memory Allocation"
  description  = "The amount of memory to allocate, in terms of gigabytes"
  default      = "4"
  icon         = "/icon/memory.svg"
  mutable      = true
  option {
    name  = "1 GB"
    value = "1"
  }
  option {
    name  = "2 GB"
    value = "2"
  }
  option {
    name  = "4 GB"
    value = "4"
  }
  option {
    name  = "6 GB"
    value = "6"
  }
  option {
    name  = "8 GB"
    value = "8"
  }
  option {
    name  = "10 GB"
    value = "10"
  }
  option {
    name  = "12 GB"
    value = "12"
  }
  option {
    name  = "14 GB"
    value = "14"
  }
  option {
    name  = "16 GB"
    value = "16"
  }
  option {
    name  = "18 GB"
    value = "18"
  }
  option {
    name  = "20 GB"
    value = "20"
  }
  option {
    name  = "22 GB"
    value = "22"
  }
  option {
    name  = "24 GB"
    value = "24"
  }
  option {
    name  = "26 GB"
    value = "26"
  }
  option {
    name  = "28 GB"
    value = "28"
  }
  option {
    name  = "30 GB"
    value = "30"
  }
  option {
    name  = "32 GB"
    value = "32"
  }
  option {
    name  = "34 GB"
    value = "34"
  }
  option {
    name  = "36 GB"
    value = "36"
  }
  option {
    name  = "38 GB"
    value = "38"
  }
  option {
    name  = "40 GB"
    value = "40"
  }
  option {
    name  = "42 GB"
    value = "42"
  }
  option {
    name  = "44 GB"
    value = "44"
  }
  option {
    name  = "46 GB"
    value = "46"
  }
  option {
    name  = "48 GB"
    value = "48"
  }
}


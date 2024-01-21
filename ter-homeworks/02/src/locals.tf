locals  {
    course = "netology"
    env = "develop-platform"
    hostname-db = "${local.course}-${local.env}-db"
    hostname-web = "${local.course}-${local.env}-web"
}


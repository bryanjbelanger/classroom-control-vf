class wrappers::limits {
limits::fragment { "*/soft/nofile":
value => "1024",
}
limits::fragment { "*/hard/nofile":
value => "8192",
}
}

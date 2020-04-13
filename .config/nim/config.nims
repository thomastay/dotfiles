hint("Processing", false)
hint("SuccessX", false)
hint("Conf", false)
hint("CC", false)
hint("Link", false)
hint("GCStats", false)
hint("exec", false)
hint("Path", false)
hint("GlobalVar", false)
--verbosity:2
--parallel_build:0
--listCmd:off
--styleCheck:hint

task seeCache, "Compiles and puts nimcache in local cache":
  --compileOnly
  --nimCache:cache
  setCommand "c"

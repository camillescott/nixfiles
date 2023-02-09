MATCH_PATH = [
  # (directory pattern, identity)
  (r"/work/HPCCF", "work")
]

MATCH_ARGV = [
  (r"ucdavis", "work"),
  (r"[\w\.]*\.mcb$", "work"),
  (r"[\w\.]*\.hpc$", "work"),
  (r"acheron", "work"),
  (r"[\w\.]*\.lan$", "home"),
  (r"[\w\.]*\.bogg\.cc$", "home"),
  (r"[\w\.]*\.zt$", "home")
]

DEFAULT_IDENTITY = "home"

#SSH_ADD_OPTIONS = {}

SSH_DEFAULT_OPTIONS = ""

VERBOSITY = LOG_DEBUG

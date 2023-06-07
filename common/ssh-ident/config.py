# Directory matching
MATCH_PATH = [
  (r"/work/HPCCF", "work")
]

# `ssh` ARGV matching
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
SSH_ADD_DEFAULT_OPTIONS = "-t 86400"

VERBOSITY = LOG_DEBUG

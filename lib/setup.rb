require 'tty-prompt'
require 'facets/timer'
require 'yaml'
require 'rainbow'
require 'io/console'
require_relative 'roll'
require_relative 'bet'
require_relative 'interface'
require_relative 'payouts'
require_relative 'felt'
require_relative 'drill'

ROLL_NAMES = YAML.load(File.read("config/roll_names.yml"))
BET_TYPES = YAML.load(File.read("config/bet_types.yml"))
ALT_PAYOUTS = YAML.load(File.read("config/exceptions.yml"))

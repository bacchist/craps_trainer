require 'tty-prompt'
require 'facets/timer'
require 'yaml'
require 'rainbow'
require 'io/console'
require_relative 'bet_list'
require_relative 'roll'
require_relative 'bet'
require_relative 'interface'
require_relative 'drill'
require_relative 'results'

ROLL_NAMES = YAML.load(File.read("config/roll_names.yml"))
HOP_BETS = YAML.load(File.read("config/hop_bets.yml"))

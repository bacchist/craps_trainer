# coding: utf-8
# frozen_string_literal: true

require 'tty-prompt'
require 'tty-font'
require 'ruby_cowsay'
require_relative 'bet_list'
require_relative 'roll'
require_relative 'bet'
require_relative 'interface'
require_relative 'drill'
require_relative 'results'

HOP_BETS = { 'High/Low' => { aces: 14, twelve: 14 }, 'C & E' => { aces: 3, ace_deuce: 3, twelve: 3, yo: 6.5 }, 'Seven/Eleven' => { seven: 1.5, yo: 6.5 }, 'Ace-Deuce/Twelve' => { ace_deuce: 6.5, twelve: 14 }, 'Aces/Yo' => { aces: 14, yo: 6.5 }, 'Low/Low' => { aces: 14, ace_deuce: 6.5 }, 'Hop any 5' => { five: 6.5 }, 'Hop any 9' => { nine: 6.5 }, 'Hop any 4' => { easy_four: 6.5, hard_four: 14 }, 'Hop any 10' => { easy_ten: 6.5, hard_ten: 14 }, 'Three-Way Craps' => { aces: 9, ace_deuce: 4, twelve: 9 }, 'High/Low/Yo' => { aces: 9, twelve: 9, yo: 4 }, 'Low/Low/Yo' => { aces: 9, ace_deuce: 4, yo: 4 }, 'Hop any 6' => { easy_six: 4, hard_six: 9 }, 'Hop any 8' => { easy_eight: 4, hard_eight: 9 }, 'Horn' => { twelve: 6.5, aces: 6.5, ace_deuce: 2.75, yo: 2.75 }, 'Hopping Hardways' => { hard_four: 6.5, hard_six: 6.5, hard_eight: 6.5, hard_ten: 6.5 }, 'Hop any 5 & 9' => { five: 2.75, nine: 2.75 }, 'Hop any 4 & 10' => { easy_four: 2.75, easy_ten: 2.75, hard_four: 6.5, hard_ten: 6.5 }, 'Hopping Buffalo' => { hard_four: 5, hard_six: 5, hard_eight: 5, hard_ten: 5, yo: 2 }, 'World Bet' => { aces: 5, yo: 2, twelve: 5, ace_deuce: 2, seven: 0 }, 'Hop Any 6 & 8' => { hard_six: 4, hard_eight: 4, easy_six: 1.5, easy_eight: 1.5 }, 'Crap Check' => { aces: 7, ace_deuce: 7, twelve: 7 }, 'Red' => { seven: 4 }, 'Yo' => { yo: 14 }, 'Aces' => { aces: 29 } }.freeze

DICE = ['⚀', '⚁', '⚂', '⚃', '⚄', '⚅'].freeze

ROLL_NAMES = { aces: [[1, 1]], ace_deuce: [[1, 2]], hard_four: [[2, 2]], easy_four: [[1, 3]], five: [[1, 4], [2, 3]], hard_six: [[3, 3]], easy_six: [[1, 5], [2, 4]], seven: [[1, 6], [2, 5], [3, 4]], hard_eight: [[4, 4]], easy_eight: [[2, 6], [3, 5]], nine: [[3, 6], [4, 5]], hard_ten: [[5, 5]], easy_ten: [[4, 6]], yo: [[5, 6]], twelve: [[6, 6]] }.freeze

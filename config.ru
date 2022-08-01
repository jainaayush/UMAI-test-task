# config.ru
require "rack"
require_relative 'application'

run Application.new

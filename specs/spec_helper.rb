require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/hotel_manager'
include HotelManager

# frozen_string_literal: true

require 'sinatra'
require 'rack/unreloader'

require_relative 'dates_calculator_controller'

get '/' do
  'Prout!'
end

get '/prout' do
  result = DatesCalculatorController.new(Date.new(2025, 1, 11), Date.new(2025, 4, 8)).calculate_next_possible_entry_date
  result
rescue DatesCalculatorController::InvalidDatesError => e
  e.message
end

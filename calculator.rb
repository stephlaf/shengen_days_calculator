# frozen_string_literal: true

require 'sinatra'
require 'rack/unreloader'

require_relative 'dates_calculator_controller'

get '/' do
  'Prout!'
end

get '/prout/:dates' do
  # @result = DatesCalculatorController.new(Date.new(2025, 1, 11), Date.new(2025, 4, 8)).calculate_next_possible_entry_date
  @result = DatesCalculatorController.new(params[:dates])#.calculate_next_possible_entry_date
  erb :results
rescue DatesCalculatorController::InvalidDatesError => e
  @error_message = e.message
end

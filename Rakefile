require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "Start our app console"
task :console do
  Pry.start
end

desc "Start the game"
task :run do
  Menu.splash
  Menu.root_menu
end

desc "Calibrate screen width"
task :calibrate do
  dash_string = "-"*130
  puts dash_string
  puts "Please make sure the whole line fits within the console."
end
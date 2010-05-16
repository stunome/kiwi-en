require 'rubygems'
require 'sinatra'
require 'fileutils'

PAGES_DIRECTORY = File.expand_path('../pages', __FILE__)

FileUtils.mkdir_p PAGES_DIRECTORY

get '/' do
  @pages = Dir.entries(PAGES_DIRECTORY).reject { |file| file =~ /^\./ }
  erb :index
end

get '/new' do
  erb :form
end

post '/pages' do

  filename = params['title']

  puts "*** Creating page #{filename}"

  File.open PAGES_DIRECTORY + '/' + filename, 'w' do |file|
    file.write params['body']
  end

  redirect '/'
end

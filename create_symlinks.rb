#!/usr/bin/env ruby

die 'Need to define HOME env var' unless ENV['HOME']

require 'pathname'
current_directory = Pathname.new(__FILE__).dirname.to_s # Pathname#dirname returns a Pathname

Dir.foreach(current_directory) do |filename|
	next if ['.', '..', '.git'].include? filename or filename !~ /^\./

	origin = current_directory + '/' + filename
	destination = ENV['HOME'] + '/' + filename
	File.symlink(origin, destination) unless File.exists? destination
end

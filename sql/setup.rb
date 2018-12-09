#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'pg'

conn = PG.connect(dbname: 'exercises')

create_database = "CREATE TABLE users (
)"

#conn.exec( "SELECT * FROM pg_stat_activity" ) do |result|
  #puts "     PID | User             | Query"
  #result.each do |row|
    #puts " %7d | %-16s | %s " %
      #row.values_at('procpid', 'usename', 'current_query')
  #end
#end

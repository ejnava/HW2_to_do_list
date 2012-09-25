# File: todo_setup.rb
# last modified: 9/24/12 by E.J. Nava

# This program sets up the todo database and defines the database schema
# that will be used to store the reminder list information.

# This program is executed only once to set up a new reminder database.

require "active_record"

#Use the adapter for the SQLite3 -
#Establish Connection to a new or existing data base

puts "establishing connection to DB"

ActiveRecord::Base::establish_connection(:adapter => "sqlite3", :database => "remind.sqlite")

# Define the database schema and the methods up and down to create the entries.
class ReminderTableScript < ActiveRecord::Migration
  def self.up
    create_table :reminders do |t|
      t.string  :date
      t.string  :description
      t.boolean :done
    end
  end
  
  def self.down
    drop_table :reminders
  end
  
end

#define database schema, and create database "reminder"

ReminderTableScript.up      # create the table that will be used in the database  




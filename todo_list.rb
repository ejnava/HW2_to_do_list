# File: todo_list.rb
# last modified: 9/24/12 by E.J. Nava

require "active_record"

#Use the adapter for the SQLite3 -
#Establish Connection to existing data base

ActiveRecord::Base::establish_connection(:adapter => "sqlite3", :database => "remind.sqlite")

class Reminder < ActiveRecord::Base
end


def get_YN_input()     # input character, test if valid and make uppercase
    valid_char=false    # only valid inputs are Y,y,N,n
    begin
      input_string=gets()   # Test first character entered and store
      if(/^[y Y n N]/ =~ input_string) then
         sc_input=input_string[0]
         sc_input=sc_input.upcase
         valid_char = true
      else
        puts("Invalid input character - re-enter")
      end
    end until (valid_char)
    return sc_input
end

def get_TF_input()     # input character, test if valid and make uppercase
    valid_char=false    # only valid inputs are Y,y,N,n
    begin
      input_string=gets()   # Test first character entered and store
      if(/^[t T f F]/ =~ input_string) then
         sc_input=input_string[0]
         sc_input=sc_input.upcase
         valid_char = true
         if (sc_input.chomp == 'T')then
             b_char = TRUE
         else
             b_char = FALSE
         end
      else
        puts("Invalid input character - re-enter")
      end
    end until (valid_char)
    return b_char
end

def get_AVDU_input()     # input character, test if valid and make uppercase
    valid_char=false    # only valid inputs are Y,y,N,n
    begin
      input_string=gets()   # Test first character entered and store
      if(/^[a A v V d D u U q Q]/ =~ input_string) then
         sc_input=input_string[0]
         sc_input=sc_input.upcase
         valid_char = true
      else
        puts("Invalid input character - re-enter")
      end
    end until (valid_char)
    return sc_input
end

db_operations = TRUE            # db operations loop variable

while db_operations
    puts
    puts "Which operation do you want?"
    puts "Enter A to add a reminder"
    puts "Enter V to view all the reminders"
    puts "Enter D to delete a reminder"
    puts "Enter U to update a reminder status"
    puts "Enter Q to quit"
    print "?  "

    in_char = get_AVDU_input()
    case (in_char)
        when 'A' then               # Add reminders to the database
            not_done = TRUE
            while(not_done)
                puts "Enter next reminder"
                print "Enter Date in DDMMMYY Format MMM (JAN, FEB, etc.):  "
                instring = gets()
                date_input = instring.chomp
                print "Enter Description:  "
                instring = gets()
                description_input = instring.chomp
                print "Is the task complete? Enter T or F:  "
                status_input = get_TF_input()
                Reminder.new(:date => date_input, :description => description_input, :done => status_input).save
                puts
                puts "Do you wish to add more entries? ( enter: \"Y\" or \"N\")"
                in_char = get_YN_input()
                puts()
                if (in_char.chomp == "N") then not_done = FALSE
                end
            end
        
        when 'V' then                       # View all the records in the database
            rcds = Reminder.find(:all)      #get all records in an array
            puts
            rcds.each_index {|i|
                puts "id: #{rcds[i].id}"
                puts "date: #{rcds[i].date} description: #{rcds[i].description} done: #{rcds[i].done} "}       

        when 'D' then                        # Delete items from the database
            puts
            print 'Enter the id number of the record you wish to delete: '
            inchar = gets()
            del_id = inchar.to_i
            puts
            puts "record to be deleted: #{del_id}"
            Reminder.delete(del_id)
            puts
            
        when 'U' then
            puts
            print 'Enter the id number of the record of which you wish to update status: '
            inchar = gets()
            ud_id = inchar.to_i
            puts
            printf 'Enter the completed status (T or F):  '
            status_input = get_TF_input()
            Reminder.update(ud_id, :done => status_input)
            puts 'Record updated'
            puts
            
        when 'Q' then db_operations = FALSE  # stop db operations
    end
end

  


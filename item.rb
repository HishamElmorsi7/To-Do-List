class  Item

    def self.valid_date?(date_str)
        alphabits = ('a'..'z')
        year, month, day = date_str.split("-")
        #checking if there is any character in day, month and year
        return false if year.split("").any?{ |ch| alphabits.include?(ch.downcase) } 
        return false if month.split("").any?{ |ch| alphabits.include?(ch.downcase) } || day.split("").any?{ |ch| alphabits.include?(ch.downcase) }
        #
        return false if !(1..12).include?(month.to_i) || !(1..31).include?(day.to_i)
        true
    end

    attr_accessor :title, :description
    attr_reader :deadline, :done

    def initialize(title, deadline, description)
        raise "Deadline isn't valid" if !Item.valid_date?(deadline)
        @title = title
        @deadline = deadline
        @description = description
        @done = false
    end

    def deadline=(new_deadline)
        raise "Deadline isn't valid" if !Item.valid_date?(new_deadline)
        @deadline = new_deadline
    end

    def toggle
        @done = !@done
    end
end
#Hisham Elmorsi
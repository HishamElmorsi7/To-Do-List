require "./item.rb"

class List

    #Styles for printing
    LINE_WIDTH = 58
    INDEX_COL_WIDTH = 5
    ITEM_COL_WIDTH = 20
    DEADLINE_COL_WIDTH = 17
    attr_accessor :label

    def initialize(label)
        @label = label
        @items = []
    end
    
    def add_item(title, deadline, description = "")
        return false if !Item.valid_date?(deadline)
        new_item = Item.new(title, deadline, description)
        @items << new_item
        true
    end

    def size
        @items.length
    end
    
    def valid_index?(index)
        ( index > @items.length - 1 || index < 0 ) ? false : true
    end

    def swap(index_1, index_2)
        return false if !valid_index?(index_1) || !valid_index?(index_2)
        @items[index_1], @items[index_2] = @items[index_2], @items[index_1]
        true
    end

    def [](index)
        return nil if !valid_index?(index)
        @items[index]
    end

    def priority
        @items.first
    end

    def print
        puts "-" * LINE_WIDTH
        puts " " * 27  + self.label.upcase
        puts "-" * LINE_WIDTH
        puts "#{'Index'.ljust(INDEX_COL_WIDTH)} | #{'Item'.ljust(ITEM_COL_WIDTH)} | #{'Deadline'.ljust(DEADLINE_COL_WIDTH)} | Done  "
        puts "-" * LINE_WIDTH
        @items.each_with_index do |item, i|
            puts "#{i.to_s.ljust(INDEX_COL_WIDTH)} | #{item.title.ljust(ITEM_COL_WIDTH)} | #{item.deadline.ljust(DEADLINE_COL_WIDTH)} | #{ item.done ? '[√]' : '[ ]' } "
        end
        puts "-" * LINE_WIDTH
    end

    def print_full_item(idx)
        if valid_index?(idx)
            puts "-" * LINE_WIDTH
            puts "#{@items[idx].title.ljust(25)} | #{@items[idx].deadline.ljust(DEADLINE_COL_WIDTH)}"
            puts "#{@items[idx].description.ljust(25)} | #{ @items[idx].done ? '[√]' : '[ ]' } "
            puts "-" * LINE_WIDTH
        end
    end
    
    def print_priority
        print_full_item(0)
    end

    def up(idx, amount = 1)
        return false if !valid_index?(idx)
        i = 0
        while i < amount &&  idx > 0
            swap(idx, idx - 1)
            idx -= 1
            i += 1
        end
        true
    end

    def down(idx, amount = 1)
        return false if !valid_index?(idx)
        i = 0
        while i < amount &&  idx < @items.length - 1
            swap(idx, idx + 1)
            idx += 1
            i += 1
        end
        true
    end
    
    def sort_by_date!
        @items.sort_by! { |item| item.deadline }      
    end

    def toggle_item(idx)
        @items[idx].toggle
    end

    def remove_item(idx)
        return false if !valid_index?(idx)
        @items.delete_at(idx)
        true
    end

    def purge
        @items.delete_if(&:done)
    end
    
end


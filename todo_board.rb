require "./list.rb"

class TodoBoard

    def initialize()
        @lists = {}
    end

    def get_command
        print "\nEnter a command: "
        cmd, target, *args = gets.chomp.split(' ')
        
        case cmd
        when 'ls'
            @lists.keys.each { |label| puts label }
        when 'mklist'
            @lists[target] = List.new(target)
        when 'showall'
            @lists.each_value(&:print)
        when 'mktodo'
            @lists[target].add_item(*args)
        when 'up'
            @lists[target].up(*args.map(&:to_i))
        when 'down'
            @lists[target].down(*args.map(&:to_i))
        when 'swap'
            @lists[target].swap(*args.map(&:to_i))
        when 'sort'
            @lists[target].sort_by_date!
        when 'priority'
            @lists[target].print_priority
        when 'print'
            args.empty? ? @lists[target].print : @lists[target].print_full_item(args[0].to_i)
        when 'toggle'
            @lists[target].toggle_item(args[0].to_i)
        when 'quit'
            return false
        when 'rm'
            @lists[target].remove_item(args[0].to_i)
        when 'purge'
            @lists[target].purge
        else
            puts "This cmd is not recognized ;("
        end
        true
    end

    def run
        while true
            return if !get_command
        end
    end
end

my_todo_list = TodoBoard.new
my_todo_list.run


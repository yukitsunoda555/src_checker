
Encoding.default_external = 'UTF-8'

require_relative 'action.rb'
require_relative 'condition.rb'
require_relative 'checker.rb'

if ARGV.size < 1
  puts "Usage: src_checker root_dir"
  exit
end

root_dir = ARGV[0]

checker = Checker.new()

# checker.add_check_matters(
#   Condition.match(/.*begin*/),
#   Action.print("BEGIN")
# )

checker.add_check_matters(
  Condition.custom do |line, i, file_name|
  
    if @file_name != file_name
      @flag = false
      @file_name = file_name
    end

    @flag = true if line.match(/.*custom.*/)
    #p "#{@flag} line:#{i}"

    if @flag
      line.match(/.*begin*/)
    else
      false
    end
  end,
  Action.print("BEGIN")
)

begin

  checker.check(root_dir)
  
rescue => e
  puts e.message
end
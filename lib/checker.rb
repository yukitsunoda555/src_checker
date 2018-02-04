require 'fileutils'

class Checker

  class CheckMatters
    def initialize(condition, action)
      @condition = condition
      @action = action
    end
  
    def check(line, line_num, file_name)
      @action.call(line, line_num, file_name) if @condition.call(line, line_num, file_name)
    end
  end
  
  def initialize
    @check_matters_array = []
  end

  def add_check_matters(condition, action)
    @check_matters_array << CheckMatters.new(condition, action)
  end

  def check(root_dir, pattern = "**/*.*")

    Dir.glob(File.join(root_dir, pattern)).each do |h_file|

      p h_file 
      File.foreach(h_file).with_index(1) do |line, i|

        @check_matters_array.each do |matters|
          
          matters.check(line.chomp, i, h_file)
        end
      end
    end
  end
end
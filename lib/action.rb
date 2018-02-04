module Action

  def self.print(msg)
    Proc.new do |line, line_num, file|
      puts "#{file} line:#{line_num} #{msg}"
    end
  end
end
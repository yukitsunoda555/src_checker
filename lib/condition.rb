module Condition

  def self.match(pattern)
    Proc.new do |line|     
      line.match(pattern)
    end
  end

  def self.custom(&block)
    Proc.new(&block)
  end
end
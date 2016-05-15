class LineAnalyzer

  attr_accessor :highest_wf_count, :highest_wf_words, :content, :line_number 

  def initialize(content, line_number)
    self.content = content
    self.line_number = line_number
    calculate_word_frequency
  end

  def calculate_word_frequency
    word_counts = Hash.new(0)
    self.content.split.each do |word|
      word_counts[word.downcase] += 1
    end
    self.highest_wf_count = word_counts.max_by{|k,v| v}[1]
    self.highest_wf_words = word_counts.select{|k,v| v == self.highest_wf_count}.keys
  end
end

class Solution

  attr_accessor :highest_count_across_lines, :highest_count_words_across_lines, :analyzers, :print_highest_word_frequency_across_lines

  def initialize()
    self.analyzers = Array.new(0)
  end
  def analyze_file()
    line_number = 1
    File.foreach('test.txt') do |line|
      self.analyzers.push(LineAnalyzer.new(line, line_number))
      line_number += 1
    end
  end

  def calculate_line_with_highest_frequency()
    highest_line_arr = self.analyzers.sort_by{|line| line.highest_wf_count }.reverse!.first
    self.highest_count_across_lines = highest_line_arr.highest_wf_count
    self.analyzers.each do 
      self.highest_count_words_across_lines = self.analyzers.select{|line| line.highest_wf_count == self.highest_count_across_lines}
    end
    
  end
  def print_highest_word_frequency_across_lines()
    puts "The following words have the highest frequency per line:"
    self.analyzers.each do |line| 
      puts "#{line.highest_wf_words} (appears in line ##{line.line_number})"
    end
  end
end

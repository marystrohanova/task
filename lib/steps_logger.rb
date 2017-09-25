# Logs each test step and test output

class StepsLogger
  def initialize
  end

  def write(text, log_in_console = true)
    File.open('./logs/test_output.log', 'a') { |f| f.write("#{text}\n") }
    puts text if log_in_console
  end

  def clear_all
    File.open('./logs/test_output.log', 'w') { |f| f.write("") }
  end
end
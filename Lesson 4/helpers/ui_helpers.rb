class UIHelpers
  def self.red(text)
    "\e[31m#{text}\e[0m"
  end

  def self.green(text)
    "\e[32m#{text}\e[0m"
  end

  def self.get_user_input(prompt_message)
    puts prompt_message
    gets.chomp
  end
end

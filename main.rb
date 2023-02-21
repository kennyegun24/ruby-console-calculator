require_relative 'answer'

class Calculator
  attr_accessor :book, :people, :rentals

  def initialize
    @answers = []
  end

  def run
    puts library_menu
    user_input = gets.chomp

    if user_input <= '3'
      options(user_input)
    elsif user_input == '4'
      puts 'Thanks for using the app!'
    else
      'Please select an option from 1 - 4'
    end
  end

  def library_menu
    puts 'Welcome👋 to Calc App!'
    puts ''
    puts 'Please choose an option by entering a number'
    puts '1 - List all 10 previous answers'
    puts '2 - Do some basic arithmethics'
    puts '3 - Undo'
    puts '4 - Exit'
  end

  def back_to_menu
    puts ''
    print 'Press Enter to go back to menu: '
    gets.chomp
    run
  end

  def list_books
    if @answers.empty?
      puts 'No answers available 😔'
      back_to_menu
    end
    puts 'List of all answers: '
    @answers.each_with_index do |list, i|
      puts "#{i}) Answer: #{list[:num1]} #{list[:operator]} #{list[:num2]} = #{list[:result]}"
    end
    back_to_menu
  end

  def create_book
    print 'First Number: '
    title = gets.chomp().to_f
    print 'Operator'
    operator = gets.chomp().to_sym
    print 'Second Number'
    second = gets.chomp().to_f
    solution = case operator
        when :- then title - second
        when :+ then title + second
        when :* then title * second
        when :/ then title / second
    end
    puts solution
    @answers.push(num1: title, num2: second, operator: operator, result: solution)
    @answers.shift if @answers.length > 10

    puts 'Pushed to memory'
    back_to_menu
  end

  def undo
    return back_to_menu if @answers.empty?
    operation = @answers.pop
        puts "Reverted : #{operation[:num1]} #{operation[:operator]} #{operation[:num2]} = #{operation[:result]} "
        back_to_menu
    end

  def options(user_input)
    case user_input
    when '1'
      list_books
    when '2'
        create_book
    when '3'
        undo
    else
      puts 'Enter a number between 1 - 4'
    end
  end
end

app = Calculator.new
app.run

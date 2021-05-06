def prompt(message)
  puts "=> #{message}"
end

def valid_amount?(input)
  input = input.split(',').join # making sure can accept input with a comma
  input.to_i.to_s == input || input.to_f.to_s == input
end
# START OF APPLICATION
prompt("Welcome to the Loan Calculator! Please enter your name: ")

name = ""

loop do
  name = gets.chomp
  break unless name.empty?
  prompt("Please enter a valid name!")
end

prompt("Hello #{name.capitalize}!")
loop do # Main Loop
  prompt("Lets get some information about the loan. What is the loan amount?")

  loan_amount = ""
  loop do
    loan_amount = gets.chomp
    break if valid_amount?(loan_amount)
    prompt("Please enter a valid amount!")
  end
  loan_amount = loan_amount.split(',').join
  # converting loan input with a comma to a string without a comma

  prompt("Great! How many years is the loan for?")

  loan_duration_years = ""
  loop do
    loan_duration_years = gets.chomp
    break if valid_amount?(loan_duration_years)
    prompt("Please enter a valid duration!")
  end

  prompt("What is the Annual Percentage Rate?
  Please enter as a number. Ex: Enter 5.5% as 5.5")

  apr = ""
  loop do
    apr = gets.chomp
    break if valid_amount?(apr)
    prompt("Please enter a valid interest rate!")
  end
  prompt("Calculating....")

  apr = apr.to_f / 100 # converting APR to decimal
  monthly_interest_rate = apr.to_f / 12
  # converting APR to monthly interest rate
  month_duration = loan_duration_years.to_f * 12
  # converting loan duration to months

  monthly_payment = loan_amount.to_f * (monthly_interest_rate.to_f /
  (1 - (1 + monthly_interest_rate.to_f)**(-month_duration.to_f)))

  total_amount_of_payments = monthly_payment.to_f * month_duration.to_f
  total_interest = total_amount_of_payments.to_f - loan_amount.to_f

  prompt("Thanks for the information! Here are your loan details:
    Monthly Payment: #{monthly_payment.round(2)}
    Total Payments Made: #{total_amount_of_payments.round(2)}
    Total Interest Expense Paid: #{total_interest.round(2)}
  ")

  prompt("Would you like to calculate detials for another loan?")
  continue = gets.chomp
  break unless continue.downcase.start_with?("y")
end

prompt("Thank you for using our calculator! Have a great day!")

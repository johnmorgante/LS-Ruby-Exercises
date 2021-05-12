def clear_screen
  system('clear')
end

def prompt(message)
  puts "=> #{message}"
end

def valid_postive_amount?(input)
  input = input.split(',').join # making sure can accept input with a comma
  (input.to_i.to_s == input || input.to_f.to_s == input) && input.to_f > 0
end

def valid_apr?(input)
   (input.to_i.to_s == input || input.to_f.to_s == input) && input.to_f >= 0
end

def get_user_name
  name = ""
  loop do
    name = gets.chomp
    break unless name.empty?
    prompt("Please enter a valid name!")
  end
  prompt("Hello #{name}!")
end

def get_loan_amount
  prompt("Lets get some information about the loan. What is the loan amount?")
  loan_amount = ""
  loop do 
    loan_amount = gets.chomp
    break if valid_postive_amount?(loan_amount)
    prompt("Please enter a valid loan amount")
  end
   loan_amount = loan_amount.split(',').join
end

def get_loan_duration
  prompt("Great! How many years is the loan for?")
  loan_duration_years = ""
  loop do
    loan_duration_years = gets.chomp
    break if valid_postive_amount?(loan_duration_years)
    prompt("Please enter a valid duration!")
  end
  loan_duration_years
end


def get_apr
  prompt("What is the Annual Percentage Rate?
  Please enter as a number. Ex: Enter 5.5% as 5.5")
  apr = ""
  loop do
    apr = gets.chomp
    break if valid_apr?(apr)
    prompt("Please enter a valid interest rate!")
  end
  apr
end

def display_calculating_message
  prompt("Calculating...")
  sleep(2)
end

def calculate_monthly_payment(loan_amount, loan_duration_years, apr)
  apr = apr.to_f / 100 
  monthly_interest_rate = apr.to_f / 12
  month_duration = loan_duration_years.to_f * 12
  if apr.to_f == 0
    monthly_payment = loan_amount.to_f / month_duration.to_f
  else
    monthly_payment = loan_amount.to_f * (monthly_interest_rate.to_f /
    (1 - (1 + monthly_interest_rate.to_f)**(-month_duration.to_f)))
  end
  monthly_payment
end

def total_amount_of_payments(monthly_payment, loan_duration_years)
  month_duration = loan_duration_years * 12
  monthly_payment * month_duration
end 
  
def another_calculation?
  continue = ""
  loop do 
    prompt("Would you like to calculate details for another loan? Y/N " )
    continue = gets.chomp
    if continue.downcase.start_with?("n", "y")
      break
    else 
      prompt("Yes or No")
    end
  end
  if continue.downcase.start_with?("y")
    true
  else 
    false 
  end 
end
  
# START OF APPLICATION
prompt("Welcome to the Loan Calculator! Please enter your name: ")
get_user_name
sleep(1)

loop do # Main Loop
  clear_screen
  
  loan_amount = get_loan_amount
    
  loan_duration_years = get_loan_duration
  
  apr = get_apr
 
  display_calculating_message
  
  monthly_payment = calculate_monthly_payment(loan_amount, loan_duration_years, apr)
  total_amount_of_payments = total_amount_of_payments(monthly_payment.to_f, loan_duration_years.to_f)
  total_interest = total_amount_of_payments.to_f - loan_amount.to_f

  prompt("Thanks for the information! Here are your loan details:
    Monthly Payment: #{format('%.2f', monthly_payment)}
    Total Payments Made: #{format('%.2f', total_amount_of_payments)}
    Total Interest Expense Paid: #{format('%.2f' , total_interest)}
  ")
  break unless another_calculation?
end 
prompt("Thank you for using our calculator! Have a great day!")

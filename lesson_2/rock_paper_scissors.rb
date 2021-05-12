VALID_CHOICES = %w(rock paper scissors lizard spock)
VALID_CHOICES_ABBREV = %w(r p sc l sp)

def clear_screen
  sleep(2.7)
  system('clear')
end

def prompt(message)
  Kernel.puts("=> #{message}")
end

def abbreviation_to_actual(input)
  case input
  when "r"
    "rock"
  when "p"
    "paper"
  when "sc"
    "scissors"
  when "l"
    "lizard"
  when "sp"
    "spock"
  end
end

def win?(first, second)
  (first == 'rock' && second == 'scissors') ||
    (first == 'paper' && second == 'rock') ||
    (first == 'scissors' && second == 'paper') ||
    (first == 'rock' && second == 'lizard') ||
    (first == 'lizard' && second == 'spock') ||
    (first == 'spock' && second == 'scissors') ||
    (first == 'scissors' && second == 'lizard') ||
    (first == 'lizard' && second == 'paper') ||
    (first == 'paper' && second == 'spock') ||
    (first == 'spock' && second == 'rock')
end

def display_results(player, computer)
  if win?(player, computer)
    prompt("You won!")
  elsif win?(computer, player)
    prompt("Computer won!")
  else
    prompt("Its a draw!")
  end
end

def display_greeting
  prompt("Welcome to the rock, paper, scissors, lizard, spock game!")
  prompt("Here are the rules:
          Scissors cuts Paper
          Paper covers Rock
          Rock crushes Lizard
          Lizard poisons Spock
          Spock smashes Scissors
          Scissors decapitates Lizard
          Lizard eats Paper
          Paper disproves Spock
          Spock vaporizes Rock
          Rock crushes Scissors")
  sleep(1.5)
  prompt("The first one to win 3 times is the GRAND WINNER!!")
  sleep(1.5)
  prompt("GOOD LUCK!")
end

def display_current_score(user1_score, user2_score)
  prompt("Your current win total is #{user1_score}
  and the computer's win total is #{user2_score}")
end

def display_goodbye(user_score_tracker)
  if user_score_tracker == 3
    prompt("Congrats you won!!!!")
  else
    prompt("Better luck next time!! That computer is hard to beat!")
  end

  prompt("Thank you for playing!")
end

display_greeting
sleep(2.5)

player_wins = 0
computer_wins = 0

loop do
  choice = ""
  loop do
    prompt("Choose one: #{VALID_CHOICES.join(', ')}")
    prompt("Enter 'r' for rock, 'p' for paper, 'sc' for scissors,
           'l' for lizzard, and 'sp' for spock.")
    choice = Kernel.gets().chomp()

    if VALID_CHOICES.include?(choice)
      break
    elsif VALID_CHOICES_ABBREV.include?(choice)
      choice = abbreviation_to_actual(choice)
      break
    else
      prompt("That's not a valid choice.")
    end
  end

  computer_choice = VALID_CHOICES.sample

  Kernel.puts("You chose: #{choice}; Computer chose: #{computer_choice}")

  if win?(choice, computer_choice)
    player_wins += 1
  elsif win?(computer_choice, choice)
    computer_wins += 1
  end

  display_results(choice, computer_choice)

  display_current_score(player_wins, computer_wins)

  clear_screen

  break if player_wins == 3 || computer_wins == 3
end

display_goodbye(player_wins)
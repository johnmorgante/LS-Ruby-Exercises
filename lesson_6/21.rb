CARD_VALUES = { "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7,
                "8" => 8, "9" => 9, "10" => 10, "jack" => 10,
                "queen" => 10, "king" => 10 }

def initalize_deck
  {
    hearts:   ["2", "3", "4", "5", "6", "7",
               "8", "9", "10", "jack", "queen", "king", "ace"],
    spades:   ["2", "3", "4", "5", "6", "7",
               "8", "9", "10", "jack", "queen", "king", "ace"],
    clubs:    ["2", "3", "4", "5", "6", "7",
               "8", "9", "10", "jack", "queen", "king", "ace"],
    diamonds: ["2", "3", "4", "5", "6", "7",
               "8", "9", "10", "jack", "queen", "king", "ace"]
  }
end

def prompt(msg)
  puts "=> #{msg}"
end

def joinor(arr, delimiter=', ', word='and')
  case arr.size
  when 2 then arr.join(" #{word} ")
  else
    arr.join(delimiter)
  end
end

def player_turn(deck, players_cards)
  loop do
    display_players_cards(players_cards)
    if calculate_cards_value(players_cards) == 21
      sleep(1)
      prompt("21!")
      break
    end
    prompt("hit or stay")
    choice = gets.chomp
    break if choice == "stay"
    deal_card!(deck, players_cards)
    break if bust?(players_cards)
  end
end

def dealer_turn(deck, dealers_cards)
  loop do
    sleep(1)
    display_all_dealer_cards(dealers_cards)
    if calculate_cards_value(dealers_cards) == 21
      sleep(1)
      prompt("21!")
      break
    end
    break if calculate_cards_value(dealers_cards) >= 17 || bust?(dealers_cards)
    deal_card!(deck, dealers_cards)
  end
end

def bust?(cards)
  calculate_cards_value(cards) > 21
end

def display_players_cards(players_cards)
  prompt("You have: #{joinor(players_cards)}")
  sleep(1)
end

def display_dealer_cards(dealers_cards)
  prompt("Dealer has: #{dealers_cards.first} and unkown")
  sleep(1)
end

def display_all_dealer_cards(dealers_cards)
  prompt("Dealer has: #{joinor(dealers_cards)}")
  sleep(1)
end

def deal_card!(deck, current_user_deck)
  card_suite = deck.keys.sample
  card_number_string = deck[card_suite].sample
  deck.each do |key, value|
    if key == card_suite
      value.delete_if { |v| v == card_number_string }
    end
  end
  current_user_deck << card_number_string
end

def initial_deal!(deck, user_deck)
  deal_card!(deck, user_deck)
  deal_card!(deck, user_deck)
end

def calculate_cards_value(current_player_cards)
  card_value = 0
  current_player_cards.each do |card|
    if card == "ace"
      next
    else
      card_value += CARD_VALUES[card]
    end
  end
  card_value += calculate_ace_value(current_player_cards, card_value)
end

def calculate_ace_value(current_player_cards, card_value)
  ace_count = current_player_cards.count("ace")
  ace_value = 0
  if ace_count > 1
    ace_value += ace_count - 1
    if card_value > 10
      ace_value += 1
    else
      ace_value += 11
    end
  elsif ace_count == 1
    if card_value > 10
      ace_value += 1
    else
      ace_value += 11
    end
  end
  ace_value
end

def calculate_winner(players_cards, dealers_cards)
  if calculate_cards_value(players_cards) > calculate_cards_value(dealers_cards)
    "Player"
  elsif calculate_cards_value(players_cards) == calculate_cards_value(dealers_cards)
    "Tie"
  else
    "Dealer"
  end
end

def display_winner(winner)
  case winner
  when "Player"
    prompt("You win!")
  when "Dealer"
    prompt("Dealer wins!")
  else
    prompt("Its a tie!")
  end
end

def greeting
  prompt("Welcome to Blackjack!")
  prompt("Dealing cards now....")
  prompt("....")
  sleep(1)
end

greeting
loop do
  players_cards = []
  dealers_cards = []
  deck = initalize_deck
  loop do
    initial_deal!(deck, players_cards)
    initial_deal!(deck, dealers_cards)
    display_dealer_cards(dealers_cards)
    player_turn(deck, players_cards)
    if bust?(players_cards)
      display_players_cards(players_cards)
      prompt("Bust! Dealer wins!")
    else
      dealer_turn(deck, dealers_cards)
      if bust?(dealers_cards)
        prompt("Dealer busted!")
        prompt("You win!")
      else
        winner = calculate_winner(players_cards, dealers_cards)
        display_winner(winner)
      end
    end
    break
  end
  prompt("Do you want to play again?")
  choice = gets.chomp.downcase
  break unless choice.include?("y")
end

prompt("Game over!")

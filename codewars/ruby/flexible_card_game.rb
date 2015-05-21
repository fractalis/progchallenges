=begin

Create any card game!

Create a Card Game library of classes which could be used to create any number of basic card games. You'll need at least a Deck class and a Card class.

Deck functionality

A deck has a public attribute:

cards: array of remaining cards in the deck.

...and three public methods:

count(): count of remaining cards in the deck.

shuffle(): randomize the order of the remaining cards in the deck.

draw(n): remove the last n cards from the deck and return them in an array.

Upon initialization, a deck is filled with 52 cards (13 from each of 4 suits).

Card functionality

A card has these public attributes:

suit: a symbol representing the suit of the card.
rank: an integer from 1 to 13. ("ace" is 1, "king" is 13)
Javascript: face_card: is this card a face card? (> 10)
...and these methods:

Ruby: face_card?: is this card a face card? (> 10)
to_s (JS:toString()) : human-readable string representation of the card (e.g. "Ace of Spades", "10 of Clubs", "Queen of Hearts")
Cards must be Comparable to other cards. Compare the ranks of the cards only.

Since this is a low level layer to build card games above, all test input will be valid. All ranks will be between 1 and 13 and all suits will be one of

Ruby: :hearts, :diamonds, :spades, :clubs
Javascript: Card.HEARTS, Card.DIAMONDS, Card.CLUBS, Card.SPADES

=end

require 'test/unit'
require 'test/unit/ui/console/testrunner'

class InvalidCardException < Exception; end

class Card
  include Comparable

  SUITS = [:hearts, :diamonds, :clubs, :spades]

  FACE_CARDS = {
    11 => "Jack",
    12 => "Queen",
    13 => "King",
    1 => "Ace"
  }

  attr_reader :suit, :rank

  def initialize(suit, rank)
    raise InvalidCardException unless rank > 0 and rank <= 13
    raise InvalidCardException unless SUITS.include? suit

    @suit = suit
    @rank = rank
  end

  def <=>(other)
    #(@rank == 1) ? ((other.rank == 1 ? 0 : 1)) : @rank <=> other.rank
    @rank <=> other.rank
  end

  def face_card?
    @rank > 10
  end

  def to_s
    face_value = (FACE_CARDS.has_key? @rank) ? FACE_CARDS[@rank] : @rank
    return "#{face_value} of #{@suit.to_s.capitalize}"
  end

end

class Deck

  attr_reader :cards

  def initialize()
    @cards = []
    [:hearts,:spades,:clubs,:diamonds].each do |suit|
      (1..13).each do |rank|
        @cards << Card.new(suit, rank)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def draw(n=1)
    @cards.slice!(-n,n)
  end

  def count
    @cards.count
  end
end


class TestCards < Test::Unit::TestCase
  def setup; end
  def teardown; end

  def test_raises_exception_invalid_suit

    assert_raise InvalidCardException do
      Card.new(:baz, 10)
    end
  end

  def test_raises_exception_invalid_rank
    assert_raise InvalidCardException do
      Card.new(:hearts, 15)
    end
  end

  def test_card_initializes_with_suit_and_rank
    card = Card.new(:hearts, 10)

    assert_equal(card.suit, :hearts)
    assert_equal(card.rank, 10)
  end

  def test_card_properly_checks_face_cards
    card = Card.new(:hearts, 11)
    assert_equal(card.face_card?, true)

    card = Card.new(:spades, 9)
    assert_equal(card.face_card?, false)
  end

  def test_ace_cards_are_not_face_cards
    card = Card.new(:clubs, 1)
    assert_equal(card.face_card?, false)
  end

  def test_card_creates_readable_description
    card = Card.new(:diamonds, 11)
    assert_equal(card.to_s, "Jack of Diamonds")

    card = Card.new(:spades, 7)
    assert_equal(card.to_s, "7 of Spades")
  end

  def test_cards_are_comparable_to_others
    high_rank = Card.new(:spades, 10)
    low_rank = Card.new(:clubs, 9)

    assert_equal(high_rank > low_rank, true)
  end

  def test_ace_cards_do_not_rank_higher
    ace = Card.new(:clubs, 1)
    king = Card.new(:clubs, 13)

    assert_equal(ace > king, false)
  end

end

class TestDeck < Test::Unit::TestCase
  def setup
    @deck_size = 52
  end

  def teardown; end

  def test_creates_new_deck
    deck = Deck.new
    assert_equal(deck.count, @deck_size)
  end

  def test_shuffles_deck
    deck = Deck.new
    initial_deck = deck.cards.dup

    assert_equal(deck.cards, initial_deck)
    deck.shuffle
    assert_not_equal(deck.cards, initial_deck)
  end

  def test_shows_cards_remaining
    deck = Deck.new
    assert_equal(deck.count, @deck_size)
  end

  def test_draws_n_cards
    deck = Deck.new
    draw = deck.draw(5)

    assert_equal(draw.count, 5)
    assert_equal(deck.count, @deck_size-5)
  end

  def test_draws_from_end
    deck = Deck.new
    end_of_deck = deck.cards[-7,7]
    draw = deck.draw(7)

    assert_equal(end_of_deck, draw)
  end
end


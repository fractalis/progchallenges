require './bowling_game'
require 'minitest/autorun'

f1 = BowlingFrame.new
f1.roll(5)
f1.roll(4)

class BowlingTest < Minitest::Unit::TestCase

  def setup; end;

  def test_simple_score
    f1 = BowlingFrame.new
    f1.roll(4)
    f1.roll(5)
    assert_equal f1.score, 9
  end

  def test_spare
    f1 = BowlingFrame.new
    f1.roll(5)
    f1.roll(5)
    assert_equal f1.score, nil
  end

  def test_gamescore
    f1 = BowlingFrame.new
    f2 = BowlingFrame.new
    f1.roll(4)
    f1.roll(5)
    f2.roll(9)
    f2.roll(0)
    f1.linkFrame f2

    assert_equal f1.gameScore, 18
  end

  def test_spare_score
    f1 = make_frame(5,5)
    f2 = make_frame(9,0)
    f1.linkFrame f2
    assert_equal f1.score, 19
  end

  def test_strike_score
    f1 = make_frame(10,0)
    f2 = make_frame(4,5)
    f1.linkFrame f2
    assert_equal f1.score, 19
  end

  def test_spare_gamescore
    f1 = make_frame(5,5)
    f2 = make_frame(9,0)
    f3 = make_frame(4,5)

    f1 = link_frames([f1,f2,f3])

    assert_equal 37, f1.gameScore
  end

  def test_strike_gamescore
    f1 = make_frame(10,0)
    f2 = make_frame(10,0)
    f3 = make_frame(4,5)
    link_frames([f1,f2,f3])
    assert_equal f1.gameScore, 52
  end

  def test_nine_frames
    rolls = [[10,0], [10,0], [4,5], [5,4], [5,5] , [3,2], [0,1], [9,1], [1,0]]

    frames = rolls.map do |x|
      make_frame(x[0], x[1])
    end

    f1 = link_frames(frames)
    assert_equal f1.gameScore, 92
  end

  def test_last_frame_no_spare_or_strikes
    lf = make_last_frame([5,4,3])
    assert_equal lf.score, 9

  end

  def test_last_frame_spare
    lf = make_last_frame([5,5,9])
    assert_equal lf.score, 19
  end

  def test_last_frame_strike_then_spare
    lf = make_last_frame([10,4,6])
    assert_equal lf.score, 20
  end

  def test_last_frame_strike_then_no_spare
    lf = make_last_frame([10,4,5])
    assert_equal lf.score, 19
  end

  def test_last_frame_triple_strike
    lf = make_last_frame([10,10,10])
    assert_equal lf.score, 30
  end

  def test_full_game
    rolls = [[10,0], [10,0], [4,5], [5,4], [5,5] , [3,2], [0,1], [9,1], [1,0], [10,10,10]]

    frames = rolls.map do |x|
      if x.length == 3
        make_last_frame(x)
      else
        make_frame(x[0], x[1])
      end
    end

    f1 = link_frames(frames)
    assert_equal 122, f1.gameScore
  end

  def test_sample_game_provided_in_doc
    rolls = [[1,4], [4,5], [6,4], [5,5], [10,0], [0,1], [7,3], [6,4], [10, 0], [2, 8, 6]]
    frames = rolls.map do |x|
      if x.length == 3
        make_last_frame(x)
      else
        make_frame(x[0], x[1])
      end
    end

    f1 = link_frames(frames)
    assert_equal 133, f1.gameScore
  end

  def test_perfect_game
    rolls = [[10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,0], [10,10,10]]
    frames = rolls.map do |x|
      if x.length == 3
        make_last_frame(x)
      else
        make_frame(x[0], x[1])
      end
    end

    f1 = link_frames(frames)
    assert_equal 300, f1.gameScore
  end


  private

  def link_frames(frames)
    frames.reduce do |f1,f2|
      f1.linkFrame f2
    end
    frames[0]
  end

  def make_frame(r1,r2)
    frame = BowlingFrame.new
    frame.roll(r1); frame.roll(r2)
    frame
  end

  def make_last_frame(rolls)
    frame = LastFrame.new
    rolls.each do |x|
      frame.roll(x)
    end
    frame
  end
end

require 'pry'
class BowlingFrame

  def initialize
    @rolls = []
    @frame_state = :unplayed
    @nextFrame = nil
  end

  def roll(n)
    case @frame_state
    when :unplayed
     if n == 10
       @frame_state = :strike
     else
       @frame_state = :first
     end
     @rolls.push n
    when :first
      if @rolls[0] + n == 10
        @frame_state = :spare
      else
        @frame_state = :played
      end
      @rolls.push n
    when :strike
      @rolls.push 0
    end
  end

  def linkFrame frame
    @nextFrame = frame
  end

  def getRoll(idx)
    case @frame_state
    when :strike
      if idx == 1
        @nextFrame.getRoll(0)
      else
        @rolls[idx]
      end
    else
      @rolls[idx]
    end
  end

  def score
    score = @rolls.reduce(&:+)
    if @frame_state == :spare
      if @nextFrame.nil?
        score = nil
      else
        # Add frame state check to make sure at least first roll was played
        score += @nextFrame.getRoll(0)
      end
    elsif @frame_state == :strike
      if @nextFrame.nil?
        score = nil
      else
        # Make sure frame state in [:strike, :spare, :played]
        score += @nextFrame.getRoll(0) + @nextFrame.getRoll(1)
      end
    end
    score
  end

  def gameScore
    score + (@nextFrame.nil? ? 0 : @nextFrame.gameScore)
  end
end

class LastFrame < BowlingFrame

  def initialize
    super
  end

  def roll(n)
    case @rolls.length
    when 0
      @rolls.push(n)
    when 1
      @rolls.push(n)
    else
      if @rolls.length < 3 and @rolls.reduce(&:+) >= 10
        @rolls.push(n)
      end
    end
  end

  def score
    @rolls.reduce(&:+)
  end

end


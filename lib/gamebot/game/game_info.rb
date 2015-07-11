class GameInfo
  @channel = nil
  @players = nil
  @status = GameStatus.NONE

  def initialize(channel)
    @channel = channel
    @players = Players.new(channel)
  end
end
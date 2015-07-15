Replays
=======

Replays can be implemented in games to get a backlog of what happened during the game.
These files are then store in the directory provided by config.yaml under `replay_storage`,
or the `storage` folder in the root folder.

Replays can be exported in several various file formats and log formats.

To use a replay in a game session, call the `@replay.store(String, :TAG)` method.

The first parameter is a string, here you describe what happened. This really can be anything, and depends on the game being made.

The second parameter is a tag, whilst this again can be anything - it's good to stick to common tags other games use for easier indexing, more about this in [replay_tags](/docs/replay_tags.md).

An example list of what a replay could contain (from real-time logging) could look something like this:

```
@replay.track("#{name} has started a game of #{game_name}.", :GAME_INIT)
@replay.track("#{name} has joined the game.", :PLAYER_JOIN)
@replay.track("#{name} has joined the game.", :PLAYER_JOIN)
@replay.track("#{name} has joined the game.", :PLAYER_JOIN)
@replay.track("#{name} has left the game.", :PLAYER_QUIT)
@replay.track("#{game_name} is now starting. Players: #{players}.", :GAME_START)
@replay.track("#{name} has left been eliminated by #{name2}.", :PLAYER_ELIMINATION)
@replay.track("There are no more players left, #{name} is victorious!", :PLAYER_VICTORY)
@replay.track("The game started by #{name} has ended. Duration: #{dur}, players: #{players}, eliminations: #{elim}", :GAME_END)
```

There are plans to provide mechanics that listen in on some of these events.
Replay Tags
===========

Games are all different, and it's difficult to predict what kind of tags are going to be needed.

There's a standard set of tags we recommend you use for certain events (which will also be used by game mechanisms), but you're free to invent your own tags if your game needs it.

Replay Tags map:
```
GAME_INIT - a game is being started up
GAME_START - a game has started
GAME_END - a game has ended
GAME_STATISTIC - a statistic about the game

PLAYER_JOIN - someone joining the game
PLAYER_QUIT - someone quitting/leaving the game
PLAYER_EXP_GAIN - player has been given some experience for an event

TEAM_JOIN - someone is joining a team
ROLE_ASSIGN - someone has been assigned a role
```

The following tags may be reused for things like players, teams, npcs, roles, etc.
```
PLAYER_ACTION - player is doing something
PLAYER_ATTACK - player is attacking something
PLAYER_DAMAGED - player has been damaged by something
PLAYER_ELIMINATION - player has been defeated
PLAYER_VICTORY - player is victorious

PLAYER_GUESS_RIGHT - player guesses something wrongly
PLAYER_GUESS_WRONG - player guesses something correct
PLAYER_ANSWER_RIGHT - player answers something wrongly
PLAYER_ANSWER_WRONG - player answers something correctly
```

for example, if a team rather than a single player is victorious, simply use the tag `TEAM_VICTORY`
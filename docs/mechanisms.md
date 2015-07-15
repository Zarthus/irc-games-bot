Mechanisms
==========

GameBot Game Mechanisms are small stand-alone modules you can load for your game that will change how your game behaves in a non-affecting way.

Each game can specify the mechanisms they would like to load from `/lib/gamebot/game/mechanism/*.rb` files. Multiple mechanisms may be activated.

A mechanism is often something rather simple, such as voicing anyone who enters the game. But it can also be rather complex, like loading in a new database for Q&A-type games.

Mechanisms may provide new commands.

Mechanisms cannot be unloaded or modified by game parameters.
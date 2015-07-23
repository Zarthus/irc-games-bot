require 'logger'
require 'sequel'
require 'optparse'
require 'net/http'
require 'gist'
require 'googl'
require 'yaml'
require 'json'
require 'cinch'

require 'gamebot/version'
require 'gamebot/plugin_loader'
require 'gamebot/plugins/plugin'

require 'gamebot/utilities/arg_parser'
require 'gamebot/utilities/string'
require 'gamebot/utilities/dir'
require 'gamebot/utilities/paste'
require 'gamebot/utilities/shorturl'
require 'gamebot/wildcard_require'

require 'gamebot/database/connection'
require 'gamebot/database/migrator'
GameBot::WildcardRequire.new('lib/gamebot/database/models/*.rb')

require 'gamebot/game/info'
require 'gamebot/game/players'
require 'gamebot/game/status'
require 'gamebot/game/manager'
require 'gamebot/game/mechanism'
require 'gamebot/game/mechanism_manager'
require 'gamebot/game/game_option_parser'

GameBot::WildcardRequire.new('lib/gamebot/game/mechanism/*.rb')
GameBot::WildcardRequire.new('lib/gamebot/game/games/*.rb')

require 'gamebot/game/replay/replay'

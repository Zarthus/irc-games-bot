module GameBot
  class PluginLoader
    def initialize(root)
      @root = root
    end

    def list
      return @list_cache if @list_cache

      @list_cache = Dir.glob("#{@root}/plugins/enabled/*.rb")
    end

    def list_rel
      return @list_cache_rel if @list_cache_rel
      list unless @list_cache

      @list_cache_rel = []
      @list_cache.each do |file|
        @list_cache_rel << File.basename(file)
      end

      @list_cache_rel
    end

    def get
      list_rel.each do |file|
        require "gamebot/plugins/enabled/#{file}"
      end

      plugins_load = Plugin.constants.map do |const|
        eval("Plugin::#{const}")
      end
    end
  end
end
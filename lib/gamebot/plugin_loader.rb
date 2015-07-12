module GameBot
  class PluginLoader
    @app_root
    @list_cache = nil

    def initialize(app_root)
      @app_root = app_root
    end

    def list
      if @list_cache
        return @list_cache
      end

      @list_cache = Dir.glob("#{@app_root}/plugins/enabled/*.rb") + Dir.glob("#{@app_root}/plugins/games/enabled/*.rb")
    end

    def get
      list.each do |file|
        load(file)
      end

      plugins_load = Plugin.constants.map do |const|
        eval("Plugin::#{const}")
      end
    end
  end
end
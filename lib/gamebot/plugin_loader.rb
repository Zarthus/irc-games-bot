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

    @list_cache = Dir.glob("#{@app_root}/plugins/enabled/*.rb") + Dir.glob("#{@app_root}/games/enabled/*.rb")
  end

  def get
    plugins = list.each do |file|
      load(file)
    end

    plugins_load = BotPlugin.constants.map do |const|
      eval("BotPlugin::#{const}")
    end
  end
end
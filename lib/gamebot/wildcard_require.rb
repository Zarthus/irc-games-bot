module GameBot
  class WildcardRequire
    using StringRefinement

    def initialize(path)
      @path = path
      @autoloading = {}

      find_files
      autoload_files
    end

    def find_files
      path_all = Dir.glob(@path)

      path_all.each do |path|
        basename = File.basename(path).split('.')[0].underscore
        dirname = File.dirname(path)
        autoload_name = basename.camelize

        @autoloading[autoload_name] = {name: autoload_name, filename: basename, dirname: dirname}
      end
    end

    def autoload_files
      @autoloading.each do |name, hash|
        require File.join(hash[:dirname], hash[:filename]).sub('lib' + File::SEPARATOR, '')
      end
    end
  end
end

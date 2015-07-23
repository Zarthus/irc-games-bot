module GameBot
  module Game
    class MechanismManager
      using StringRefinement

      @loaded = {}

      def add(mechanism)
        if find(mechanism)
          error "Cannot add mechanism #{mechanism}: doesn't exist."
          return false
        end

        if added(mechanism)
          error "Cannot add mechanism #{mechanism}: already added."
          return false
        end

        mechanism.downcase!
        @loaded[mechanism] = eval("Mechanism::#{mechanism.camelize}.new")
        true
      end

      def find(mechanism)
        File.exist?("./mechanism/#{mechanism.underscore}.rb")
      end

      def added(mechanism)
        @loaded.find(mechanism.downcase)
      end

      def list
        @loaded
      end
    end
  end
end

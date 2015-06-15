module Extensions
  module Scoping
    module Helpers
      def current_user
        @user
      end
    end    

    def self.registered(app)
      app.set default_scope: :write
      app.helpers(Helpers)
    end

    def scope(*values)
      condition do
        values = [settings.default_scope] if values == [:default]
        @user = params[:name]

        if @user == 'Masha'
          return true
        end

        if @user == 'Vasya' && values.include?(:read)
          return true
        end  

        halt 401, "#{current_user} is not an admin"
      end
    end

    def route(verb, path, options = {}, &block)
      options[:scope] ||= :default
      super(verb, path, options, &block)
    end
  end
end
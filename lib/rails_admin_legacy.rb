require "rails_admin_legacy/engine"

module RailsAdminLegacy
end

module RailsAdmin
  module Config
    module Actions
      class Legacy < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :link_icon do
          'icon-retweet'
        end

        register_instance_option :member do
          true
        end

        register_instance_option :route_fragment do
          'legacy'
        end

        register_instance_option :http_methods do
          [:get]
        end

        register_instance_option :authorization_key do
          :legacy
        end

        register_instance_option :visible? do
          authorized? && (bindings[:object].class.name.include?('Legacy') rescue false)
        end

        register_instance_option :controller do
          Proc.new do
            if request.get?
              @object.migrate
              flash[:success] = "Migrate completed"
              # redirect_to back_or_index
            end
          end
        end
      end
    end
  end
end
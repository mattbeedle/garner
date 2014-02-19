require "garner"
require "active_record"

module Garner
  module Mixins
    module ActiveRecord
      module Base
        extend ActiveSupport::Concern
        include Garner::Cache::Binding

        included do
          extend Garner::Cache::Binding

          after_create  :_garner_after_create
          after_update  :_garner_after_update
          after_destroy :_garner_after_destroy
        end

        module ClassMethods
          def proxy_binding
            _latest_by_updated_at
          end

          def _latest_by_updated_at
            order('updated_at DESC').first
          end
        end
      end
    end
  end
end

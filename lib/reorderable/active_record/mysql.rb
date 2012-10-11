module Reorderable
  module ActiveRecord
    module MySQL
      extend ActiveSupport::Concern

      module ClassMethods
        # This only works in MySQL because of FIND_BY_SET.
        # Reorder entries based on the order of the IDs passed in
        def reorder!(ids = [], options = {})
          options = { :column => :priority, :list_name => nil, :scope => [] }.merge(options)

          update_all(
            ["#{options[:column]} = FIND_IN_SET(id, ?)", ids.join(',')],
            { :id => ids }
          )
        end
      end # ClassMethods
    end # MySQL
  end # ActiveRecord
end # Reorderable

ActiveRecord::Base.class_eval { include Reorderable::ActiveRecord::MySQL }

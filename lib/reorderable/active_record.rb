module Reorderable
  module ActiveRecord
    extend ActiveSupport::Concern

    module ClassMethods
      def reorderable(opts={})
        sortable(opts)
        column = sortable_lists[opts[:column].to_s][:column]
        default_scope(order("#{column} asc")) if opts[:list_name].blank?
      end

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
  end # ActiveRecord
end # Reorderable

ActiveRecord::Base.class_eval { include Reorderable::ActiveRecord }

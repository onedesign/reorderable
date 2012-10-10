module Reorderable
  module ActiveRecord
    module PostgreSQL
      extend ActiveSupport::Concern

      module ClassMethods
        def reorderable(opts={})
          sortable(opts)
          column = sortable_lists[opts[:column].to_s][:column]
          default_scope(order("#{column} asc")) if opts[:list_name].blank?
        end

        # This will only work on a relatively small data set since we're doing
        # this reordering in Ruby-land.
        def reorder!(ids = [], options = {})
          options = { :column => :priority, :list_name => nil, :scope => [] }.merge(options)

          transaction do
            find(*ids).each do |task|
              # to_s because the ids we get passed in here are actually strings.
              task.update_attribute(options[:column], ids.index(task.id.to_s) + 1)
            end
          end
        end
      end # ClassMethods
    end # PostgreSQL
  end # ActiveRecord
end # Reorderable

ActiveRecord::Base.class_eval { include Reorderable::ActiveRecord::PostgreSQL }

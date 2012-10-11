module Reorderable
  module ActiveRecord
    extend ActiveSupport::Concern

    module ClassMethods
      def reorderable(opts={})
        sortable(opts)
        column = sortable_lists[opts[:column].to_s][:column]
        default_scope(order("#{column} asc")) if opts[:list_name].blank?
      end
    end # ClassMethods
  end # ActiveRecord
end # Reorderable

ActiveRecord::Base.class_eval { include Reorderable::ActiveRecord }

module Reorderable
  module ActionController
    extend ActiveSupport::Concern

    included do
      hide_action :model_klass_name
      helper :reorderable
    end

    def reorder
      model_klass_name.reorder!(params[model_klass_name.to_s.underscore.downcase.to_sym], {:column => params[:reorder_column]})
      render :nothing => true
    end

    def model_klass_name
      self.controller_name.classify.constantize
    end

  end # ActionController
end # Reorderable

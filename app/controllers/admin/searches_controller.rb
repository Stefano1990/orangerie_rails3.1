class Admin::SearchesController < ApplicationController

  def search
    
  end
  
  def index
    @results = reject_nil(find_searchable.search(params[:search][:text]))
  end
  
  private
  
      def find_searchable
        searchable = params[:search][:class].classify.constantize
        return searchable
      end
      
      def reject_nil(results)
         # thinking_sphinx can return a nil value if the search contains a deleted record.
         # this method quickly filters the results returned.
         results.reject{ |k| k.nil? }
      end
      
end

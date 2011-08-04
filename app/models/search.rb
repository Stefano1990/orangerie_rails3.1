class Search < ActiveRecord::Base
  
  def reject_nil
    # thinking_sphinx can return a nil value if the search contains a deleted record.
    # this method quickly filters the results returned.
    reject{ |k| k.nil? }
  end
end

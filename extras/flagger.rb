module Flagger
  def is_flagged?
    !Flag.where(:flaggable_type => self.class.to_s, :flaggable_id => self.id).empty?
  end
end
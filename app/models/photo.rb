class Photo < ActiveRecord::Base
  belongs_to        :user
  belongs_to        :album
  has_many          :comments, :as => :commentable, :dependent => :destroy
  has_many          :activities, :foreign_key => "item_id", :dependent => :destroy, :conditions => "item_type = 'Photo'"
                          
  has_attached_file :image, :styles => { :original => ["465x800>", :png],
                                         :big_avatar => ["200x200#", :png],
                                         :album => ["145x145#", :png], 
                                         :small => ["50x50#", :png],
                                       }
  
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ["image/jpeg", "image/png", "image/gif"]
  
  before_create :sterilize_file_name
  
  def prepare_for_destroy
    # checks if the current photo is the avatar.
    if user.avatar_id == self.id
      user.avatar_id = nil
      user.save!
    end
  end

  def previous(offset = 0)    
      self.class.first(:conditions => ['id < ? AND album_id = ?', self.id, self.album_id], :limit => 1, :offset => offset, :order => "id DESC")
  end

  def next(offset = 0)
    self.class.first(:conditions => ['id > ? AND album_id = ?', self.id, self.album_id], :limit => 1, :offset => offset, :order => "id ASC")
  end
  
  private
  
        def sterilize_file_name
          self.image.instance_write(:file_name, "#{Time.now.to_i.to_s}.png")
        end
end

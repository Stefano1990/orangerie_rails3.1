class PagePhoto < ActiveRecord::Base
  belongs_to        :page
  
  has_attached_file :image, :styles => { :original => ["1000x800>", :png],
                                         :thumb => ["50x50#", :png],
                                       }
  
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => ["image/jpeg", "image/png", "image/gif"]
  
  before_create :sterilize_file_name
  private
  
        def sterilize_file_name
          # This composes a 'google safe' file name. example: 13039843_1.png
          self.image.instance_write(:file_name, "#{Time.now.to_i.to_s}_#{self.page.id}.png")
        end
end

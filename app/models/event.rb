class Event < ActiveRecord::Base
  attr_accessible :title, :short_description, :long_description, :comments, :date, :price_male, :price_female, 
                  :price_couple, :discount, :review, :series_id, :has_comments, :is_review 
  has_many        :reservations
  has_many        :users, :through => :reservations
  has_many        :event_photos
  has_many        :comments, :as => :commentable, :dependent => :destroy
  has_many        :invites, :as => :invitable, :dependent => :destroy
  belongs_to      :series
  
  validates       :title, :presence => true, :length => { :within => 3..200 }
  validates       :short_description, :presence => true, :length => { :within => 3..400 } 
  validates       :long_description, :presence => true, :length => { :within => 3..2000 }
  validates       :price_male, :price_female, :price_couple, :presence => true
  validates       :date, :presence => true
  
  scope :upcoming, lambda { where('events.date > ?', Date.today) }
  scope :today, lambda { where('events.date = ?', Date.today) }
  scope :past, lambda { where('events.date < ?', Date.today) }

  def friends_coming(user)
    contacts = user.contacts
    friends_coming = reservations.find_all_by_user_id(user.contacts).map{|res|res.user}
  end
    
  def total_guests
    total_guests = 0
    # add number of total males
    total_guests += total_males
    # add number of total females
    total_guests += total_females
    # add all the reservations with unknown sex. there shouldnt be any though.
    total_guests += unknown_guests
  end
  
  def total_males
    total_males = 0
    total_males += couples
    total_males += males
    total_males += male_guests
  end
  
  def total_females
    total_females = 0
    total_females += couples
    total_females += females
    total_females += female_guests    
  end
  
  def couples
    couples = 0
    reservations.each do |reservation|
      if reservation.user.infos.sex == "Couple"
        couples += 1
      end
    end
    couples
  end

  def males
    males = 0
    reservations.each do |reservation|
      if reservation.user.infos.sex == "Male"
        males += 1
      end
    end
    males
  end

  def females
    females = 0
    reservations.each do |reservation|
      if reservation.user.infos.sex == "Female"
        females += 1
      end
    end
    females
  end
  
  def unknown_guests
    unknowns = 0
    reservations.each do |reservation|
      if reservation.user.infos.sex.nil?
        unknowns += 1
      end
    end
    unknowns
  end
  def male_guests
    male_guests = 0
    reservations.each do |reservation|
      male_guests += reservation.guests_male
    end
    male_guests
  end
  
  def female_guests
    female_guests = 0
    reservations.each do |reservation|
      female_guests += reservation.guests_female
    end
    female_guests
  end
  
  def previous(offset = 0)    
      self.class.first(:conditions => ['id < ? AND series_id = ?', self.id, self.series_id], :limit => 1, :offset => offset, :order => "id DESC")
  end

  def next(offset = 0)
    self.class.first(:conditions => ['id > ? AND series_id = ?', self.id, self.series_id], :limit => 1, :offset => offset, :order => "id ASC")
  end
  
  # this function enables human friendly URLs for the user model.
  def to_param
    "#{id}-#{title}".downcase.gsub(/\W+/, "-").gsub(/^[-]+|[-]$/,"").strip
  end
end
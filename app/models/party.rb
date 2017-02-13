#
# Table Schema
# ------------
# id            - int(11)      - default NULL
# host_name     - varchar(255) - default NULL
# host_email    - varchar(255) - default NULL
# numgsts       - int(11)      - default NULL
# guest_names   - text         - default NULL
# venue         - varchar(255) - default NULL
# location      - varchar(255) - default NULL
# theme         - varchar(255) - default NULL
# when          - datetime     - default NULL
# when_its_over - datetime     - default NULL
# descript      - text         - default NULL
#
class Party < ApplicationRecord

  # Make sure these parameters exist or it throws an error in validations for 'length' method
  validates :host_name, :host_email, :venue, :location, :theme, :when, :guest_names, presence: true

  validate :validations

  def validations
    if host_name.length>255 || host_email.length>255 || venue.length>255 || location.size>255 || theme.size>255
      errors.add(:base,"Input was too long.")
    end
    # ruby doesn't like us using when as column name for some reason
    if self[:when]>when_its_over
      errors.add(:base,"Incorrect party time.")
    end
    numgsts = 0 if numgsts.nil?
    if venue.length > 0 && location.length < 0
      errors.add(:location,"Where is the party?")
    end
    if guest_names.split(',').size != numgsts
      errors.add(:guest_names,"Missing guest name")
    end
  end

  # Class Method
  def self.order_query(sort_key, sort_order)
    return Party.order("#{sort_key}: #{sort_order}").all
  end

  def after_save
    # clean "Harry S. Truman" guest name to "Harry S._Truman"
    # clean "Roger      Rabbit" guest name to "Roger Rabbit"
    gnames = []
    self.guest_names.split(',').each do |g|
      g.squeeze!
      names=g.split(' ')
      gnames << "#{names[0]} #{names[1..-1].join('_')}"
    end
    self.guest_names = gnames
    self.save!
  end
end

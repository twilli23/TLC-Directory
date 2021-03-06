# frozen_string_literal: true

# @author David J. Davis
# @author Tracy A. McCormick
# @data_model
# @since 0.0.1
class User < ApplicationRecord
  # validation
  validates :first_name, presence: true, length: { within: 2..70 }
  validates :last_name, presence: true, length: { within: 2..70 }
  validates :wvu_username, presence: true, length: { within: 4..70 }

  validates :email, presence: true
  validate :valid_email

  validates :status, presence: true
  validates :visible, inclusion: { in: [true, false] }

  # enums
  enum status: %i[enabled disabled]
  enum role: %i[user editor admin]

  after_initialize do
    if new_record?
      # values will be available for new record forms.
      self.status ||= :disabled
      self.role ||= :user
      self.visible ||= false
    end
  end

  scope :show, -> { where(['visible = ? and status = ?', true, 'enabled']) }
  scope :sorted, -> { order('last_name ASC', 'first_name ASC') }

  # custom methods
  def display_name
    if preferred_name.blank?
      [first_name, middle_name, last_name].join(' ')
    else
      [preferred_name, middle_name, last_name].join(' ')
    end
  end

  # name
  def name
    if preferred_name.blank?
      [first_name, last_name].join(' ')
    else
      [preferred_name, last_name].join(' ')
    end
  end

  def admin?
    role == 'admin' && status? == true
  end

  def status?
    status == 'enabled'
  end

  def visible?
    status? == true && visible
  end

  # custom validations
  def valid_email
    email_regex = !(email =~ /^[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.edu/i).nil?
    errors.add :email, 'must be a valid WVU email.' unless email_regex
  end
end

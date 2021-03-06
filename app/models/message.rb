# == Schema Information
#
# Table name: messages
#
#  id          :integer          not null, primary key
#  sender_id   :integer
#  receiver_id :integer
#  subject     :string(255)
#  message     :text
#  unread      :boolean          default(TRUE)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Message < ActiveRecord::Base
  # attr_accessible :message, :subject

  validates_presence_of :message, :subject, :sender, :receiver
  validates_length_of :subject, maximum: 40, minimum: 3
  validates_length_of :message, maximum: 700, minimum: 10

  belongs_to :sender, class_name: User
  belongs_to :receiver, class_name: User

  def mark_as_read
    if unread
      update_column :unread, false
    end
  end

  def self.messages(user)
    Message.where("sender_id = ? or receiver_id = ?", user.id, user.id)
  end
end

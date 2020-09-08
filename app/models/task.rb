class Task < ApplicationRecord

  belongs_to :list
  belongs_to :quote, optional: true
  belongs_to :invoice, optional: true

  has_many :periods, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :users, through: :user_tasks
  has_many :notes, as: :noteable, dependent: :destroy

  validates :name, presence: true
  before_save :set_price
  before_save :set_approved

  def set_approved
    list.payment_type == "qouted" ? false : true
  end

  def payment_type
    list.payment_type
  end

  def total_length
    sum = 0
    periods.each { |r| sum += r.current_length }
    sum
  end

  def total_price
    sum = 0
    periods.each { |r| sum += r.price }
    sum
  end

  def set_price
    if self.payment_type == "support"
      self.price = self.periods.sum(&:price)
      self.length = self.periods.sum(&:length)
    elsif self.payment_type == "emergency"
      if self.faulty == true
        self.price = 0
      else
        self.price = self.periods.sum(&:price)
        self.length = self.periods.sum(&:length)
      end
    elsif self.payment_type == "my_tasks"
      0
    end
  end

  def complete
    self.update!(completed: true, invoice: self.list.project.current_invoice)
  end

  def humanized_total
    rev_string = price.to_s.reverse
    pennies = rev_string[0..1]&.reverse || '00'
    pounds = rev_string[2..5]&.reverse || '0'
    thousands = rev_string[6..-1]&.reverse
    "£ #{thousands + ',' if thousands}#{pounds}.#{pennies}"
  end

end

class Task < ApplicationRecord
  validates :description, presence: true
  validates :done, inclusion: { in: [ true, false ] }

  def symbol
    case status
    when "pending" then ">>"
    when "done" then "✓"
    when "expired" then "X"
    end
  end

  def css_color
    case status
    when "pending" then "fs-5 fw-bold text-primary"
    when "done" then "fs-5 fw-bold text-success"
    when "expired" then "fs-5 fw-bold text-danger"
    end
  end

  private

  def status
    return "done" if done?
    due_date.past? ? "expired" : "pending"
  end
end

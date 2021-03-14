class TaskList < ApplicationRecord

  acts_as_paranoid

  attribute :status

  # find open tasks
  scope :opened, -> { where(completed_at: nil) }
  # find completed tasks
  scope :closed, -> { where.not(completed_at: nil) }

  # Mark task with "completed" status
  def close
    self.completed_at = Time.now
  end

  # Check task for "completed" status
  def close?
    !completed_at.nil?
  end

  # Mark task with "completed" status with save
  def close!
    close; save
  end

  # Mark task with "open" status
  def open
    self.completed_at = nil
  end

  # Check task for "open" status
  def open?
    completed_at.nil?
  end

  # Mark task with "open" status with save
  def open!
    open; save
  end

  # Get current status
  # Temporaly method. Maybe this will be released with enum
  def status
    open? ? I18n.t('open') : I18n.t('close')
  end

  # Get current status
    def status=(new_status)
    case new_status
    when 'open'
      open
    when 'close'
      close
    end
  end
end

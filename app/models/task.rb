class Task < ApplicationRecord
  belongs_to :list

  scope :order_tasks, -> { order(:position) }

  def swap_positions(pos)
    temp_pos = self.position
    Task.find_by_position(pos).update(position: temp_pos)
    self.update(position: pos)
  end
end

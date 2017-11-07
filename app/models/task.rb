class Task < ApplicationRecord
  belongs_to :list
  before_destroy :update_positions

  scope :order_tasks, -> { order(:position) }

  def swap_positions(pos)
    temp_pos = self.position
    List.find(self.list_id).tasks.find_by_position(pos).update(position: temp_pos)
    self.update(position: pos)
  end



  def update_positions
    List.find(self.list_id).tasks.where("position > ?", self.position).each do |t|
      t.update(position: t.position - 1)
    end
  end


  validates :content, presence: true
  # validates :position, presence: true
end

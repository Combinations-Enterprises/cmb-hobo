class Combination < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    position    :integer
    comb        :text
    description :text
    timestamps
  end
  attr_accessible :position, :comb, :description
  belongs_to :ambiente, :creator => true

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end

end

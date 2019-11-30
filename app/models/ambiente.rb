class Ambiente < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    abecedario        :text
    description       :text
    cant_combinations :integer
    combinacion_final :string
    posicion_final_1  :integer
    posicion_final_2  :integer
    timestamps
  end
  attr_accessible :abecedario, :description, :cant_combinations, :posicion_final_1, :posicion_final_2, :combinacion_final
  has_many :combinations
  belongs_to :user, :creator => true

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

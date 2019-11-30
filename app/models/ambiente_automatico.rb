class AmbienteAutomatico < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    text :string
    timestamps
  end
  attr_accessible :text
  belongs_to :ambiente
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

 def self.amb_aut(ambiente_id,text)
=begin
    @ambiente_id = ambiente_id
    @text = text.to_s
        @text.each {|x| if x != @ambiente_id 
          push.@ambiente_id}
        end

        @ambiente = Ambiente.find(@ambiente_id).abecedario

        text.each do |c|


        end
=end
end
end

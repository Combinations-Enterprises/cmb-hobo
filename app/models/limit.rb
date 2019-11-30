class Limit < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    result_final :float
    array_result :string
    description  :string
    timestamps
  end
  attr_accessible :result_final, :array_result, :description

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

  
    def create_limit
      num = 1
      y = 1
      z = 2 
      cantveces= 200

      #elegir modulo, por ejemplo 0,50
      #elegir crecimiento, por ejemplo, la mitad.
      
      z1 = 2
      z  = 2
      i  = 1
      resultado = num.to_f
      while i <= cantveces do
        
        puts y.to_s+"/"+z1.to_s
        resultado = resultado + (y.to_f / z1.to_f).round(100000) 
        z1 = z1 * 2
        puts "resultado parcial: "+resultado.to_s
        i += 1
      end
      resultado += num

      puts "resultado_final: "+resultado.to_s
  end




 def create_limit_2
      num = 1
      y = 0.0005
      y1= y 
      cantveces= 500

      #elegir modulo, por ejemplo 0,50
      #elegir crecimiento, por ejemplo, la mitad.
      
     
      i  = 1
      resultado = num.to_f
      while i <= cantveces do
        
        puts y.to_s
        resultado = resultado + y1.round(100000) 
        y1 = y1 / 2
        puts "resultado parcial: "+resultado.to_s
        i += 1
      end
      resultado += num

      puts "resultado_final: "+resultado.to_s
  end
    

end
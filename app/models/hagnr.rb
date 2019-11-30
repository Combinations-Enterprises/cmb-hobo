class Hagnr < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    result :integer
    timestamps
  end
  attr_accessible :result

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

  def self.text_to_num(palabra1, ambiente_id)
      @palabra = palabra1
      @cantidad_letras = @palabra.length
      @longitud_palabra = @cantidad_letras - 1
      @ultimo_indice = @cantidad_letras - 1


      ambiente = Ambiente.find(ambiente_id).abecedario
      @cc = Array.new
      ambiente.each_char do |char|
              @cc.push char
      end
      puts "CC: "+@cc.inspect

      @cantidad_de_elementos = @cc.count

      i = 1
      @indice_palabra = 0
      @cantidad_letras = @cantidad_letras + 1
      @results = Array.new
      while i <= @longitud_palabra do

        @letra = @palabra[@indice_palabra]

          @indice = 0
          ii = 0    
          while ii < 2 do
            if @letra == @cc[@indice]
              @posicion = @indice + 1
              ii = 3
            else
              @indice = @indice + 1
              ii = 1
            end
          end

          @cantidad_letras = @cantidad_letras - 1



          r = (@cantidad_de_elementos ** @cantidad_letras) / @cantidad_de_elementos
          @resultado = r * @posicion

          @results.push @resultado

        i += 1
        @indice_palabra += 1
      end


      

      @letra = @palabra[@ultimo_indice]
      @ultimo_indice = 0
      ii = 0    
      @indice = 0
      while ii < 2 do
        if @letra == @cc[@indice]
          @posicion = @indice + 1
          ii = 3
        else
          @indice = @indice + 1
          ii = 1
        end
      end

      @results.push @posicion

      
      

      @result_final = 0
      @new_results = @results.map{|r| r} 
      @new_results.each do |re|
        @result_final += re
      end


      puts @results
      puts "suma total:"
      puts @result_final

      
      #a = Ambiente.find(ambiente_id)
      #a.posicion_final_1 = @result_final.to_i
      #a.save

      return @result_final
      
      
  end

end

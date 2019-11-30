class AmbientesController < ApplicationController



  hobo_model_controller

  auto_actions :all

  show_action :borpp, :babel, :hagnr, :contador, :limit,:bor_plus_plus

  def bor_plus_plus
    hobo_show do
      if params[:position] then
        @nro_x        = params[:position]
        @id_ambiente  = params[:id]
        
        @posicion_final = Borpp.num_to_text(@nro_x,@id_ambiente)

	      
      end
    end
  end


  
  def babel
    hobo_show do
    end
  end

  def hagnr
    hobo_show do
      if params[:palabra_1] then
        @pal_1 = params[:palabra_1] 
        @pal_2 = params[:palabra_2] 
        @ida   = params[:id]
      

        @resp1 = Hagnr.text_to_num(@pal_1, @ida)
        @resp2 = Hagnr.text_to_num(@pal_2, @ida)
        

        puts "/////////////////////////////////////////"
        puts "/////////////////////////////////////////"
        puts "/////////////////////////////////////////"
        puts "/////////////////////////////////////////"


        puts "POSICION FINAL UNO: "+@resp1.to_s
        puts "POSICION FINAL DOS: "+@resp2.to_s


           @suma= @resp1.to_i + @resp2.to_i
        if @resp1.to_i < @resp2.to_i then
          @distancia = @resp2.to_i - @resp1.to_i
        else
          @distancia = @resp1.to_i - @resp2.to_i
        end


      end
      
    end
  end


  def contador
    hobo_show do
    end
  end


  def limit
    hobo_show do
    end
  end

end



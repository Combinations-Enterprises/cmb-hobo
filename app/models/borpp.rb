class Borpp < ActiveRecord::Base

    hobo_model # Don't put anything above this

    fields do
        result      :string
        description :string
        timestamps
    end
    attr_accessible :result, :description

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

    def self.num_to_text(nro_x, id_ambiente)

        @nro_x = nro_x.to_i
        @id_ambiente = id_ambiente.to_i

        puts "NRO POSICION: "+@nro_x.to_s
        puts "ID DEL AMBIENTE: "+@id_ambiente.to_s

        ambiente = Ambiente.find(@id_ambiente).abecedario
        @cc = Array.new
        ambiente.each_char do |char|
            @cc.push char
        end


        #@cc = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
        # k = cantidad_elementos

        @cantidad_k = @cc.count
        @cantidad_q = @cantidad_k

        puts"CANTIDAD K (CANT DE ELEMENTOS)" +@cantidad_k
        puts"CANTIDAD Q (CANT DE ELEMENTOS)" +@cantidad_q

        @comb_posibles = Array.new
        @comb_posibles.push @cantidad_q
        puts "count @cc = @cantidad_k:"+@cantidad_k.to_s

        @comb_total = 0
        @suma = @cantidad_k
        @comb_ultima = funcion_x(@suma)
        puts "@comb_total = "+@comb_total.to_s
        puts "@comb_ultima  = "+@comb_ultima.to_s


        @longitud = @comb_posibles.count
      
        @cant_suma = @longitud - 1
        @i = 0
        @comb_previas = 0
        while @i < @cant_suma do
            @comb_previas = @comb_previas + @comb_posibles[@i]
            @i += 1
        end
        puts "@comb_previas: "+@comb_previas.to_s

        @posicion_final = posicion_de_la_combinacion(@nro_x, @comb_previas, @comb_posibles, @cantidad_q)
      
        puts  "POSICION FINAL: "+@posicion_final

        #a = Ambiente.find(@id_ambiente)
        #a.combinacion_final = @posicion_final
        #a.save

        return @posicion_final
    end



    def self.funcion_x(suma)
        if @suma >= @nro_x
            puts "es mayor y sale"
            puts @cantidad_k.to_s
            return @cantidad_k
        elsif @cantidad_k < @nro_x
            @cantidad_k = @cantidad_k * @cantidad_q
            @comb_posibles.push @cantidad_k
            puts "Array @comb_posibles = " + @comb_posibles.to_s
            @comb_total = @comb_total + @cantidad_k
            puts "K = "+@cantidad_k.to_s
            @suma = @suma + @cantidad_k
            puts "llamo de nuevo a la nueva funcion"
            funcion_x(@suma)
        end
    end



    def self.posicion_de_la_combinacion(nro_x, comb_previas, comb_posibles, cantidad_q)
        puts "________"
        puts "________"
        puts "POSICION DE LA COMBINACION"
        @results = ""

        puts "_____________"
        puts "@nro_x:"+@nro_x.to_s
        @posicion_relativa = @nro_x - @comb_previas
        puts "@posicion_relativa: "+@posicion_relativa.to_s
        puts "_____________"
        puts " "
        puts " "

        nex = true  
        puts "@comb_posibles_reverse: "+@comb_posibles.reverse.to_s
        @comb_posibles.reverse.each do |cp|
            if nex == true
                nex = false
                next
            else
                @r = @posicion_relativa.to_f / cp.to_f
                puts "cp "+cp.to_s
                @r1 = @r % 1




                #FORMA ALTERNATIVA PARA CALCULAR @R Y @ ERRE. LO QUE SE HACE CON ESTE METODO ES TOMAR EL COCIENTE ENTERO DE UNA DIVICION, PARA LUEGO BUSCAR
                #EL INDICE. ALGUNOS LET1 NO SE IMPRIMEN EN LA PANTALLA.
              
                @resto = @posicion_relativa.to_f % cp.to_f
                @erre= ((@posicion_relativa.to_f % cp.to_f) - @resto) / cp.to_f 
                @equis = (((@posicion_relativa.to_f) - @resto) / cp.to_f) % cp.to_f
                @equis = @equis % 26
              
                if @equis == 1 then
                    @equis = 0 
                end

                @let1 = @cc[@equis]


                puts "let1 "+@let1.to_s
                puts "equis "+@equis.to_s

                if @erre == 0
                    @erre =  @cantidad_q - 1    
                    puts "erre "+@erre.to_s
                end
              
                puts "@r:"+@r.to_s
                puts "@r1:"+@r1.to_s

                if @r1 == 0.0 then
                    puts "@r1 == 0.0"
                    @new_r = @r % @cantidad_q
                    if @new_r == 0 then
                        @new_r = @cantidad_q - 1
                    else
                        @new_r -= 1
                    end
                else
                    puts "@r1 != 0.0"
                    @r = @r.to_i + 1
                    @new_r = @r % @cantidad_q
                    if @new_r == 0
                        @new_r = @cantidad_q - 1
                    else
                        @new_r -= 1
                    end
                end
                puts "@r: "+@r.to_s
                puts "new r: "+@new_r.to_s

                letra = @cc[@equis]
                puts "XXXXXXX: "+@equis.to_s
                puts "NEW_R: "+@new_r.to_s
                puts "LETRA: "+letra.to_s
                @results = @results + letra
                puts "__________________________"
                puts "__________________________"
            end  
        end

    
        @posc_ultima_letra = @posicion_relativa % @cantidad_q
        if @posc_ultima_letra == 0
            @posc_ultima_letra = @cantidad_q - 1
            @ultima_letra = @cc[@posc_ultima_letra]
            puts "ultima_letra: "+@cc[@posc_ultima_letra]
        else
            @posc_ultima_letra = @posc_ultima_letra - 1
            @ultima_letra = @cc[@posc_ultima_letra]
            puts "ultima_letra: "+@cc[@posc_ultima_letra]
        end
        @results = @results + @ultima_letra
        puts @results.to_s
        return @results
    end
end

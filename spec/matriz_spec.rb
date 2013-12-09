require "./lib/math_expansion.rb"

describe MathExpansion::Matriz do
    before :each do
        @m1 = MathExpansion::Matriz.new(5, 5)
    end
    describe " # Almacenamiento de matrices. " do
        it " # Se debe almacenar el numero de filas." do
            @m1.N
        end
        it " # Se debe almacenar el numero de columnas." do
            @m1.M
        end
        it " # Se debe almacenar un contenido." do
            @m1.contenido
        end
    end
end


describe MathExpansion::MatrizDSL do
    before :all do
        class Fixnum
            def self.null
                0
            end
        end
        
        class String
            def self.null
                ""
            end
        end
        
        class Float
            def self.null
                0.0
            end
        end
        
        # Etc
    end
    describe " # Almacenamiento de operandos y matrices." do
      it " # Se debe poder leer una matriz." do
        @m1 = MathExpansion::MatrizDSL.new("lectura") do
          opcion "nada"        
          opcion "auto"
        
          operando [[1, 2],[3,4]]
        end
        @m1.resultado.to_s.should == "1\t2\t\n3\t4\t\n"
      end
    end
    
    describe " # Operaciones con matrices." do
      it " # Se deben poder sumar matrices." do
        @m1 = MathExpansion::MatrizDSL.new("suma") do
          opcion "fichero"        
          opcion "auto"
        
          operando [[-1, -1],[1, 1]]
          operando [[1,1], [3, -1]]
        end
        @m1.resultado.to_s.should == "Fila 0: \nFila 1: 0=>4 \n"
        
        @m2 = MathExpansion::MatrizDSL.new("suma") do
          opcion "nada"        
          opcion "denSA"
        
          operando [[-1, -1],[1, 1]]
          operando [[1,1], [3, -1]]
        end
        @m2.resultado.to_s.should == "0\t0\t\n4\t0\t\n"
        
        # Resto de operaciones aquí
      end
    end
end

describe MathExpansion::Matriz_Densa do
    before :all do
        class Fixnum
            def self.null
                0
            end
        end
        
        class String
            def self.null
                ""
            end
        end
        
        class Float
            def self.null
                0.0
            end
        end
        
        # Etc
    end
    
    before :each do
        @m1 = MathExpansion::Matriz_Densa.new(2,2)
        @m2 = MathExpansion::Matriz_Densa.new(2,2)
        
        @m1.set(0,0,1)
        @m1.set(0,1,2)
        @m1.set(1,0,3)
        @m1.set(1,1,4)
        
        @m2.set(0,0,5)
        @m2.set(0,1,6)
        @m2.set(1,0,7)
        @m2.set(1,1,8)
        
    end
    describe " # Almacenamiento de matrices. " do
        it " # Se debe poder acceder a los datos almacenados en la matriz " do      
            @m1.get(0,0).should eq(1)
            @m1.get(0,1).should eq(2)
        end
        it " # Se debe poder leer los datos de una matriz " do      
            (MathExpansion::Matriz_Densa.leerArray([[1, 2, 3],[4,5,6]])).to_s.should == "1\t2\t3\t\n4\t5\t6\t\n"
        end
        it " # Se deben poder modificar los datos almacenados en la matriz " do     
            @m1.set(0,0,5)
            @m1.get(0,0).should eq(5)
            
            @m1.set(0,1,8)
            @m1.get(0,1).should eq(8)
        end
        it " # Se deben poder almacenar todo tipo de datos numericos (flotantes, enteros, etc...) " do      
            @m1.set(0,0,3.0)
            @m1.set(0,1,-6)
            @m1.to_s.should == "3.0\t-6\t\n3\t4\t\n"
        end
    end

    describe " # Operaciones con matrices densas. " do
    it " # Se debe poder sumar dos matrices " do
        @m3 = MathExpansion::Matriz_Densa.new(2,2)
        @m3.set(0,0,6)
        @m3.set(0,1,8)
        @m3.set(1,0,10)
        @m3.set(1,1,12)

        (@m1+@m2).to_s.should eq(@m3.to_s)
    end

    it " # Se debe poder restar dos matrices " do
        @m3 = MathExpansion::Matriz_Densa.new(2,2)
        @m3.set(0,0,4)
        @m3.set(0,1,4)
        @m3.set(1,0,4)
        @m3.set(1,1,4)

        (@m2-@m1).to_s.should eq(@m3.to_s)
    end
    it " # Se debe poder multiplicar dos matrices " do
        @m3 = MathExpansion::Matriz_Densa.new(2,2)
        @m3.set(0,0,19)
        @m3.set(0,1,22)
        @m3.set(1,0,43)
        @m3.set(1,1,50)

        (@m1*@m2).to_s.should eq(@m3.to_s)
    end
    it " # Si una m. densa tiene mas de un 60% de nulos, debe ser dispersa." do
	@m_neg = MathExpansion::Matriz_Densa.new(2,2)
	@m_neg.set(0,0,-1)
	@m_neg.set(0,1,-2)
	@m_neg.set(1,0,-3)
	@m_neg.set(1,1,-1)

	@m3 = MathExpansion::Matriz_Dispersa.new(2,2)
	@m3.set(1,1,3)

	(@m1+@m_neg).to_s.should eq(@m3.to_s)
    end
    it " # Se debe poder operar con Fracciones." do
	@mf = MathExpansion::Matriz_Densa.new(2,2)
	@mf.set(0,0,MathExpansion::Fraccion.new(1,3))
	@mf.set(0,1,MathExpansion::Fraccion.new(1,3))
	@mf.set(1,0,MathExpansion::Fraccion.new(1,3))
	@mf.set(1,1,MathExpansion::Fraccion.new(1,3))

	@mf_res = MathExpansion::Matriz_Densa.new(2,2)
	@mf_res.set(0,0,MathExpansion::Fraccion.new(2,3))
	@mf_res.set(0,1,MathExpansion::Fraccion.new(2,3))
	@mf_res.set(1,0,MathExpansion::Fraccion.new(2,3))
	@mf_res.set(1,1,MathExpansion::Fraccion.new(2,3))

	(@mf+@mf).to_s.should eq(@mf_res.to_s)
    
    @mf1 = MathExpansion::Matriz_Densa.new(2,2)
    @mf1.set(1,0,MathExpansion::Fraccion.new(1,4))
     
    @mf2 = MathExpansion::Matriz_Densa.new(2,2)
    @mf2.set(0,0,1)
    
    @mf_res = MathExpansion::Matriz_Dispersa.new(2,2)
    @mf_res.set(1,0,MathExpansion::Fraccion.new(1,4))
        
    (@mf1 * @mf2).to_s.should == @mf_res.to_s
    
    end
    end
    describe " # Operaciones varias. " do
        it " # Se debe poder calcular el maximo de una matriz densa (elemento no nulo)" do
		  @m1.max.should == 4
		end
		it " # Se debe poder calcular el minimo de una matriz densa (elemento no nulo)" do
		  @m2.min.should == 5
		end
    end
end


describe MathExpansion::Matriz_Dispersa do
    before :all do
        class Fixnum
            def self.null
                0
            end
        end
        
        class String
            def self.null
                ""
            end
        end
        
        class Float
            def self.null
                0.0
            end
        end
        
        # Etc
    end
    
    before :each do
        @m1 = MathExpansion::Matriz_Densa.new(3,2)
        
        @m1.set(0,0,0)
        @m1.set(0,1,0)
        
        @m1.set(1,0,1)
        @m1.set(1,1,3)
        
        @m1.set(2,0,0)
        @m1.set(2,1,0)
        
        @md1 = MathExpansion::Matriz_Dispersa.copy(@m1)
        @md2 = MathExpansion::Matriz_Dispersa.new(3, 2)
        
    end
    
    describe " # Almacenamiento de matrices. " do
        it " # Se debe poder crear matrices dispersas vacias o a partir de matrices densas." do     
            MathExpansion::Matriz_Dispersa.new(5, 5)
            MathExpansion::Matriz_Dispersa.copy(@m1)
        end
        
        it " # Se debe poder calcular el porcentaje de elementos nulos de la matriz dispersa." do
            @md2.null_percent.should == 1.0
            @md1.null_percent.should == 4.0/6.0
        end
        
        it " # Se debe poder acceder a los elementos de la matriz dispersa." do
            @md2.get(0,0).should == 0
            
            @md1.get(1,1).should == 3
            @md1.get(1,0).should == 1
            @md1.get(0,0).should == 0
            
            @md1.get(10,10).should == nil
        end
        
        it " # Se deben poder modificar los elementos de la matriz dispersa." do
            @md2.set(0,0,1)
            @md2.get(0,0).should == 1
            
            @md2.set(0,1,1)
            @md2.set(1,0,1)
            @md2.set(1,1,1)
            @md2.set(2,0,1)
            @md2.set(2,1,1)
            
            # Elemento nulo debido a que ha sobrepasado el porcentaje maximo de valores nulos
            @md2.get(2,1).should == 0
            
            @md1.set(1,1,4)
            @md1.set(1,0,2)
            @md1.get(1,1).should == 4
            @md1.get(1,0).should == 2
            
            @md1.get(0,0).should == 0
        end
        
        it " # Se debe poder transformar una matriz dispersa a una cadena de caracteres." do
            @md1.to_s.should == "Fila 0: \nFila 1: 0=>1 1=>3 \nFila 2: \n"
            @md2.to_s.should == "Fila 0: \nFila 1: \nFila 2: \n"
        end

    
    end

    describe " # Operaciones con matrices dispersas. " do
    it " # Se debe poder sumar dos matrices " do        
        @md3 = MathExpansion::Matriz_Dispersa.new(3,2)
        @md3.set(0,0,0)
        @md3.set(0,1,0)
        @md3.set(1,0,1)
        @md3.set(1,1,3)
        @md3.set(2,0,0)
        @md3.set(2,1,0)
        
        
        (@md1+@md2).to_s.should eq(@md3.to_s)
    end
    it " # Se debe poder restar dos matrices " do
        @md3 = MathExpansion::Matriz_Dispersa.new(3,2)
        @md3.set(0,0,0)
        @md3.set(0,1,0)
        @md3.set(1,0,-1)
        @md3.set(1,1,-3)
        @md3.set(2,0,0)
        @md3.set(2,1,0)

        (@md2-@md1).to_s.should eq(@md3.to_s)
    end
    it " # Se debe poder multiplicar dos matrices " do
        @md4 = MathExpansion::Matriz_Dispersa.new(2,3)
        @md4.set(1,0,-1)
        @md4.set(1,1,-1)
        @md4.set(1,2,0)
        
        @md3 = MathExpansion::Matriz_Dispersa.new(3,3)
        @md3.set(0,0,0)
        @md3.set(0,1,0)
        @md3.set(0,2,0)
        @md3.set(1,0,-3)
        @md3.set(1,1,-3)
        @md3.set(1,2,0)
        @md3.set(2,0,0)
        @md3.set(2,1,0)
        @md3.set(2,2,0)

        (@md1*@md4).to_s.should eq(@md3.to_s)
    end
    it " # Se debe poder hacer operaciones con Fracciones. " do
	@mf1 = MathExpansion::Matriz_Dispersa.new(2,2)
	@mf1.set(1,0,MathExpansion::Fraccion.new(1,4))

	@mf2 = MathExpansion::Matriz_Dispersa.new(2,2)
	@mf2.set(1,0,MathExpansion::Fraccion.new(-1,4))

	@mf_res = MathExpansion::Matriz_Dispersa.new(2,2)
	@mf_res.set(1,0,MathExpansion::Fraccion.new(1,2))

	(@mf1-@mf2).to_s.should eq(@mf_res.to_s)
    
    
     @mf3 = MathExpansion::Matriz_Dispersa.new(2,2)
     @mf3.set(1,0,MathExpansion::Fraccion.new(1,4))
     
     @mf4 = MathExpansion::Matriz_Dispersa.new(2,2)
     @mf4.set(0,0,1)
     
     (@mf3 * @mf4).to_s.should == @mf3.to_s
     
     @mf5 = MathExpansion::Matriz_Densa.new(2,2)
     @mf6 = MathExpansion::Matriz_Dispersa.new(2,2)

     @mf5.set(0,0,3)
     @mf5.set(0,1,4)
     @mf5.set(1,0,5)
     @mf5.set(1,1,6)

     @mf6.set(0,0,MathExpansion::Fraccion.new(1,2))

     @mf_res2 = MathExpansion::Matriz_Densa.new(2,2)
     @mf_res2.set(0,0,MathExpansion::Fraccion.new(7,2))
     @mf_res2.set(0,1,4)
     @mf_res2.set(1,0,5)
     @mf_res2.set(1,1,6)

     (@mf5+@mf6).to_s.should == @mf_res2.to_s
    
    end


    end
	    describe " # Operaciones varias. " do
        it " # Se debe poder calcular el maximo de una matriz densa (elemento no nulo)" do
		  @md1.set(1,0,4)
		  @md1.max.should == 4
		end
		it " # Se debe poder calcular el minimo de una matriz densa (elemento no nulo)" do
		  @md1.min.should == 1
		end
    end
end

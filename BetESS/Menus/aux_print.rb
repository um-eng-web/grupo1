module AuxPrint

  def AuxPrint.listar(lista)
    opt=1
    cnt=1
    if lista.empty?
      puts 'Sem registos'
    else
      lista.values.each{ |item|
          if cnt%10 == 0
            puts 'Deseja continuar a ver?'
            puts '0 - Não'
            puts '1 - Sim'
            opt = gets.chomp.to_i
            break if opt == 0
          else
            puts item.to_s
            cnt += 1
          end
      }
    end
  end

end
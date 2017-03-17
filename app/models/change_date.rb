class ChangeDate < ApplicationRecord
  def change_date(date, op, value)
    # Separando string para determinar quem é dia, mes, ano, hora, minuto
    dia_atual    = date.split(" ").first.split("/").first
    mes_atual    = date.split(" ").first.split("/").second
    ano_atual    = date.split(" ").first.split("/").last
    horas_atual   = date.split(" ").last.split(":").first
    minutos_atual = date.split(" ").last.split(":").last
    
    #puts "o dia atual é #{dia_atual} e o mes atual é #{mes_atual} e o mes atual é #{ano_atual} e a hora atual é #{hora_atual} e o minuto atual é #{minuto_atual}"
    
    #estipulando quantos horas e minutos tem dentro do valor
    horas = value.to_f / 60
    minutos = value.to_f % 60
    #puts "O valor total de horas é de #{horas.to_i} e minutos #{minutos.to_i}"
    
    #estipulando quantos dias tem dentro do valor
    dias = horas.to_i / 24
    puts "A quantidade de dias #{dias.to_i}"
    
   
    if op.eql? "+"
      horas_final   = horas_atual.to_i + horas.to_i
      minutos_final = minutos_atual.to_i + minutos.to_i
      dias_final    = dia_atual.to_i + dias.to_i
      if horas_final >= 24
        horas_final = horas_final.to_i - 24
      end
    end 
    puts "O valor final é #{dias_final}/#{mes_atual}/#{ano_atual} #{horas_final}:#{minutos_final}"
  end
end

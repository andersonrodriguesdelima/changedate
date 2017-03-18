class ChangeDate < ApplicationRecord
  def change_date(date, op, value)

    # Separando string para determinar quem é dia, mes, ano, hora, minuto
    dia_atual     = date.split(" ").first.split("/").first.to_i
    mes_atual     = date.split(" ").first.split("/").second.to_i
    ano_atual     = date.split(" ").first.split("/").last.to_i
    horas_atual   = date.split(" ").last.split(":").first#.to_i
    minutos_atual = date.split(" ").last.split(":").last#.to_i

    horas      = value.to_f / 60
    minutos    = value.to_f % 60
    dias       = horas.to_i / 24

    minutos_final = minutos_atual.to_i + minutos.to_i
    dias_final  = dia_atual
    mes_final   = mes_atual
    ano_final   = ano_atual
    horas_final = horas_atual

    if op.eql? "+"
      (1..horas.to_i).each do |x|
        horas_final = horas_final.to_i + 1
        if horas_final == 24
          dias_final += 1
          horas_final = horas_final - 24
        end
        if dias_final > self.ultimo_dia_mes(mes_atual)
          dias_final = 1
          mes_final += 1 #= mes_final + 1
        end
        if mes_final > 12
          ano_final += 1 #= ano_final + 1
          mes_final = 1
        end
      end
    end

    puts "O valor final é #{dias_final}/#{mes_final}/#{ano_final} #{horas_final}:#{minutos_final}"
  end

  def ultimo_dia_mes(mes)
    meses_30_dias = [4, 6, 9, 11]
    meses_31_dias = [1, 3, 5, 7, 8, 10, 12]
    if meses_30_dias.include?(mes)
      return 30
    end
    if meses_31_dias.include?(mes)
      return 31
    end

    return 28
  end

end

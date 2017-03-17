class ChangeDate < ApplicationRecord
  def change_date(date, op, value)

    # Separando string para determinar quem é dia, mes, ano, hora, minuto
    dia_atual     = date.split(" ").first.split("/").first
    mes_atual     = date.split(" ").first.split("/").second
    ano_atual     = date.split(" ").first.split("/").last
    horas_atual   = date.split(" ").last.split(":").first
    minutos_atual = date.split(" ").last.split(":").last

    # Estipulando quantos horas e minutos tem dentro do valor
    horas      = value.to_f / 60
    minutos    = value.to_f % 60
    dias       = horas.to_i / 24
    if op.eql? "+"
      horas_final   = horas_atual.to_i + horas.to_i
      minutos_final = minutos_atual.to_i + minutos.to_i
      if horas_final >= 24
        dias += 1
        horas_final = horas_final - (24 * dias)
      end
      dias_final    = dia_atual.to_i + dias.to_i
      if dias_final > self.ultimo_dia_mes(mes_atual)
        dias_final = dias_final - self.ultimo_dia_mes(mes_atual)
        mes_final = mes_atual.to_i + 1
      else
        mes_final = mes_atual
      end
    end

    puts "O valor final é #{dias_final}/#{mes_final}/#{ano_atual} #{horas_final}:#{minutos_final}"
  end

  def ultimo_dia_mes(mes)
    meses_30_dias = ["04", "06", "09", "11"]
    meses_31_dias = ["01", "03", "05", "07", "08", "10", "12"]
    if meses_30_dias.include?(mes)
      return 30
    end
    if meses_31_dias.include?(mes)
      return 31
    end

    return 28
  end

end

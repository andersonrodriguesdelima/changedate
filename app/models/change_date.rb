class ChangeDate < ApplicationRecord

  def self.change_date(date, operacao, minutos)
    return ArgumentError, "Data não pode ser vazia" if date.to_s.empty?
    return ArgumentError, "Operação não pode ser vazia" if operacao.to_s.empty?
    return ArgumentError, "Operação inválida. Somente são permitidas as operações + e -" if !(["+", "-"].include? operacao)
    return ArgumentError, "Minutos não pode ser vazio" if minutos.to_s.empty?

    # Separando string para determinar quem é dia, mes, ano, hora, minuto
    dia_atual     = date.split("T").first.split("-").last.to_i
    mes_atual     = date.split("T").first.split("-").second.to_i
    ano_atual     = date.split("T").first.split("-").first.to_i
    horas_atual   = date.split("T").last.split(":").first#.to_i
    minutos_atual = date.split("T").last.split(":").last#.to_i

    horas      = minutos.to_f / 60
    minutos    = minutos.to_f % 60
    dias       = minutos.to_i / 24

    dias_final  = dia_atual
    mes_final   = mes_atual
    ano_final   = ano_atual
    horas_final = horas_atual

    if operacao.eql? "+"
    minutos_final = minutos_atual.to_i + minutos.to_i
     (1..horas.to_i).each do |h|
        horas_final = horas_final.to_i + 1
        if horas_final == 24
          dias_final += 1
          horas_final = horas_final - 24
        end
        if dias_final > self.ultimo_dia_mes(mes_atual)
          dias_final = 1
          mes_final += 1
        end
        if mes_final > 12
          ano_final += 1
          mes_final = 1
        end
      end
    end

    if operacao.eql? "-"
      minutos_final = minutos_atual.to_i
      (1..minutos.to_i).each do |m|
        minutos_final = minutos_final.to_i - 1
        if minutos_final < 0
          horas_final = horas_final.to_i - 1
          minutos_final = 59
        end
      end
      (1..horas.to_i).each do |h|
        horas_final = horas_final.to_i - 1
        if horas_final < 0
          horas_final = horas_final + 24
          dias_final -= 1
        end
        if dias_final < 0
          mes_final  = mes_final - 1
          if mes_final == 0
            ano_final -= 1
            mes_final = 12
          end
          dias_final = self.ultimo_dia_mes(mes_final)
        end
      end
    end
    if horas_final.to_s.size.eql? 1
      horas_final = "0#{horas_final}"
    end
    if minutos_final.to_s.size.eql? 1
      minutos_final = "0#{minutos_final}"
    end
    if minutos_final.to_s.size.eql? 0
      minutos_final = "00"
    end
    return "#{dias_final}/#{mes_final}/#{ano_final} #{horas_final}:#{minutos_final}"
  end

  def self.ultimo_dia_mes(mes)
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

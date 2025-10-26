class DecimalPlacesValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # Pega o número de casas decimais permitidas do parâmetro 'places'
    # Ex: validates :preco, decimal_places: { places: 2 }
    places = options.fetch(:places)

    # Ignora valores nulos (deixe isso para o 'validates :presence')
    return if value.nil?

    # Precisamos verificar o valor antes da conversão de tipo,
    # pois o Rails pode arredondar ou converter o valor.
    # Usamos '_before_type_cast' para pegar a string original.
    value_before_cast = record.public_send("#{attribute}_before_type_cast")

    # Se o valor original for nulo ou uma string vazia, não há o que validar.
    return if value_before_cast.nil? || value_before_cast.blank?

    # Converte para string para garantir que podemos usar 'split'
    value_str = value_before_cast.to_s

    # Separa a parte inteira da decimal
    parts = value_str.split(".")

    # Se houver uma parte decimal (parts.size == 2)
    if parts.size == 2
      decimal_part = parts.last
      # Verifica se a quantidade de casas decimais é maior que a permitida
      if decimal_part.length > places
        # Adiciona o erro ao objeto
        record.errors.add(attribute, :too_many_decimal_places, count: places)
      end
    end

  # Caso o valor não possa ser comparado (ex: um texto não numérico)
  # Deixamos para outros validadores (como o numericality) tratarem.
  rescue StandardError
    record.errors.add(attribute, :invalid_decimal_format)
  end
end

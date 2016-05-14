json.key_format! camelize: :lower
json.array! @places do |place|
  json.cnes_id      place.cnes_id
  json.name         place.name
  json.description  place.description
  json.address      place.address
  json.owner        place.owner
  json.phone        place.phone
  json.openHour     place.openHour
  json.openDay      place.openDay

  json.offers place.offers.each do |offer|

    json.oid           offer.id

    #Fallback: caso não tenha nenhum dia da semana especifico do servico, utilizar o padrão do local
    if offer.avaiableDay == ""
      json.avaiableDay place.openDay
    else
      json.avaiableDay  offer.avaiableDay
    end

    #Fallback: caso não tenha nenhum Horário especifico do servico, utilizar o padrão do local
    if offer.avaiableHour == ""
      json.avaiableHour place.openHour
    else
      json.avaiableHour  offer.avaiableHour
    end

    #Fallback: caso não tenha nenhum contato especifico do servico, utilizar o padrão do local
    if offer.contact == ""
      json.contact place.phone
    else
      json.contact  offer.contact
    end

    #Fallback: caso não tenha nenhum requisito especifico do local, utilizar o padrão do serviço
    if offer.requirement == ""
      json.requirement offer.service.requirement
    else
      json.requirement  offer.requirement
    end
    json.services do
      json.name         offer.service.name
      json.description  offer.service.description
      json.requirement  offer.service.requirement

    end

  end

end

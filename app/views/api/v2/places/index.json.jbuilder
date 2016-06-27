# json.key_format! camelize: :lower

json.array! @places do |place|
json.set! :place do
  json.id           place.incremental_id
  json.name         place.name
  json.description  place.description
  json.owner        place.owner
  json.created_at   place.created_at
  json.updated_at   place.updated_at
  json.cnes_id      place.cnes_id
  json.address      place.address
  json.phone        place.phone
  json.openHour     place.openHour
  json.openDays     place.openDay

  json.associations place.offers.where(visible: true) do |offer|
    #Fallback: caso não tenha nenhum dia da semana especifico do servico, utilizar o padrão do local
    if offer.avaiableDay == ""
      json.avaiableDays place.openDay
    else
      json.avaiableDays  offer.avaiableDay
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

    json.updated_at offer.updated_at
    #Fallback: caso não tenha nenhum requisito especifico do local, utilizar o padrão do serviço
    if offer.requirement == ""
      json.requirement offer.service.requirement
    else
      json.requirement  offer.requirement
    end
    json.services_name do
      json.id           offer.service.incremental_id
      json.name         offer.service.name
      json.description  offer.service.description
      json.access       offer.service.requirement

    end

  end
end

end

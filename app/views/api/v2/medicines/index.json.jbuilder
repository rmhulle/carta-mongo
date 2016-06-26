# json.key_format! camelize: :lower
json.array! @medicines do |medicine|
  json.id           medicine.incremental_id
  json.name         medicine.name
  json.owner        medicine.owner
  json.description  medicine.description
  json.standard     medicine.standard

  json.pcdts medicine.pcdts do |pcdt|
    json.id                   pcdt.incremental_id
    json.clinical_situation   pcdt.clinical_situation
    json.ministerial_order    pcdt.ministerial_order
    json.order_url            pcdt.order_url
    json.order_date           pcdt.order_date
    json.updated_at           pcdt.updated_at
  end

  json.presentations medicine.presentations do |presentation|
    json.id                   presentation.incremental_id
    json.description          presentation.name
    json.updated_at           presentation.updated_at
  end

  # json.requirements medicine.requirements do |requirement|
  #   json.id                   requirement.incremental_id
  #   json.url                  requirement.url
  #   json.first_time           requirement.first_time
  #   json.monitoring           requirement.monitoring
  #   json.cid10                requirement.cid10
  # end



end

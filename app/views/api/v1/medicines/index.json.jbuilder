json.key_format! camelize: :lower
json.array! @medicines do |medicine|
  json.id           medicine.id
  json.name         medicine.name
  json.salt         medicine.salt
  json.owner        medicine.owner
  json.description  medicine.description
  json.standard     medicine.standard
end

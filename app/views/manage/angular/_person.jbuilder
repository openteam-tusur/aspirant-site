json.id             person.id
json.name           person.name
json.surname        person.surname
json.fullname       person.fullname
json.patronymic     person.patronymic
json.current_post   person.post_for(context) if defined?(context)
json.science_title  person.science_title
json.science_degree person.science_degree

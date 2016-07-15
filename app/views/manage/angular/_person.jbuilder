json.id             person.id
json.url            person.url
json.name           person.name
json.surname        person.surname
json.fullname       person.fullname
json.work_post      person.work_post
json.patronymic     person.patronymic
json.work_place     person.work_place
json.current_post   person.post_for(context) if defined?(context)
json.science_title  person.science_title
json.science_degree person.science_degree

$(document).on 'ready page:load', ->

  $(document).on 'click', 'a.disabled', ->
    return false

  $('[data-toggle="tooltip"]').tooltip()

  init_user_autocomplete() if $('.js-user-autocomplete').length
  init_colorbox() if $('a.colorbox').length

  return

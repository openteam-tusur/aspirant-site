angular
  .module('dashboard')
  .factory('localization', ['$http',
    ($http) ->
      f = {}

      f.getLocalization = () ->
        $http
          .get '/manage/angular/get_locale_hash'
          .success (data) ->
            f.locale = data.locale

      f.l = (string) ->
        return string unless f.locale
        result = f.recursiveLocalization(f.locale, string)
        result || string


      f.recursiveLocalization = (obj, string) =>
        keys = string.split('.')
        return undefined unless obj
        return obj[string] if keys.length == 1
        key = keys.shift()
        f.recursiveLocalization obj[key], keys.join('.')

      return f
    ])

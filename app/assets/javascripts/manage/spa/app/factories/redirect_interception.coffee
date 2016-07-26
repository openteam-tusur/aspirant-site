angular
  .module('dashboard')
  .factory('redirectInterception', [ '$location', '$window',
    ($location, $window) ->
      f = {}

      f.request = (config) ->
        config.headers['CurrentLocation'] = $window.location.href
        config

      f.responseError = (rejection) ->
        if rejection.status == 401
          console.warn "redirected to #{rejection.data.url}"
          $window.location = rejection.data.url

      return f
    ])

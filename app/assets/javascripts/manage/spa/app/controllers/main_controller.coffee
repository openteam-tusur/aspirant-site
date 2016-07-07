angular
  .module('dashboard')
  .controller('MainController', ['$scope', '$state', '$http', ($scope, $state, $http) ->
    $scope.$state = $state

    $scope.getLocalization = () ->
      $http
        .get '/manage/angular/get_locale_hash'
        .success (data) ->
          $scope.locale = data.locale

    $scope.l = (string) ->
      return string unless $scope.locale
      result = $scope.recursiveLocalization($scope.locale, string)
      result || string

    $scope.recursiveLocalization = (obj, string) =>
      keys = string.split('.')
      return undefined unless obj
      return obj[string] if keys.length == 1
      key = keys.shift()
      $scope.recursiveLocalization obj[key], keys.join('.')

    $scope.getLocalization()
    ])

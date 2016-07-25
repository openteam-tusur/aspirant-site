angular
  .module('dashboard')
  .controller('MainController', ['$scope', '$state', '$http', 'localization', ($scope, $state, $http, localization) ->

    $scope.$state = $state

    $scope.getDictionary = (dictionary, callback) ->
      $http
        .get "manage/angular/get_#{dictionary}"
        .success callback

    $scope.removeElementFrom = (array, element) ->
      i = array.indexOf element
      array.splice i, 1

    localization.getLocalization()
    $scope.localization = localization
    $scope.l = localization.l

    ])

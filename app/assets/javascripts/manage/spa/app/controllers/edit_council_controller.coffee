angular
  .module('dashboard')
  .controller('EditCouncilController', ['$scope', '$http', ($scope, $http) ->

    $scope.getCouncil = () ->
      id = $scope.$state.params.councilId
      $http
      .get "manage/dissertation_councils/#{id}"
        .success (data) ->
          $scope.council = data
        .error -> $scope.$state.go 'dashboard'

    $scope.initializer = ()->
      $scope.getCouncil()

    $scope.initializer()

  ])

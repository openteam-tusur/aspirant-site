angular
  .module('dashboard')
  .controller('CouncilsController', ['$scope', '$http', ($scope, $http) ->

    $scope.getCouncils = () ->
      $scope.getDictionary 'councils', (data) ->
        $scope.councils = data.councils

    $scope.submitCouncil = () ->
      council = $scope.new_council
      $http
        .post '/manage/dissertation_councils', council
        .success (data) ->
          $scope.councils.unshift data
          $scope.resetCouncil()
          $scope.toggleForm()

    $scope.removeCouncil = (council) ->
      confirm $scope.l('councils.confirm'), $scope.actuallyRemove(council)

    $scope.actuallyRemove = (council) ->
      $http
        .delete "/manage/dissertation_councils/#{council.id}"
        .success (data) ->
          $scope.removeElementFrom $scope.councils, council

    $scope.toggleForm = () ->
      $scope.formToggled = !$scope.formToggled

    $scope.resetCouncil = () ->
      $scope.new_council = {}

    $scope.initializer = () ->
      $scope.resetCouncil()
      $scope.getCouncils()

    $scope.initializer()
    ])

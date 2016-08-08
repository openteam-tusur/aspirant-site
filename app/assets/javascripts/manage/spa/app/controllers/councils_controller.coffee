angular
  .module('dashboard')
  .controller('CouncilsController', ['$scope', '$http', ($scope, $http) ->

    $scope.getCouncils = () ->
      $http
        .get '/manage/dissertation_councils'
        .success (data) ->
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
      $scope.actuallyRemove(council) if confirm $scope.l('councils.confirm')

    $scope.actuallyRemove = (council) ->
      $http
        .delete "/manage/dissertation_councils/#{council.id}"
        .success (data) ->
          $scope.removeElementFrom $scope.councils, council

    $scope.toggleForm = () ->
      $scope.formToggled = !$scope.formToggled
      $scope.new_council.number = null

    $scope.resetCouncil = () ->
      $scope.new_council = {}

    $scope.initializer = () ->
      $scope.resetCouncil()
      $scope.getCouncils()

    $scope.initializer()
    ])

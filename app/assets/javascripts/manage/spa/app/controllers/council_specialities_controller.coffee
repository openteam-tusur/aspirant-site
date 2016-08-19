angular
  .module('dashboard')
  .controller('CouncilSpecialitiesController', ['$scope', '$http', ($scope, $http) ->

    $scope.getSpecialities = () ->
      $http
        .get '/manage/council_specialities'
        .success (data) ->
          $scope.specialities = data

    $scope.setSpecialityActive = (speciality) ->
      $scope.activeSpecialityForm = speciality.id

    $scope.restoreSpeciality = (speciality) ->
      $http
        .get "/manage/council_specialities/#{speciality.id}"
        .success $scope.specialityCallBack

    $scope.saveSpeciality = (speciality) ->
      params = {speciality: speciality}
      $http
        .patch "/manage/council_specialities/#{speciality.id}", params
        .success $scope.specialityCallBack

    $scope.specialityCallBack = (data) ->
      speciality = $scope.specialities.find (s) -> s.id = data.id
      angular.copy data, speciality
      $scope.activeSpecialityForm = null

    $scope.getSpecialities()
    ])

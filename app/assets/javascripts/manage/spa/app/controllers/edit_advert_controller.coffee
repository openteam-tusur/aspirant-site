angular
  .module('dashboard')
  .controller('EditAdvertController', ['$scope', '$http', ($scope, $http) ->
    console.time('controller loaded')

    $scope.getAdvert = () ->
      id = $scope.$state.params.advertId

      $http
        .get "manage/adverts/#{id}"
          .success (data) ->
            $scope.advert = {}
            $scope.stored_advert = {}
            angular.copy data, $scope.advert
            angular.copy data, $scope.stored_advert                 #object for changes detection
            console.timeEnd('controller loaded')
          .error -> $scope.$state.go 'dashboard'

    $scope.contextFor = (string) ->
      if $scope.advert
        $scope["#{string}_context"] = {
          context_type: 'Advert'
          context_id:   $scope.advert.id
          person_type: string
        }

    $scope.updateField = (field) ->
      if $scope.fieldChanged(field) && $scope.advert[field]
        params = {
          id: $scope.advert.id
          advert:
            "#{field}": $scope.advert[field]
        }
        $http
          .patch "manage/adverts/#{$scope.advert.id}", params
          .success (data) ->
            $scope.stored_advert[field] = data[field]

    $scope.fieldChanged = (field) ->
      return false unless $scope.advert && $scope.stored_advert
      $scope.advert[field] != $scope.stored_advert[field]

    $scope.addSpeciality = (speciality, callback) ->
      if speciality.id
        $scope.advert.council_speciality = speciality
        $scope.advert.council_speciality_id = speciality.id
        $scope.updateField 'council_speciality_id'
        callback() if callback
      else
        params = { speciality: speciality }
        $http
          .post "manage/council_specialities", params
          .success (data) -> $scope.addSpeciality(data, callback)

    $scope.destroySpeciality = () ->
      $scope.advert.council_speciality_id = null
      $scope.advert.council_speciality = null
      $scope.updateField 'council_speciality_id'

    $scope.destroyPost = (person, person_type) ->
      params = $scope.contextFor person_type
      $http
        .post "/manage/people/#{person.id}/remove_from_advert", params
        .success (data) ->
          if data
            obj = $scope.advert[person_type] || $scope.advert["#{person_type}s"]
            if obj.constructor == Array            #multiple model
              $scope.removeElementFrom $scope.advert["#{person_type}s"], person
            else if obj.constructor == Object
              $scope.advert[person_type] = null    #single role (mentor or applicant)

    $scope.capitalize = (string) ->
      string.charAt(0).toUpperCase() + string.slice(1)

    $scope.submitAdvert = () ->
      params = $scope.createParams()
      $http
        .post "manage/adverts/#{$scope.advert.id}"
        .success (data) ->
          $scope.advert = data

    $scope.getAvalaibleCouncils = () ->
      $http
        .get '/manage/dissertation_councils'
        .success (data) ->
          $scope.avalaibleCouncils = data.councils

    $scope.updateDissertationCouncil = () ->
      $scope.advert.dissertation_council_id = $scope.advert.dissertation_council.id
      $scope.updateField "dissertation_council_id"

    $scope.getAvalaibleCouncils()
    $scope.getAdvert()
    ])

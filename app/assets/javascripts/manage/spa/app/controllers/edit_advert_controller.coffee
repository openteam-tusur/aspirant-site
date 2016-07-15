angular
  .module('dashboard')
  .controller('EditAdvertController', ['$scope', '$http', ($scope, $http) ->
    console.time('controller loaded')

    $scope.getAdvert = () ->
      id = $scope.$state.params.advertId

      $http
        .get "manage/adverts/#{id}"
          .success (data) ->
            $scope.advert = data
            console.timeEnd('controller loaded')
          .error -> $scope.$state.go 'dashboard'

    $scope.contextFor = (string) ->
      if $scope.advert
        $scope["#{string}_context"] = {
          context_type: 'Advert'
          context_id:   $scope.advert.id
          person_type: string
        }

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

    $scope.getAdvert()
    ])

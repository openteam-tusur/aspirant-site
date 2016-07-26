angular
  .module('dashboard')
  .controller('AdvertsController', ['$scope', '$http', '$state', ($scope, $http, $state) ->
      $scope.url  = "manage/announcements/"
      $scope.getAdverts = ()->
        $http
          .get $scope.url
          .success (data) ->
            $scope.adverts = data

      $scope.addAdvert = ()->
        $http
          .post $scope.url, {}
          .success (data) ->
            $state.go 'advert_edit', advertId: data.id

      $scope.destroyAdvert = (advert) ->
        $http
          .delete "#{$scope.url}#{advert.id}"
          .success (data) ->
            if data
              $scope.removeElementFrom $scope.adverts, advert

      $scope.changeState = (advert, transition) ->
        $http
          .post "#{$scope.url}#{advert.id}/#{transition}"
          .success (data) ->
            advert.aasm_state = data.state

      $scope.resolveChangeStateVisibility = (advert, state) ->
        state == advert.aasm_state

      $scope.getAdverts()
    ])

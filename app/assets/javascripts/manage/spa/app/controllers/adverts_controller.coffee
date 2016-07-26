angular
  .module('dashboard')
  .controller('AdvertsController', ['$scope', '$http', '$state', ($scope, $http, $state) ->
      $scope.getAdverts = ()->
        $http
          .get '/manage/adverts'
          .success (data) ->
            $scope.adverts = data

      $scope.addAdvert = ()->
        $http
          .post '/manage/adverts', {}
          .success (data) ->
            $state.go 'advert_edit', advertId: data.id

      $scope.destroyAdvert = (advert) ->
        $http
          .delete "manage/adverts/#{advert.id}"
          .success (data) ->
            if data
              $scope.removeElementFrom $scope.adverts, advert

      $scope.changeState = (advert, transition) ->
        $http
          .post "manage/adverts/#{advert.id}/#{transition}"
          .success (data) ->
            advert.aasm_state = data.state

      $scope.resolveChangeStateVisibility = (advert, state) ->
        state == advert.aasm_state

      $scope.getAdverts()
    ])

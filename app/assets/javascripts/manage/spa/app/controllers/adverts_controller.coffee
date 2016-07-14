angular
  .module('dashboard')
  .controller('AdvertsController', ['$scope', '$http', ($scope, $http) ->
      $scope.getAdverts = ()->
        $http
          .get '/manage/adverts'
          .success (data) ->
            $scope.adverts = data

      $scope.getAdverts()
    ])

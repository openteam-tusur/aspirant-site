angular
  .module('dashboard')
  .controller('MainController', ['$scope', '$state', '$http', ($scope, $state, $http) ->
    $scope.user = 'test'
    ])

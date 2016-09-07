angular
  .module('dashboard')
  .controller('MainController',
    ['$scope', '$state', '$http', 'localization',
      ($scope, $state, $http, localization) ->

        $scope.getUserInfo = (callback) ->
          $http
            .get "/manage/angular/get_current_user_info"
            .success callback

        $scope.userIs = (roleName) ->
          return false unless $scope.userInfo
          $scope.userInfo.roles.indexOf(roleName) >= 0

        $scope.getDictionary = (dictionary, callback) ->
          $http
            .get "/manage/angular/get_#{dictionary}"
            .success callback

        $scope.removeElementFrom = (array, element) ->
          i = array.indexOf element
          array.splice i, 1

        initializer = () ->
          $scope.$state = $state
          localization.getLocalization()
          $scope.localization = localization
          $scope.l = localization.l
          $scope.$on 'Load', () ->
            $scope.loadStatus = true
          $scope.$on 'Unload', () ->
            $scope.loadStatus = false
          $scope.getUserInfo (data) ->
            $scope.userInfo = data

        initializer()
    ])

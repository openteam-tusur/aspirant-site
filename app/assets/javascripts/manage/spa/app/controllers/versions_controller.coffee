angular
  .module('dashboard')
  .controller('VersionsController', ['$scope', '$http', '$state', ($scope, $http, $state) ->
      $scope.getItemVersions = (item_type, item_id) ->
        item_type = 'announcements' if item_type == 'advert'
        $scope.$emit 'Load'
        $http
          .get "/manage/#{item_type}/#{item_id}/versions"
          .success (data) ->
            $scope.itemVersions = data
            $scope.$emit 'Unload'

      $scope.getItemChanges = (changesObject) ->
        resultObject = {}
        if Object.keys(changesObject).length != 0
          for key of changesObject
            first_state = changesObject[key][0] || ''
            second_state = "#{changesObject[key][1] || ''}"
            resultObject[key] = if first_state then "#{first_state}" else 'Не указано'
            resultObject[key] += " -> " if second_state
            resultObject[key] += second_state

        return resultObject

      $scope.getItemVersions($scope.$state.params.item_type, $scope.$state.params.item_id)
    ])

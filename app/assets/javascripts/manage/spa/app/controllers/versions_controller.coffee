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
        changesObject.forEach (item, i, arr) ->
          for key of item
            resultObject[key] = "#{item[key][0]} -> #{item[key][1]}"

        return resultObject

      $scope.getItemVersions($scope.$state.params.item_type, $scope.$state.params.item_id)
    ])

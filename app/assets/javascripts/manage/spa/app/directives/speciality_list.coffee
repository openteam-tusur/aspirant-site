angular.module('dashboard')
  .directive('specialityList', ['$http', 'localization',
    ($http, localization) ->
      return {
        scope:
          speciality: '=speciality'
          specialities:  '=specialities'
          destroyFunction: '=destroyFunction'
          updateOrderFunction: '=updateOrderFunction'

        transclude: true
        restrict: 'E'
        templateUrl: 'speciality_list.html'
        controller: ($scope, $http, localization) ->
          $scope.l = localization.l

          $scope.updateOrder = (event, ui) ->
            index = ui.item.index()
            speciality = $scope.specialities[index]
            $scope.updateOrderFunction speciality, index

          $scope.sortableOptions = {
            axis: 'y'
            cursor: 'move'
            handle: '.handle'
            stop: $scope.updateOrder
          }
      }
    ])

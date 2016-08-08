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

          $scope.detectEqualItem = (speciality) ->
            return speciality == $scope.sortItem

          $scope.updateOrder = (event, ui) ->
            $scope.orderAllItems = false
            index = ui.item.index()
            speciality = $scope.specialities[index]
            $scope.updateOrderFunction speciality, index
            $scope.sortItem = speciality

          $scope.orderSpecialitiesCompare = (a, b) ->
            if (a.title < b.title)
              return -1
            if (a.title > b.title)
              return 1
            return 0

          $scope.specialitiesAlfavitOrder = ->
            $scope.specialities.sort($scope.orderSpecialitiesCompare)

            index = 0
            for speciality in $scope.specialities
              $scope.updateOrderFunction speciality, index
              index++

            $scope.orderAllItems = true

          $scope.sortableOptions = {
            axis: 'y'
            cursor: 'move'
            handle: '.handle'
            stop: $scope.updateOrder
          }
      }
    ])

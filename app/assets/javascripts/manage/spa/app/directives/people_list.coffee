angular.module('dashboard')
  .directive('peopleList', ['$http', 'localization',
    ($http, localization) ->
      return {
        scope:
          person:  '=person'
          person_type:  '@personType'
          people:  '=people'
          destroyPersonFunction: '=destroyWith'
          updateOrderFunction: '=updateOrderFunction'
          context: '=context'

        transclude: true
        restrict: 'E'
        templateUrl: 'people_list.html'
        controller: ($scope) ->
          $scope.l = localization.l

          $scope.personDegrees = (person) ->
            result = []
            for string in [person.science_title, person.science_degree]
              result.push string if string
            result.join(', ')

          $scope.updateOrder = (_, ui) ->
            index = ui.item.index()
            person = $scope.people[index]
            $scope.updateOrderFunction person, index

          $scope.sortableOptions = {
            axis: 'y'
            cursor: 'move'
            handle: '.handle'
            stop: $scope.updateOrder
          }
      }
    ])

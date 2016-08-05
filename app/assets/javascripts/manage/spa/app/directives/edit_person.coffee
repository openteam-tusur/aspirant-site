angular.module('dashboard')
  .directive('editPerson', ['$http', 'localization',
    ($http, localization, science) ->
      return {
        scope:
          actionTarget: "=actionTarget"
        transclude: true
        restrict: 'E'
        templateUrl: 'edit_person.html'
        controller: ($scope, localization, science) ->
      }
    ])

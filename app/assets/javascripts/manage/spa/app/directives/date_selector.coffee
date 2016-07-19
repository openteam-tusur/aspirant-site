angular
  .module('dashboard')
  .directive('dateSelector', [
    () ->
      return {
        scope:
          label:  '@label'
          target: '=target'
          updateFunction: '=updateFunction'
          fieldName: '@fieldName'
          parentObject: '=parentObject'
        transclude: true
        restrict: 'E'
        templateUrl: 'date-selector.html'
        link: ($scope, element, attributes) ->
          target = $scope.target
          element
            .find('.js-date-picker')
            .datepicker
              format: 'dd.mm.yyyy'
              language: 'ru'
          if target
            $scope.innerDate = target.split('-')
                                     .reverse()
                                     .join('.')
          else
            $scope.innerDate = moment().format('DD[.]MM[.]YYYY')
          element
            .find('.js-date-picker')
            .datepicker("update", $scope.innerDate)

        controller: ($scope) ->
          $scope.updateTarget = () ->
            if $scope.target != $scope.innerDate.replace(/\./g, '-')
              $scope.target = $scope.innerDate.replace(/\./g, '-')
              setTimeout(
                ()-> $scope.updateFunction($scope.fieldName, $scope.parentObject),
                100
                ) #wait for SLOW databinding


      }
    ])

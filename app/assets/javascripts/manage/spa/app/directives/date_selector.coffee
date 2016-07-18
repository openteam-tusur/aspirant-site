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
        transclude: true
        restrict: 'E'
        templateUrl: 'date-selector.html'
        controller: ($scope) ->
          if $scope.target
            $scope.innerDate = $scope.target
                                     .split('-')
                                     .reverse()
                                     .join('.')
          else
            $scope.innerDate = moment().format('DD[.]MM[.]YYYY')

          $scope.updateTarget = () ->
            $scope.target = $scope.innerDate.replace(/\./g, '-')
            setTimeout(
              ()-> $scope.updateFunction($scope.fieldName),
              100
              ) #wait for SLOW databinding

          $('#date-picker')
            .datepicker
              format: 'dd.mm.yyyy'
              language: 'ru'

          $('#date-picker').datepicker("update", $scope.innerDate)

      }
    ])

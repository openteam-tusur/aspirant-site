angular.module('dashboard')
  .directive('textInput', ['$http', 'localization',
    ($http, localization) ->
      return {
        scope:
          target: "=target"
          updateFunction: "=updateFunction"
          targetContext: "=targetContext"

        transclude: true
        restrict: 'E'
        templateUrl: 'text_input.html'
        controller: ($scope, localization) ->
          $scope.l = localization.l

          $scope.makeBackup = () ->
            if ['string', 'number'].indexOf(typeof $scope.target) >= 0
              $scope.backupTarget = $scope.target

          $scope.cancel = () ->
            $scope.showInput = false
            if ['string', 'number'].indexOf(typeof $scope.target) >= 0
              $scope.target = $scope.backupTarget

          $scope.updateCallback = (state) ->
            if state == true
              $scope.showInput = false
            else
              $scope.error = state
              $scope.showError = true

          $scope.save = () ->
            $scope.updateFunction $scope.targetContext, $scope.updateCallback

          $scope.makeBackup()
      }
    ])

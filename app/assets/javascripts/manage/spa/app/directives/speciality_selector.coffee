angular.module('dashboard')
  .directive('specialitySelector', ['$http', 'localization',
    ($http, localization) ->
      return {
        scope:
          newPerson: "=newPerson"
          person: "=person"
          specialities: "=specialities"
          context: "=context"
          updateFunction: "=updateFunction"

        transclude: true
        restrict: 'E'
        templateUrl: 'speciality_selector.html'
        controller: ($scope, $timeout, localization) ->
          $scope.l = localization.l

          $scope.hideSpecialitySelector = ->
            $scope.showSpecialitySelector = false

          $scope.cancel = () ->
            $scope.hideSpecialitySelector()

          $scope.currentPersonSpeciality = (specialities, person) ->
            for speciality in specialities
              if speciality.id == person.current_post.council_speciality_id
                return speciality

          $scope.updateCallback = (state) ->
            if state == true
              $scope.hideSpecialitySelector()
              $scope.highlight = true
              $timeout ->
                $scope.highlight = false
              , 800

            else
              $scope.error = state
              $scope.showError = true

          $scope.updateSpeciality = (post) ->
            post.council_speciality_id = $scope.chosenSpeciality.id
            $scope.updateFunction post, $scope.updateCallback

          $scope.setNewPersonSpeciality = (person) ->
            person.post.council_speciality_id = $scope.chosenSpeciality.id
      }
  ])

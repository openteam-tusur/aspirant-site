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
          labelText: "=labelText"

        transclude: true
        restrict: 'E'
        templateUrl: 'speciality_selector.html'
        link: ($scope, element) ->
          element.on 'click', (e)->
            e.stopPropagation()

          $(document).on 'click', ->
            if $scope.showSpecialitySelector && element.find('change-selector:visible')
              $scope.$apply ->
                $scope.showSpecialitySelector = false

        controller: ($scope, $timeout, localization) ->
          $scope.l = localization.l

          $scope.hideSpecialitySelector = ->
            $scope.showSpecialitySelector = false

          $scope.showSelect = () ->
            $scope.showSpecialitySelector = !$scope.showSpecialitySelector
            $scope.closestEvent()

          $scope.cancel = () ->
            $scope.hideSpecialitySelector()

          $scope.specialitiesLoadedState = (specialities) ->
            if Array.isArray(specialities)
              return true

          $scope.currentPersonSpeciality = (specialities, person) ->
            if $scope.specialitiesLoadedState(specialities)
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
            person.post ||= {}
            person.post.council_speciality_id = $scope.chosenSpeciality.id

          $scope.cleanSelector = ->
            $scope.chosenSpeciality = null

          $scope.withoutClickEvent = ->

          $scope.closestEvent = () ->
            $scope.withoutClickEvent()

          $scope.$on 'cleanPerson', $scope.cleanSelector
          $scope.chosenSpeciality = $scope.currentPersonSpeciality($scope.specialities, $scope.person)
      }
  ])

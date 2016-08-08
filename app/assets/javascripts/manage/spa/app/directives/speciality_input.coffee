angular.module('dashboard')
  .directive('specialityInput', ['$http', 'localization',
    ($http, localization) ->
      return {
        scope:
          specialities:  '=specialities'
          addFunction: '=addFunction'
          speciality: '=speciality'
          isSingle: '@isSingle'
          showSearch: '=showSearch'
        transclude: true
        restrict: 'E'
        templateUrl: 'speciality_input.html'
        controller: ($scope, $http, localization) ->
          $scope.l = localization.l
          $scope.new_speciality = {}

          $scope.requestFormatter = (q) ->
            {
              q: q
              "ids[]": ($scope.specialities || [$scope.speciality])
                        .filter (s) -> s && s.hasOwnProperty "id"
                        .map (s) -> s.id
            }

          $scope.searchResponseFormatter = (response_array) ->
            response_array.push code: $scope.l('speciality.create_new')
            response_array

          $scope.addSpeciality = (obj) ->
            if obj
              speciality = obj.originalObject
              if speciality.id
                $scope.addFunction speciality, $scope.hideSpecialityForm
                $scope.showSearch = false
              else
                $scope.showCreateSpecialityForm = true

          $scope.showSearchButton = () ->

          $scope.createNewSpeciality = () ->
            if $scope.specialityForm.$valid
              $scope.addFunction $scope.new_speciality, $scope.hideSpecialityForm          #code and title
            else
              $scope.specialityForm.$setSubmitted()
              for _, input of $scope.specialityForm
                if input && input.$name
                  input.$setDirty()

          $scope.hideSpecialityForm = () ->
            $scope.new_speciality = {}
            $scope.$broadcast 'angucomplete-alt:clearInput', 'speciality-angucomplete'
            $scope.showCreateSpecialityForm = false
            $scope.showSearch = false

      }
    ])

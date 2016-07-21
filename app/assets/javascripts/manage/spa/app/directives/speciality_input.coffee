angular.module('dashboard')
  .directive('specialityInput', ['$http', 'localization',
    ($http, localization) ->
      return {
        scope:
          specialities:  '=specialities'
          addFunction: '=addFunction'
          speciality: '=speciality'
          isSingle: '@isSingle'
        transclude: true
        restrict: 'E'
        templateUrl: 'speciality_input.html'
        controller: ($scope, $http, localization) ->
          $scope.l = localization.l
          $scope.new_speciality = {}
          $scope.new_speciality_science_type = {}

          $scope.getScienceTypes = () ->
            params = class_name: 'CouncilSpeciality', enumerize_value: 'science_type'
            $http
              .get "/manage/angular/get_enumerize_values", params: params
              .success (data) ->
                $scope.avalaibleScienceTypes = data.values


          $scope.requestFormatter = (q) ->
            {
              q: q
              "ids[]": ($scope.specialities || [$scope.speciality])
                        .filter (s) -> s && s.hasOwnProperty "id"
                        .map (s) -> s.id
            }

          $scope.searchResponseFormatter = (response_array) ->
            response_array.push code: $scope.l('app.nothing_found')
            response_array

          $scope.addSpeciality = (obj) ->
            if obj
              speciality = obj.originalObject
              if speciality.id
                $scope.addFunction speciality, $scope.hideSpecialityForm
                $scope.showSearch = false
              else
                $scope.new_speciality_science_type = $scope.avalaibleScienceTypes[0]
                if $scope.new_speciality_science_type
                  $scope.new_speciality.science_type = $scope.avalaibleScienceTypes[0].enumerized
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
            $scope.new_person = {}
            $scope.$broadcast 'angucomplete-alt:clearInput', 'speciality-angucomplete'
            $scope.showCreateSpecialityForm = false
            $scope.showSearch = false

          $scope.cloneScienceType = (science_type) ->
            $scope.new_speciality.science_type = science_type.enumerized

          $scope.getScienceTypes()
      }
    ])

angular.module('dashboard')
  .directive('specialityForm', ['$http', 'localization', 'science',
    ($http, localization, science) ->
      return {
        scope:
          speciality:  '=speciality'
        transclude: true
        restrict: 'E'
        templateUrl: 'speciality_form.html'
        controller: ($scope, $http, localization) ->
          $scope.l = localization.l
          $scope.science = science

          $scope.cloneScienceType = () ->
            $scope.speciality.science_type = $scope.speciality_science_type.enumerized

          $scope.scienceCallback = (data) ->
            science_type = data.values.find (e) ->
              e.enumerized == $scope.speciality.science_type
            $scope.speciality_science_type = science_type || data.values[0]
            $scope.cloneScienceType()
          science.getScienceTypes $scope.scienceCallback
      }
    ])

angular.module('dashboard')
  .directive('personForm', ['$http', 'localization', 'science',
    ($http, localization, science) ->
      return {
        scope:
          new_person:  '=person'
          personNotFound: '=personNotFound'
          formObject: '=formObject'
          infoUpdateFunction: '=infoUpdateFunction'
        transclude: true
        restrict: 'E'
        templateUrl: 'person_form.html'
        controller: ($scope, localization, science) ->
          $scope.science_dictionaries = science
          $scope.science = {}
          $scope.activePersonForm = null
          $scope.l = localization.l

          $scope.copyToPerson = (field, model) ->                                      #workaround for easier sending to rails
            current_object = $scope.science_dictionaries["#{field}s"].find (obj) ->
                                    obj.value == model

            $scope.new_person[field] = current_object.value
            $scope.new_person["#{field}_abbr"] = current_object.abbr

          $scope.cleanPerson = () ->
            $scope.science = {}
            $scope.new_person = {}

          $scope.associateScienceDictionaries = () ->
            for key in  ['science_degree', 'science_title']
              if $scope.new_person[key]
                $scope.science[key] = $scope.science_dictionaries["#{key}s"]
                                            .find (e) ->
                                              e.value == $scope.new_person[key]

          $scope.$on 'cleanPerson', $scope.cleanPerson
          science.getScienceDictionaries($scope.associateScienceDictionaries)
      }
    ])

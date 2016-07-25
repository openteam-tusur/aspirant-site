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

          $scope.copyToPerson = (field) ->                                      #workaround for easier sending to rails
            $scope.new_person[field] = $scope.science[field]['value']           #just copy data from $scope to $scope.new_person
            $scope.new_person["#{field}_abbr"] = $scope.science[field]['abbr']

          $scope.cleanPerson = () ->
            $scope.science = {}
            $scope.new_person = {}

          $scope.associateScienceDictionaries = () ->
            for key in  ['science_degree', 'science_title']
              if $scope.new_person[key]
                $scope.science[key] = $scope.science_dictionaries["#{key}s"]
                                            .find (e) ->
                                              e.value == $scope.new_person[key]

          $scope.setSpeciality = (speciality, callback) ->
            unless speciality.id
              params = { speciality }
              $http
                .post 'manage/council_specialities', params
                .success (data) ->
                  $scope.new_person.council_speciality_id = data.id
                  $scope.new_person.speciality = data
                  callback()
            $scope.new_person.council_speciality_id = speciality.id
            $scope.new_person.speciality = speciality
            callback()

          $scope.destroySpeciality = () ->
            $scope.new_person.council_speciality_id = null
            $scope.new_person.speciality = null

          $scope.$on 'cleanPerson', $scope.cleanPerson
          science.getScienceDictionaries($scope.associateScienceDictionaries)
      }
    ])

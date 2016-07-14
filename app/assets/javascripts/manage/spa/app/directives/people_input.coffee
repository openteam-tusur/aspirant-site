angular.module('dashboard')
  .directive('peopleInput', ['$http', 'localization',
    ($http, localization) ->
      return {
        scope:
          context: '=context'
          people:  '=people'
          kind:    '@kind'
        transclude: true
        restrict: 'E'
        templateUrl: 'people_input.html'
        controller: ($scope, localization) ->
          $scope.l = localization.l
          for key in ['new_person', 'science']
            $scope[key] = {}

          $scope.setPerson = (obj) ->
            unless obj.originalObject.id
              $scope.personNotFound = true
            else
              $scope.new_person = obj.originalObject

          $scope.fillPerson = (person) ->
            u = $scope.new_person
            for key in ['patronymic', 'surname', 'name', 'academic_degree']
              u[key] = person[key]
            u.directory_id = person.id
            u.academic_title = person.academic_rank
            $scope.updateDirectorySearch()

          $scope.cleanPerson = () ->
            $scope.new_person = {}

          $scope.showPostForm = () ->
            u = $scope.new_person
            u.name && u.surname

          $scope.submitPerson = () ->
            params = Object.assign {}, $scope.context
            params['person'] = $scope.new_person
            $http
              .post '/manage/people', params
              .success (data) ->
                $scope.people.push data
                $scope.cleanPerson()
                $scope.hideForm()


          $scope.copyToPerson = (field) ->                                      #workaround for easier sending to rails
            $scope.new_person[field] = $scope.science[field]['value']           #just copy data from $scope to $scope.new_person
            $scope.new_person["#{field}_abbr"] = $scope.science[field]['abbr']

          $scope.updateDirectorySearch = () ->
            query = []
            for key in ['name', 'surname', 'patronymic']
              query.push $scope.new_person[key]
            query = query.join(' ')
            $http
              .get '/manage/people/directory_search', params: { term: query }
              .success (data) ->
                $scope.directory_search = data

          $scope.postsOf = (result) ->
            result.split(';')

          $scope.hideForm = () ->
            $scope.personNotFound = false

          $scope.requestFormatter = (str) ->
            q: str, ids: $scope.people.map((p) -> p.id )

          $scope.getScienceDictionaries = () ->
            $http
              .get 'manage/angular/get_science_degrees_and_titles'
              .success (data) ->
                $scope.avalaibleAcademicTitles = data.science_titles
                $scope.avalaibleAcademicDegrees = data.science_degrees

          $scope.searchResponseFormatter = (data) ->
            results = []
            for result in data
              results.push result
            unless data.length
              empty_object = {
                fullname: 'Ничего не найдено'
                id: false
              }
              results.push empty_object
            return results

          $scope.getScienceDictionaries()

      }
    ])

angular.module('dashboard')
  .directive('peopleList', ['$http', 'localization',
    ($http, localization) ->
      return {
        scope:
          context: '=context'
          people:  '=people'
          kind:    '@kind'
        transclude: true
        restrict: 'E'
        templateUrl: 'people_list.html'
        controller: ($scope, localization) ->

          $scope.l = localization.l
          $scope.new_person = {}

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
            $http
              .post '/url', params
              .success (data) ->
                console.log data

          $scope.updateDirectorySearch = () ->
            query = []
            for key in ['name', 'surname', 'patronymic']
              query.push $scope.new_person[key]
            query = query.join(' ')
            $http
              .get '/manage/users/directory_search', params: { term: query }
              .success (data) ->
                $scope.directory_search = data

          $scope.postsOf = (result) ->
            result.split(';')

          $scope.hideForm = () ->
            $scope.personNotFound = false

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

      }
    ])

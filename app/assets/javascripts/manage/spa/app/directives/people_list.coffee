angular.module('dashboard')
  .directive('peopleList', ['$http', 'localization',
    ($http, localization) ->
      return {
        scope:
          person:  '=person'
          person_type:  '@personType'
          people:  '=people'
          destroyPersonFunction: '=destroyWith'
          updateOrderFunction: '=updateOrderFunction'
          context: '=context'
          specialities: "=specialities"
          saveEditPerson: '=saveEditPerson'
          restoreEditPerson: '=restoreEditPerson'
          changeActivePersonForm: '=changeActivePersonForm'

        transclude: true
        restrict: 'E'
        templateUrl: 'people_list.html'
        controller: ($scope, $http, $timeout) ->
          $scope.l = localization.l

          $scope.activateEditFormAction = (person) ->
            $scope.showEditPersonForm = !$scope.showEditPersonForm
            $scope.setPersonActive(person)

          $scope.saveAction = (person, object) ->
            $scope.changeActivePersonForm(object)
            $scope.saveEditPerson(person)

          $scope.cancelAction = (person) ->
            $scope.restoreEditPerson person

           $scope.showEditPersonForm = ->
             $scope.activePersonForm == person.id

          $scope.setPersonActive = (person) ->
            $scope.activePersonForm = person.id

          $scope.personDegrees = (person) ->
            result = []
            for string in [person.science_title, person.science_degree]
              result.push string if string
            result.join(', ')

          $scope.detectEqualItem = (person) ->
            return person == $scope.sortPerson

          $scope.updateOrder = (_, ui) ->
            $scope.orderAllItems = false
            index = ui.item.index()
            person = $scope.people[index]
            $scope.sortPerson = person
            $scope.updateOrderFunction person, index

          $scope.orderPeopleCompare = (a, b) ->
            if (a.fullname < b.fullname)
              return -1
            if (a.fullname > b.fullname)
              return 1
            return 0

          $scope.peopleAlfavitOrder = ->
            $scope.people.sort($scope.orderPeopleCompare)

            index = 0
            for person in $scope.people
              $scope.updateOrderFunction person, index
              index++

            $scope.orderAllItems = true

          $scope.sortableOptions = {
            axis: 'y'
            cursor: 'move'
            handle: '.handle'
            stop: $scope.updateOrder
          }

          $scope.updatePost = (post, callback) ->
            params = { post:
                         title: post.title
                         council_speciality_id: post.council_speciality_id
                     }
            $http
              .patch "manage/posts/#{post.id}", params
              .success (data) ->
                post = data
                callback(true)
              .error (error) ->
                callback(error)

          $scope.$on 'deactivatedEditForm', ->
            $scope.activePersonForm = null

          $scope.$on 'updatePerson', ->
            $scope.activePersonForm = null
      }
    ])

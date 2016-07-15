angular
  .module('dashboard')
  .controller('PermissionsController', ['$scope', '$http', ($scope, $http) ->

    $scope.getPermissions = ()->
      $http
        .get '/manage/permissions'
        .success (data) ->
          $scope.permissions       = data.permissions
          $scope.availableRoles    = data.available_roles
          $scope.availableContexts = data.available_contexts

    $scope.removePermission = (permission) ->
      $http
        .delete "/manage/permissions/#{permission.id}"
        .success (data) ->
          $scope.removeElementFrom $scope.permissions, permission

    $scope.validatePermission = () ->
      user = $scope.new_user
      return false unless user.role
      return false unless user.id
      if user.role.need_context
        return false unless user.context
      true

    $scope.submitPermission = () ->
      user = $scope.new_user
      permission = {
        user_id:      user.id
        role:         user.role.value
      }
      if user.role.need_context
        permission = Object.assign permission, {
          context_id:   user.context.id
          context_type: user.context.type
        }

      $http
        .post 'manage/permissions', permission
        .success (data) ->
          $scope.permissions.unshift data
          $scope.new_user = {}
          $scope.toggleForm()

    $scope.toggleForm = () ->
      $scope.showAddPermissionsForm = !$scope.showAddPermissionsForm

    $scope.setUser = (selectedObject) ->
      for k, v of selectedObject.originalObject
        $scope.new_user[k] = v

    $scope.cleanUser = () ->
      for key in ['fullname', 'email', 'id']
        delete $scope.new_user[key]

    $scope.searchResponseFormatter = (response) ->
      results = []
      for result in response
        fullname = result.label.split(', ')[0]
        email = result.label.split(', ')[1]
        id = result.id
        results.push {
          fullname: fullname
          email: email
          id: id
        }
      results

    $scope.initializer = () ->
      $scope.new_user = {}
      $scope.getPermissions()

    $scope.initializer()

    ])

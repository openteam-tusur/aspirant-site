angular
  .module('dashboard')
  .directive('fileUploader',  ['FileUploader', 'localization',
    () ->
      return {
        scope:
          multiple: '@multiple'
          type: '=type'
          files: '=files'
        transclude: true
        restrict: 'E'
        templateUrl: 'file-uploader.html'
        link: ($scope, element, attributes) ->
          element
            .find '.fake-upload-button'
            .bind "click", ()->
              element.find('input.hidden').click()

        controller: ($scope, FileUploader, localization) ->
          $scope.multiple = false if $scope.multiple == 'false'
          $scope.l = localization.l
          $scope.uploader = new FileUploader()

          $scope.need = (string) ->
            $scope.multiple == string
      }
    ])

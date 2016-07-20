angular
  .module('dashboard')
  .directive('fileUploader',  ['FileUploader', 'localization', '$http',
    () ->
      return {
        scope:
          multiple: '@multiple'
          contextType: '@contextType'
          contextId: '=contextId'
          kind: '@kind'
          files: '=files'
          file: '=file'
          personId: '=personId'

        transclude: true
        restrict: 'E'
        templateUrl: 'file-uploader.html'
        link: ($scope, element, attributes) ->
          element
            .find '.fake-upload-button'
            .bind "click", ()->
              element.find('input.hidden').click()

        controller: ($scope, FileUploader, localization, $http) ->
          $scope.multiple = false if $scope.multiple == 'false'
          $scope.l = localization.l

          $scope.makeParams = () ->
            console.log $scope
            h = {
              context_type: $scope.contextType
              context_id: $scope.contextId
              'file_copy[kind]': $scope.kind
            }
            h = Object.assign(h, {'file_copy[person_id]': $scope.personId }) if $scope.personId
            h

          $scope.need = (string) ->
            $scope.multiple == string

          $scope.onCompleteItem = (item, response, status, headers) ->
            if $scope.need('multiple')
              $scope.files.push response
            else
              $scope.file = response

          $scope.uploader = new FileUploader({
            url: '/manage/file_copies'
            alias: 'file_copy[file]'
            formData: [ $scope.makeParams() ]
            onCompleteItem: $scope.onCompleteItem
            queueLimit: (if $scope.need('multiple') then 100 else 1)
            removeAfterUpload: true
            autoUpload: true
            }
          )

          $scope.sizeOf = (file) ->
            size = file.size || file.file_file_size
            if size/1024/1024 > 0.5
              "#{ (size/1024/1024).toFixed 1 } #{$scope.l('file.mb')}"
            else
               "#{ Math.round size/1024 } #{$scope.l('file.kb')}"

          $scope.fileNameOf = (file) ->
            full_name = file.name || file.file_file_name
            if full_name.length < 30
              full_name
            else
              name = full_name.replace(/\.[^.]*$/, '' ) # stripping of filename extension
              splitted_full_name = full_name.split('.')
              extension = if splitted_full_name.length > 1 then splitted_full_name[ splitted_full_name.length - 1 ] else null
              "#{ name.substring(0, 25)}...#{extension}"

          $scope.destroyFile = (file) ->
            if confirm $scope.l('file.destroy_confirm')
              $http
                .delete "manage/file_copies/#{file.id}"
                .success (data) ->
                  if $scope.need('multiple')
                    i = $scope.files.indexOf file
                    $scope.files.splice i, 1
                  else
                    $scope.file = null

          $scope.showUploadButton = () ->
            has_uploaded_file = $scope.file && $scope.file.constructor == Object && $scope.file.id
            has_file_in_queue = !!$scope.uploader.queue.length
            can_upload_multiple_files = $scope.need('multiple')
            can_upload_multiple_files || !(has_uploaded_file || has_file_in_queue)

          $scope.allFiles = () ->
            if $scope.need('multiple')
              $scope.files
            else
              [$scope.file].filter (i) ->
                i && i.constructor == Object && i.id

          $scope.updatePlacementDate = (_, file) ->
            params = {
              id: file.id
              file_copy:
                placement_date: file.placement_date
            }
            $http
              .patch "/manage/file_copies/#{file.id}", params
              .success (data) ->
                if data
                  file = data
      }
    ])

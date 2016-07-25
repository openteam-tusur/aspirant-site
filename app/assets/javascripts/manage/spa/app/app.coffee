angular
  .module('dashboard', ['ui.router', 'templates', 'angucomplete-alt', 'ui.sortable', 'angularFileUpload', 'ui.bootstrap'])
  .config(['$stateProvider', '$urlRouterProvider', ($stateProvider, $urlRouterProvider) ->
    $stateProvider
      .state('dashboard', {
        url: '/dashboard'
        templateUrl: 'dashboard.html'
        controller: 'DashboardController'
        resolve: {}
        })

      .state('councils', {
        url: '/councils'
        templateUrl: 'councils.html'
        controller: 'CouncilsController'
        resolve: {}
        })

      .state('council_edit',{
        url: '/council/:councilId'
        templateUrl: 'edit_council.html'
        controller: 'EditCouncilController'
        resolve: {}
        })

      .state('permissions', {
        url: '/permissions'
        templateUrl: 'permissions.html'
        controller: 'PermissionsController'
        resolve: {}
        })

      .state('adverts', {
        url: '/adverts'
        templateUrl: 'adverts.html'
        controller: 'AdvertsController'
        resolve: {}
        })

      .state('advert_edit', {
        url: '/advert/:advertId'
        templateUrl: 'edit_advert.html'
        controller: 'EditAdvertController'
        resolve: {}
        })

      .state('people', {
        url: '/people?page&q'
        templateUrl: 'people.html'
        controller: 'PeopleController'
        params:
          page:
            value:  '1'
            squash: true
          q:
            value:  ''
            squash: true
      })

      .state('specialities', {
        url: '/specialities'
        templateUrl: 'specialities.html'
        controller: 'CouncilSpecialitiesController'
        resolve: {}
        })

    $urlRouterProvider.otherwise 'dashboard'
    ])

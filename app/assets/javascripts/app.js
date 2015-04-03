(function (app) {
	app.config(['$stateProvider', '$urlRouterProvider', 'AuthProvider', function($stateProvider, $urlRouterProvider, AuthProvider) {
		$stateProvider
    		.state('feed', {
    			url: '/feed',
    			templateUrl: 'feed/_feed.html',
    			controller: 'HeaderCtrl as headerCtrl',
                onEnter: ['$state', 'Auth', function($state, Auth) {
                    Auth.currentUser().then(function (){
                    }, function() {
                        $state.go('login');
                    });
                }]
    		})

    		.state('login', {
    			url: '/login',
    			templateUrl: 'auth/_login.html',
                controller: 'AuthCtrl as authCtrl',
                onEnter: ['$state', 'Auth', function($state, Auth) {
                    Auth.currentUser().then(function (){
                        $state.go('feed');
                    });
                }]
    		})

            .state('register', {
                url: '/register',
                templateUrl: 'auth/_register.html',
                controller: 'AuthCtrl as authCtrl',
                onEnter: ['$state', 'Auth', function($state, Auth) {
                    Auth.currentUser().then(function (){
                        $state.go('feed');
                    });
                }]
            });

    	$urlRouterProvider.otherwise('feed');
    }]);
}(angular.module('brizby', [
	// Module dependencies will go here
	'ui.router',
	'templates',
	'Devise',
    'ngFileUpload',

	// Application modules
	'brizby.headerCtrl',
    'brizby.authCtrl',
    'brizby.config'
])));
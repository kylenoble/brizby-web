(function (app) {
	app.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
		$stateProvider
    		.state('feed', {
    			url: '/feed',
    			templateUrl: 'feed/_feed.html'
    		});

    	$urlRouterProvider.otherwise('feed');
    }]);
}(angular.module('brizby', [
	// Module dependencies will go here
	'ui.router',
	'templates',

	// Application modules
	'brizby.headerCtrl'
])));
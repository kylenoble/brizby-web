(function (app) {
	app.config(['$stateProvider', '$urlRouterProvider', function($stateProvider, $urlRouterProvider) {
		console.log("app initialized");
		$stateProvider
    		.state('feed', {
    			url: '/feed',
    			templateUrl: 'feed/_feed.html'
    		});

    	$urlRouterProvider.otherwise('feed');
    }]);
}(angular.module('Brizby', [
	// Module dependencies will go here
	'ui.router',
	'templates'
])));
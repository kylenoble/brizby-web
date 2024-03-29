(function() {
	'use strict';

	angular
		.module('brizby.headerCtrl', [])
		.controller('HeaderCtrl', headerCtrl);

	function headerCtrl($scope, $state, $rootScope, Auth) {
		var vm = this;

		$scope.signedIn = Auth.isAuthenticated;
		$scope.logout = Auth.logout;

		Auth.currentUser().then(function (user){
            $scope.user = user;
        });

        $scope.$on('devise:new-registration', function (e, user){
		    $scope.user = user;
		});

		$scope.$on('devise:login', function (e, user){
		    $scope.user = user;
		});

		$scope.$on('devise:logout', function (e, user){
		    $scope.user = {};
		    $state.go('login');
		});
	}
}());
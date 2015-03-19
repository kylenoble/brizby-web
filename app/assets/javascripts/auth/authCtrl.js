(function() {
	'use strict';

	angular
		.module('brizby.authCtrl', [])
		.controller('AuthCtrl', authCtrl);

	function authCtrl($scope, $state, Auth) {
		var vm = this;

		vm.login = function() {
    		Auth.login($scope.user).then(function(){
      			$state.go('feed');
    		});
  		};

  	vm.register = function() {
    	Auth.register($scope.user).then(function(){
      		$state.go('feed');
   		});
  	};
	}
}());
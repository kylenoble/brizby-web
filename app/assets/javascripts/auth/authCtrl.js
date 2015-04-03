(function() {
	'use strict';

	angular
		.module('brizby.authCtrl', [])
		.controller('AuthCtrl', authCtrl);

	function authCtrl($scope, $state, Auth, AWS_CREDS, $q, $http) {
		var vm = this;

		vm.login = function() {
    	Auth.login(vm.user).then(function(){
      	$state.go('feed');
    	});
  	};

    function uniqueString() {
      var text     = "";
      var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

      for( var i=0; i < 8; i++ ) {
        text += possible.charAt(Math.floor(Math.random() * possible.length));
      }
      return text;
    }

    function uploadProfilePic(profilePicture) {
      var deferred = $q.defer();
      AWS.config.update({ accessKeyId: AWS_CREDS.access_key, secretAccessKey: AWS_CREDS.secret_key });
      AWS.config.region = 'us-east-1';
      var bucketFolder = AWS_CREDS.bucket;
      var bucket = new AWS.S3({ params: { Bucket: bucketFolder } });
      var key = uniqueString() + '-' + profilePicture.name;

      var params = { Key: key, ContentType: profilePicture.type, Body: profilePicture, ServerSideEncryption: 'AES256' };
      bucket.putObject(params, function(err, data) {
        if(err) {
          // There Was An Error With Your S3 Config
          deferred.reject(err.message);
        }
        else {
          // Success!
          deferred.resolve('https://' + AWS_CREDS.bucket + '.s3.amazonaws.com/' + key);
        }
      });
      return deferred.promise;
    }

  	vm.register = function() {
    	// Auth.register($scope.user).then(function(){
     //    $state.go('feed');
   		// });
      if(vm.userType === 'User') {
        if(vm.file) {
          uploadProfilePic(vm.file[0]).then(function(promise) {
            console.log(promise);
            vm.user.avatar_attributes = {};
            vm.user.avatar_attributes.direct_upload_url = promise;
            console.log(vm.user);
            Auth.register(vm.user).then(function(){
              $state.go('feed');
            });
          }, function(error) {
            alert(error);
          });
        } else {
          console.log('No file selected');
        }
      } else {
        console.log('Please select a user type.')
      }
  	};
	}
}());
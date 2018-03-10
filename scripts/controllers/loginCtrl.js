'use strict';
/**
 * @ngdoc function
 * @name sbAdminApp.controller:loginCtrl
 * @description
 * # MainCtrl
 * Controller of the sbAdminApp
 */
angular.module('sbAdminApp')
  .controller('loginCtrl', function($scope, Data, $location) {
  	$scope.login = {};

  	$scope.submitLogin = function(data){
  		//console.log(data);
  		Data.post('login',data).then(function(data){
       		if(data.status == "success") {
       			console.log(data);
       			$location.path('/dashboard/products');
       		}
       			
        }); 
  	}


  });

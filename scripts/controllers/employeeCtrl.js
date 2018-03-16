'use strict';
/**
 * @ngdoc function
 * @name sbAdminApp.controller:employeeCtrl
 * @description
 * # MainCtrl
 * Controller of the sbAdminApp
 */
angular.module('sbAdminApp')
  .controller('employeeCtrl', function($scope,$filter, Data ,$timeout) {

$scope.columns = [
                    {text:"ID",predicate:"eid",sortable:true,dataType:"number"},
                    {text:"First Name",predicate:"emp_firstname",sortable:true},
                    {text:"Last Name",predicate:"emp_lastname",sortable:true},
                    {text:"Designation",predicate:"designation",reverse:true,sortable:true},                    
                    {text:"Employee Id",predicate:"emp_id",sortable:true},
					//{text:"Action",predicate:"",sortable:false}
                ];

 function getEmployeeList(){
        Data.get('employeelist').then(function(data){
        $scope.emplist = data.data;
        }); 
      }
    getEmployeeList();




    
});
'use strict';
/**
 * @ngdoc function
 * @name .controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the 
 */
angular.module('sbAdminApp')
  .controller('issueCtrl', function($scope,$position, $filter, Data ,$timeout) {
  	$scope.product = {};
    function getIssueList(){
        Data.get('issuedlist').then(function(data){
        $scope.issuelist = data.data;
        }); 
      }
    getIssueList();

     Data.get('itemlist').then(function(data){
        $scope.items = data.data;
    }); 

      Data.get('employeelist').then(function(data){
        $scope.employeelist = data.data;
    }); 

     $scope.columns = [
                    {text:"ID",predicate:"id",sortable:true,dataType:"number"},
                    {text:"Item Name",predicate:"name",sortable:true},
                    {text:"Quantity",predicate:"quantity",sortable:true},
                    {text:"Ticket No",predicate:"serialno",reverse:true,sortable:true,dataType:"number"},                    
                    {text:"Issued to IT engineer",predicate:"warrantyperiod",sortable:true},
					{text:"Action",predicate:"",sortable:false}
                ];

    $scope.deleteProduct = function(product){
        if(confirm("Are you sure to remove the product")){
            Data.delete("products/"+product.id).then(function(result){
              $scope.msg ="delete successfully";
              $scope.hideMsg();
                 getIssueList();
            });
        }
    };

     $scope.hideMsg = function(){
       $timeout(function(){
          $scope.msg = "";
       },1000)
     }

    $scope.saveIssued = function(issue){
      console.log(issue);
       var val = issue.item_id;
      issue.item_id = val.item_id;
      val = issue.emp_id;
      issue.emp_id = val.eid;
      var date = new Date();
      issue.created_at  = date.getFullYear() + '-' + (date.getMonth() + 1) + '-' + date.getDate() + ' ' + date.toLocaleTimeString();

       Data.post('saveIssued', issue).then(function (result) {
                    if(result.status != 'error'){
                      $scope.msg ="Record added successfully";
                       $scope.hideMsg();
                        getIssueList();                 
                      $("#addproduct .close").click();
                    }else{
                        console.log(result);
                    }
                });


    };

  });

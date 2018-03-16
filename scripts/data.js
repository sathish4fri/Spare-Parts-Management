angular.module('sbAdminApp')
.factory("Data", ['$http', '$location',
    function ($http, $q, $location) {

        var serviceBase = 'api/v1/';

        var obj = {};

        obj.get = function (q) {
            return $http.get(serviceBase + q).then(function (results) {
                return results.data;
            });
        };
        obj.post = function (q, object) {
            return $http.post(serviceBase + q, object).then(function (results) {
                return results.data;
            });
        };
        obj.put = function (q, object) {
            return $http.put(serviceBase + q, object).then(function (results) {
                return results.data;
            });
        };
        obj.delete = function (q) {
            return $http.delete(serviceBase + q).then(function (results) {
                return results.data;
            });
        };
        obj.getCurrentTime = function(){
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth()+1; //January is 0!
            var hh = today.getHours();
            var min = today.getMinutes();
            var ss = today.getSeconds();

            var yyyy = today.getFullYear();
            if(dd<10){
                dd='0'+dd;
            } 
            if(mm<10){
                mm='0'+mm;
            } 
            if(hh<10){
                hh='0'+hh;
            } 
            if(min<10){
                min='0'+min;
            } 
            if(ss<10){
                ss='0'+ss;
            } 
            return yyyy+'-'+mm+'-'+dd+' '+hh+':'+min+':'+ss;
        }
        return obj;
}]);

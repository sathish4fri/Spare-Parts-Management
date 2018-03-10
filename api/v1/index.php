<?php
require '.././libs/Slim/Slim.php';
require_once 'dbHelper.php';

\Slim\Slim::registerAutoloader();
$app = new \Slim\Slim();
$app = \Slim\Slim::getInstance();
$db = new dbHelper();

/**
 * Database Helper Function templates
 */
/*
select(table name, where clause as associative array)
insert(table name, data as associative array, mandatory column names as array)
update(table name, column names as associative array, where clause as associative array, required columns as array)
delete(table name, where clause as array)
*/


$app->get('/itemlist', function() { 
    global $db;
    $rows = $db->select("items","item_id,item_name",array("status"=>1));
    echoResponse(200, $rows);
});

$app->get('/arealist', function() { 
    global $db;
    $rows = $db->select("area","id,area_name",array("status"=>1,"is_delete"=>0));
    echoResponse(200, $rows);
});

$app->get('/employeelist', function() { 
    global $db;
    $rows = $db->select("employee","eid,emp_firstname,emp_lastname,designation,emp_id",array("status"=>1,"is_delete"=>0));
    echoResponse(200, $rows);
});

//issue list
$app->get('/issuedlist', function() { 
    global $db;
    $q = "select IT.item_id,IT.item_name,IL.quantity,IL.ticket_no,EM.eid,EM.emp_firstname,
          EM.emp_lastname,EM.designation,EM.emp_id from issue_list IL join employee EM on  
          IL.emp_id = EM.eid join items IT on IT.item_id = IL.item_id where IL.is_delete = '0'";
    $rows = $db->executeQuery($q);
    echoResponse(200, $rows);
});

$app->get('/purchaselist', function() { 
    global $db;
    $q = "select IT.item_id,IT.item_name,PU.vendor,PU.specification,PU.quantity,PU.warranty_period,
          PU.invoice_no,PU.serial_no from purchase PU join items IT on IT.item_id = PU.item_id 
          where PU.is_delete = '0'";
    $rows = $db->executeQuery($q);
    echoResponse(200, $rows);
});

$app->post('/saveitemlist', function() use ($app) { 
   $data = json_decode($app->request->getBody());
    $mandatory = array('item_name');
    global $db;
    $rows = $db->insert("items", $data, $mandatory);
    if($rows["status"]=="success")
        $rows["message"] = "Item added successfully.";
    echoResponse(200, $rows);
});

$app->post('/products', function() use ($app) { 
    $data = json_decode($app->request->getBody());
    $mandatory = array('name');
    global $db;
    $rows = $db->insert("products", $data, $mandatory);
    if($rows["status"]=="success")
        $rows["message"] = "Product added successfully.";
    echoResponse(200, $rows);
});

$app->put('/products/:id', function($id) use ($app) { 
    $data = json_decode($app->request->getBody());
    $condition = array('id'=>$id);
    $mandatory = array();
    global $db;
    $rows = $db->update("products", $data, $condition, $mandatory);
    if($rows["status"]=="success")
        $rows["message"] = "Product information updated successfully.";
    echoResponse(200, $rows);
});

$app->delete('/products/:id', function($id) { 
    global $db;
    $rows = $db->delete("products", array('id'=>$id));
    if($rows["status"]=="success")
        $rows["message"] = "Product removed successfully.";
    echoResponse(200, $rows);
});

$app->post('/login', function() use ($app){ 
      $data = json_decode($app->request->getBody());
    global $db;
    $condition = array('name'=>$data->username);
    $rows = $db->select("customers_auth","name,uid", $condition);
    echoResponse(200, $rows);
});

function echoResponse($status_code, $response) {
    global $app;
    $app->status($status_code);
    $app->contentType('application/json');
    echo json_encode($response,JSON_NUMERIC_CHECK);
}

$app->run();
?>
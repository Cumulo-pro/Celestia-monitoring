<?php

$url = "orchestrator_test.json";
$json = file_get_contents($url);

if ($json === false) {
    die("Error retrieving JSON data");
}

$data = json_decode($json);

if ($data === null) {
    die("Error decoding JSON data");
}

?>
<body>
<div class="card">
    <h3>Cumulo Blobstream orchestrator status | 5-minute check</h3>
    <p><strong>Nonce:</strong> <?php echo htmlspecialchars($data->nonce); ?></p>
    <p><strong>Begin Block:</strong> <?php echo htmlspecialchars($data->begin_block); ?></p>
    <p><strong>End Block:</strong> <?php echo htmlspecialchars($data->end_block); ?></p>
    <p><strong>Data Root Tuple Root:</strong> <?php echo htmlspecialchars($data->data_root_tuple_root); ?></p>
    <p><strong>Date UTC:</strong> <?php echo htmlspecialchars($data->fecha_utc); ?></p>
    <p><strong>Error Status:</strong> <?php echo $data->tiene_errores === "false" ? "No Errors" : "Errors"; ?></p>
    <hr>
    <p><strong>Number of Errors:</strong>  <?php echo htmlspecialchars($data->cantidad_errores) ?></p>
    <p><strong>Number of Warnings:</strong> <?php echo htmlspecialchars($data->cantidad_warnings)?> </p>
</div>

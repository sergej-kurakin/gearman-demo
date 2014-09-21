<?php
// Reverse Worker Code
$worker = new GearmanWorker();
$worker->addServer('gqueue');
$worker->addFunction('reverse', function ($job) {
    echo 'Got Job'.PHP_EOL;
    return strrev($job->workload());
});
while ($worker->work());
<?php
// Reverse Client Code
$client = new GearmanClient();
$client->addServer('gqueue');
print $client->do('reverse', 'Hello World!').PHP_EOL;

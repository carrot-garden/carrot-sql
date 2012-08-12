--
-- Copyright (C) 2010-2012 Andrei Pozolotin <Andrei.Pozolotin@gmail.com>
--
-- All rights reserved. Licensed under the OSI BSD License.
--
-- http://www.opensource.org/licenses/bsd-license.php
--

-- ${carrotTimeISO}

GRANT ALL PRIVILEGES ON *.* 
	TO				'${cluster.root.username}'@'%'
	IDENTIFIED BY	'${cluster.root.password}'
	WITH GRANT OPTION;

UPDATE mysql.user 
	SET password = PASSWORD('${cluster.root.password}')
	WHERE user = 'root';

DELETE FROM mysql.user WHERE user='';
 
FLUSH PRIVILEGES;

DROP SCHEMA IF EXISTS test;

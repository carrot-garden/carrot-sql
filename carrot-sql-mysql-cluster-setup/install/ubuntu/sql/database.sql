--
-- Copyright (C) 2010-2012 Andrei Pozolotin <Andrei.Pozolotin@gmail.com>
--
-- All rights reserved. Licensed under the OSI BSD License.
--
-- http://www.opensource.org/licenses/bsd-license.php
--

-- ${carrotTimeISO}

CREATE SCHEMA ${cluster.main.database};

CREATE SCHEMA ${cluster.test.database};

CREATE 
	USER			'${cluster.main.username}'@'%' 
	IDENTIFIED BY	'${cluster.main.password}'
;

CREATE 
	USER			'${cluster.test.username}'@'%' 
	IDENTIFIED BY	'${cluster.test.password}'
;

GRANT ALL PRIVILEGES 
	ON	${cluster.main.database}.*
	TO	'${cluster.main.username}'@'%'
;

GRANT ALL PRIVILEGES 
	ON	${cluster.test.database}.*
	TO	'${cluster.test.username}'@'%'
;

FLUSH PRIVILEGES;

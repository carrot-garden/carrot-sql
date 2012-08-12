--
-- Copyright (C) 2010-2012 Andrei Pozolotin <Andrei.Pozolotin@gmail.com>
--
-- All rights reserved. Licensed under the OSI BSD License.
--
-- http://www.opensource.org/licenses/bsd-license.php
--

-- ${carrotTimeISO}

STOP SLAVE;

CHANGE MASTER TO
	master_host	=	'localhost',
	master_port	=	13301,
	master_user	=	'${cluster.root.username}',
	master_password='${cluster.root.password}'
;

START SLAVE;

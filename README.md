# Edulaboro – collaborative editing of teaching materials

This is a very early stage of this app and there are (almost certainly) many bugs, deficiencies, bad code etc. So now you know :)

Edulaboro is (going to be) a collaborative app to create teaching materials and then edit, comment, rank and to make a proposed amendments (etc.) to that material. At the moment there isn't anything collaborative, so feel free to hack the code and implement such functionality.

With this version (0.1) you can add, edit, view and remove documents.

Edulaboro uses:
  * https://github.com/cloudhead/cradle/ as Couch DB client
  * http://backbonejs.org/ as MV* Framework
  * http://handlebarsjs.com/ as node.js template engine
  * https://github.com/jhollingworth/bootstrap-wysihtml5/ as editor

## Installing 

Install Node.js 0.6.x  and CouchDB (tested with version 1.2.0)
    
    git clone https://github.com/opinsys/edulaboro.git
    cd edulaboro

Install dependencies

    npm install

Setup config.json
  
    youreditor config.json

## Hacking and running server 

Before running server, remember to create a Couch DB view -> see server/routes.coffee rows: 33 ->
! At the moment app crashes if database doesn't exist when running the app first time

Run server
  
    node server

And navigate to http://localhost:8000/ 
(Or to the port which you configured in config.json)

# Copyright

Copyright © 2010 Opinsys Oy

This program is free software; you can redistribute it and/or modify it under
the terms of the GNU General Public License as published by the Free Software
Foundation; either version 2 of the License, or (at your option) any later
version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY
WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A
PARTICULAR PURPOSE. See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with
this program; if not, write to the Free Software Foundation, Inc., 51 Franklin
Street, Fifth Floor, Boston, MA 02110-1301, USA.
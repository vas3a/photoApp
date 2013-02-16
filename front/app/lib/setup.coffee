require('json2ify')
require('es5-shimify')
require('jqueryify')

Spine = require('spine')
Spine.Local = require('spine/lib/local')
require('spine/lib/ajax')
# require('spine/lib/manager')
Spine.Route = require('spine/lib/route')
Spine.List = require('spine/lib/list')
Spine.Model.host = "http://app.local.com/app_dev.php/api"
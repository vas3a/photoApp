require('json2ify')
require('es5-shimify')
require('jqueryify')

@Spine = require('spine')

require('spine/lib/ajax')
Spine.Model.host = "/app.php/api"

# require('spine/lib/manager')
# require('spine/lib/route')
require('spine/lib/local')
require('spine/lib/list')

# custom libraries
require('lib/waypoints')

#user Model
@User = require('models/user')
User.fetch()
@user = User.first() or new User(settings: {})
@user.save()
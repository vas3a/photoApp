Spine = require('spine')

class User extends Spine.Model
  @configure 'User', 'settings'
  @extend Spine.Model.Local
  
module.exports = User
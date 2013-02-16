require('lib/setup')
Spine = @Spine
Image = require('models/image')
ThumbController = require('controllers/thumbnail')
ViewController  = require('controllers/view')

class App extends Spine.Controller
	events:
		'thumb_activated' : '_onThumbActivate'
		'keyup' : '_onKeyPressed'

	constructor: ->
		super
		@thumb = new ThumbController
		@view = new ViewController

		@append @view, @thumb

	_onThumbActivate: (ev, slug) =>
		@view.show(slug: slug)

	_onKeyPressed: (ev) =>
		# next_key = 39, prev_key = 37
		if ev.which is 39
			@thumb.trigger 'show_next'
		else if ev.which is 37
			@thumb.trigger 'show_prev'


module.exports = App

Spine = require('spine')
Image = require('models/image')

class Preloader extends Spine.Controller
	className: 'preloader'
	offset: 0
	limit: 15
	trace: false

	constructor: ->
		super

	load: (index = 0) =>
		@loadNext index

	loadNext: (index) =>
		@log index
		@log @max-@limit/2
		l = @max-Math.round(@limit/2)-1
		if(index >= l)
			Image.fetch()
			@max = Image.count()

		@loadMore index, Math.round(@limit/2)

	startPreload: () =>
		@max = Image.count()
		@loadMore @offset, @limit
		@offset = @limit

	loadMore: (offset, limit) =>
		imagesToPreload = Image.all().splice(offset, limit)
		for img in imagesToPreload
			@loadImage img
		
	loadImage: (img) =>
		img.elId = 'image-c-id-'+img.id
		@el.append require('views/view')(img)
		t = setTimeout(
			=>
				clearTimeout(t)
				$('#'+img.elId).parent().remove()
		,500)
		
module.exports = Preloader
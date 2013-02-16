Spine 		= require('spine')
Image 		= require('models/image')
Preloader 	= require('controllers/preloader')

class Thumbnail extends Spine.Controller
	className: 'thumbsContainer'

	elements:
		'.thumbList' : 'thumbListDiv'

	events:
		'show_next' : '_showNext'
		'show_prev' : '_showPrev'

	preloader: new Preloader()
	trace: false

	constructor: ->
		super
		@append '<div class="thumbList"></div>', @preloader
		@thumbList = new Spine.List
			el: @thumbListDiv, 
			template: require('views/thumbnail'), 
			selectFirst: true

		@thumbList.bind 'change', @change
		Image.bind 'refresh change', @render
		@bind 'show_next', @_showNext
		@bind 'show_prev', @_showPrev

	_showPrev: () =>
		@thumbList.activatePrev()

	_showNext: () =>
		@thumbList.activateNext()

	render: =>
		@preloader.startPreload()
		@thumbListDiv.css 'width' : Image.count() * 90
		@thumbList.render(Image.all())

	change: (img) =>
		@el.parents().trigger 'thumb_activated', img.slug
		@centrate(img)

	centrate: (img) =>
		thumb = $($('.thumbnail')[img.id-1])
		w = 88 #thumb.width()
		windowWidth = $(window).width()
		totalWidth = Image.count() * w
		thumbMarginLeft = thumb.index() * w
		thumbMarginRight= (Image.count() - thumb.index()) * w
		mL = windowWidth/2 - w
		mR = windowWidth/2 + w
		newLeft = mL - thumbMarginLeft

		if (thumbMarginLeft > mL or thumbMarginRight > mR) and (newLeft <= 0 and (totalWidth+newLeft)>windowWidth)
			@el.css left: newLeft
		# else if (totalWidth+newLeft) > windowWidth
			# @el.css left: 
		@log 'thumbMarginLeft', thumbMarginLeft, 'thumbMarginRight', thumbMarginRight, 'mL', mL, 'mR', mR
		@log 'totalWidth', totalWidth, 'totalWidth-newLeft', (totalWidth-newLeft), 'windowWidth', windowWidth
		
		@preloader.load(thumb.index())

module.exports = Thumbnail
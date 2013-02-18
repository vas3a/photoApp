Image 		= require('models/image')
Preloader 	= require('controllers/preloader')

class Thumbnail extends Spine.Controller
	className: 'thumbsContainer'

	elements:
		'.thumbList' : 'thumbListDiv'
		# '.minify' : 'minify'

	events:
		'show_next' : '_showNext'
		'show_prev' : '_showPrev'
		'click .minify' : 'minify'

	preloader: new Preloader()
	trace: false

	constructor: ->
		super
		@append '<div class="minify"> </div>', '<div class="thumbList"></div>', @preloader
		@thumbList = new Spine.List
			el: @thumbListDiv, 
			template: require('views/thumbnail'), 
			selectFirst: true

		@thumbList.bind 'change', @change
		Image.bind 'refresh change', @render
		@bind 'show_next', @_showNext
		@bind 'show_prev', @_showPrev

		@initAndLoadUserSettings()
		
	_showPrev: () =>
		@thumbList.activatePrev()

	_showNext: () =>
		@thumbList.activateNext()

	render: =>
		@preloader.startPreload()
		@thumbList.render(Image.all())
		@thumbListToggle()
			

	change: (img) =>
		@el.parents().trigger 'thumb_activated', img.slug
		@centrate(img)			

	minify: () =>
		@minified = !@minified
		@thumbListToggle()
		@saveUserData minified: @minified

	thumbListToggle: =>
		if @minified
			@thumbListDiv.css 'width' : 86
			@thumbList.children().css position: 'absolute'
		else
			@thumbListDiv.css 'width' : Image.count() * 86
			@thumbList.children().removeAttr 'style'
		@centrate()

	centrate: (img) =>
		@thumb = @thumbList.currentEl

		if !@minified
			@el.css left: @doMath()
		else
			@el.css left: 0
			@thumbList.currentEl.next().css(zIndex: 1).siblings().css(zIndex: 0)

		@preloader.load(@thumb.index())

	doMath: () =>
		w = 86 #thumb.width()
		windowWidth = $(window).width()
		totalWidth = Image.count() * w
		thumbMarginLeft = @thumb.index() * w
		thumbMarginRight= (Image.count() - @thumb.index()) * w
		mL = windowWidth/2 - w
		mR = windowWidth/2 + w
		newLeft = mL - thumbMarginLeft

		if (thumbMarginLeft > mL or thumbMarginRight > mR) and (newLeft <= 0 and (totalWidth+newLeft)>windowWidth)
			cssLeft = newLeft
		else if newLeft >= 0
			cssLeft = 0
		else if (totalWidth+newLeft) < windowWidth
			cssLeft = windowWidth - totalWidth - 5

		cssLeft

	initAndLoadUserSettings: () =>
		user.settings.thumbList = {} unless user.settings.thumbList
		@minified = false or user.settings.thumbList.minified
		@saveUserData minified: @minified

	saveUserData: (data) =>
		for i, v of data
			user.settings.thumbList[i] = v
		user.save()

module.exports = Thumbnail
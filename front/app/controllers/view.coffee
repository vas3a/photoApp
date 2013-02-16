Spine = require('spine')
Image= require('models/image')

class View extends Spine.Controller
	className: 'viewport'
	template: 'views/view'
	
	elements:
		'.image': 'imageDiv'
		'.image img': 'image'
		'.layout': 'layout'
		'.layout .views .counter': 'viewsCounter'
	
	easing: 'swing'
	item: null

	constructor: ->
		super
		@append require('views/layout')
		@animeDurationTime = 200
		@item = @img = Image.first()
		@render

	show: (params) =>
		@img = Image.filter(params.slug)
		@render()

	render: () =>
		if @item
			if parseInt(@item.id) < parseInt(@img[0].id)
				dir = 'next'
			else
				dir = 'prev'
		else
			dir = 'next'

		@item = @img[0]
		@append require(@template)(@item)
		@['anime_'+dir]()
		@log 'anime_'+dir
		@item.views++
		@item.save()

	anime_next: =>
		@anime(-600)

	anime_prev: =>
		@anime(600)

	anime: (to)=>
		# @log @image
		$(@image[1]).css
			left: -to
		if @image[1]
			$(@image[0]).stop(true, true).animate
				left: to,
					duration: @animeDurationTime
					easing: @easing
					complete: =>
						$(@imageDiv[0]).remove()
						@updateLayout(@item)
			$(@image[1]).stop(true, true).animate
				left: 0,
					duration: @animeDurationTime
					easing: @easing
		else
			@updateLayout(@item)

	updateLayout: (item) =>
		@viewsCounter.text(item.views)
module.exports = View
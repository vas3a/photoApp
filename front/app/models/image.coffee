Spine = require('spine')

class Image extends Spine.Model
	@configure 'Image', 'title', 'slug', 'imgsrc', 'thumbsrc', 'views', 'index'
	@extend Spine.Model.Ajax

	@filter: (query) ->
		return @all() unless query
		query = query.toLowerCase()
		@select (item) ->
			item.title?.toLowerCase().indexOf(query) isnt -1 or
				item.slug?.toLowerCase().indexOf(query) isnt -1

	@fetch: (params) ->
		index  = @last()?.id or 0
		return false if index is @index
		@index = index
		
		params or= 
			data: {index: index}
			processData: true

		@ajax().fetch(params)

module.exports = Image
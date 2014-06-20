angular.module 'socialLinks', []

	.factory 'socialLinker', ['$window', '$location', ($window, $location) ->
		(urlFactory) ->
			(scope, element, attrs) ->
				currentUrl = $location.absUrl()
				url = urlFactory(scope, currentUrl)
				if element[0].nodeName == 'A' && !attrs.href?
					element.attr('href', url)
					element.attr('rel', 'nofollow')

				handler = (e)->
					e.preventDefault()
					$window.open(
						url,
						'popupwindow',
						"scrollbars=yes,width=#{attrs.socialWidth || 800},height=#{attrs.socialHeight || 600}"
					).focus()

				element.on 'click', handler

				scope.$on '$destroy', ->
					element.off 'click', handler
	]

	.directive 'socialFacebook', ['socialLinker', (linker) ->
		restrict: 'ACEM'
		scope: true
		link: linker (scope, url) ->
			"https://facebook.com/sharer.php?u=#{encodeURIComponent(url)}"
	]

	.directive 'socialTwitter', ['socialLinker', (linker) ->
		restrict: 'ACEM'
		scope:
			status: '@status'
		link: linker (scope, url) ->
			scope.status ||= "Check this out! - #{url}"
			"https://twitter.com/home?status=#{encodeURIComponent(scope.status)}"
	]

	.directive 'socialGoogleplus', ['socialLinker', (linker) ->
		restrict: 'ACEM'
		scope: true
		link: linker (scope, url) ->
			"https://plus.google.com/share?url=#{encodeURIComponent(url)}"
	]

	.directive 'socialPinterest', ['socialLinker', (linker) ->
		restrict: 'ACEM'
		scope:
			media: '@media',
			description: '@description'
		link: linker (scope, url) ->
			"http://pinterest.com/pin/create/button/?url=#{encodeURIComponent(url)}&amp;media=#{encodeURIComponent(scope.media)}&amp;description=#{encodeURIComponent(scope.description)}"
	]

	.directive 'socialStumbleupon', ['socialLinker', (linker) ->
		restrict: 'ACEM'
		scope: true
		link: linker (scope, url) ->
			"https://stumbleupon.com/submit?url=#{encodeURIComponent(url)}"
	]

	.directive 'socialLinkedin', ['socialLinker', (linker) ->
		restrict: 'ACEM'
		scope: true
		link: linker (scope, url) ->
			"https://linkedin.com/shareArticle?url=#{encodeURIComponent(url)}"
	]



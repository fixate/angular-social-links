sharedScopeDefinition = {
	handler: '&customHandler'
	socialWidth: '@'
	socialHeight: '@'
}

angular.module 'socialLinks', []

	.factory 'socialLinker', ['$window', '$location', ($window, $location) ->
		(urlFactory) ->
			(scope, element, attrs) ->
				popupWinAttrs = "
					status=no,
					width=#{scope.socialWidth || 640},
					height=#{scope.socialWidth || 480},
					resizable=yes,
					toolbar=no,
					menubar=no,
					scrollbars=no,
					location=no,
					directories=no
				"

				getCurrentUrl = () ->
					attrs.customUrl or $location.absUrl()

				attrs.$observe 'customUrl', () ->
					url = urlFactory(scope, getCurrentUrl())

					if element[0].nodeName is 'A' and (!attrs.href? or attrs.href is '')
						element.attr 'href', url

				element.attr 'rel', 'nofollow'

				handler = (e)->
					e.preventDefault()
					url = urlFactory(scope, getCurrentUrl())
					win = $window.open(
						url,
						'popupwindow',
						popupWinAttrs
					).focus()

				if attrs.customHandler?
					element.on 'click', handler = (event) ->
						url = urlFactory(scope, getCurrentUrl())
						# Set the href in case we want the default link behaviour
						element.attr('href', url)
						scope.handler($event: event, $url: url)
				else
					element.on 'click', handler

				scope.$on '$destroy', ->
					element.off 'click', handler
	]

	.directive 'socialFacebook', ['socialLinker', (linker) ->
		restrict: 'ACEM',
		scope: sharedScopeDefinition,
		link: linker (scope, url) ->
			shareUrl = ["https://facebook.com/sharer.php?"]
			shareUrl.push("u=#{encodeURIComponent(url)}")

			shareUrl.join('')
	]

	.directive 'socialTwitter', ['socialLinker', (linker) ->
		restrict: 'ACEM',
		scope: angular.extend(status: '@status', sharedScopeDefinition),
		link: linker (scope, url) ->
			scope.status ||= "Check this out! - #{url}"
			"https://twitter.com/intent/tweet?text=#{encodeURIComponent(scope.status)}"
	]

	.directive 'socialGplus', ['socialLinker', (linker) ->
		restrict: 'ACEM',
		scope: sharedScopeDefinition,
		link: linker (scope, url) ->
			"https://plus.google.com/share?url=#{encodeURIComponent(url)}"
	]

	.directive 'socialPinterest', ['socialLinker', (linker) ->
		restrict: 'ACEM',
		scope: angular.extend(media: '@media', description: '@description', sharedScopeDefinition),
		link: linker (scope, url) ->
			"http://pinterest.com/pin/create/button/?url=#{encodeURIComponent(url)}&amp;media=#{encodeURIComponent(scope.media)}&amp;description=#{encodeURIComponent(scope.description)}"
	]

	.directive 'socialStumbleupon', ['socialLinker', (linker) ->
		restrict: 'ACEM',
		scope: sharedScopeDefinition,
		link: linker (scope, url) ->
			"https://stumbleupon.com/submit?url=#{encodeURIComponent(url)}"
	]

	.directive 'socialLinkedin', ['socialLinker', (linker) ->
		restrict: 'ACEM',
		scope: sharedScopeDefinition,
		link: linker (scope, url) ->
			"https://linkedin.com/shareArticle?url=#{encodeURIComponent(url)}"
	]

	.directive 'socialReddit', ['socialLinker', (linker) ->
		restrict: 'ACEM',
		scope: sharedScopeDefinition,
		link: linker (scope, url) ->
			"https://www.reddit.com/submit?url=#{encodeURIComponent(url)}"
	]

	.directive 'socialVk', ['socialLinker', (linker) ->
		restrict: 'ACEM',
		scope: sharedScopeDefinition,
		link: linker (scope, url) ->
			"http://vkontakte.ru/share.php?url=#{encodeURIComponent(url)}"
	]

	.directive 'socialOk', ['socialLinker', (linker) ->
		restrict: 'ACEM',
		scope: sharedScopeDefinition,
		link: linker (scope, url) ->
			"http://www.odnoklassniki.ru/dk?st.cmd=addShare&st._surl=#{encodeURIComponent(url)}"
	]

	.directive 'socialXing', ['socialLinker', (linker) ->
		restrict: 'ACEM',
		scope: sharedScopeDefinition,
		link: linker (scope, url) ->
			"https://www.xing.com/spi/shares/new?url=#{encodeURIComponent(url)}"
	]

angular.module 'socialLinks', []

  .factory 'socialLinker', ['$window', '$location', ($window, $location) ->
    (urlFactory) ->
      (scope, element, attrs) ->
        currentUrl = $location.url()
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
    link: linker (scope, url) ->
      "https://facebook.com/sharer.php?u=#{url}"
  ]

  .directive 'socialTwitter', ['socialLinker', (linker) ->
    restrict: 'ACEM'
    scope:
      socialStatus: '@status'
      socialHandle: '@handle'
    link: linker (scope, url) ->
      scope.status ||= (->
        status = "Shared from #{url}"
        status += " - via @#{scope.handle}" if scope.handle?
        status += " - #{url}"
        status
      )()

      "https://twitter.com/home?status=#{scope.status}"
  ]

  .directive 'socialGoogleplus', ['socialLinker', (linker) ->
    restrict: 'ACEM'
    scope:
      socialStatus: '@status'
      socialHandle: '@handle'
    link: linker (scope, url) ->
      "https://plus.google.com/share?url=#{url}"
  ]



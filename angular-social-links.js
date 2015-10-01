(function() {
  var sharedScopeDefinition;

  sharedScopeDefinition = {
    handler: '&customHandler',
    socialWidth: '@',
    socialHeight: '@'
  };

  angular.module('socialLinks', []).factory('socialLinker', [
    '$window', '$location', function($window, $location) {
      return function(urlFactory) {
        return function(scope, element, attrs) {
          var getCurrentUrl, handler, popupWinAttrs;
          popupWinAttrs = "status=no, width=" + (scope.socialWidth || 640) + ", height=" + (scope.socialHeight || 480) + ", resizable=yes, toolbar=no, menubar=no, scrollbars=no, location=no, directories=no";
          getCurrentUrl = function() {
            return attrs.customUrl || $location.absUrl();
          };
          attrs.$observe('customUrl', function() {
            var url;
            url = urlFactory(scope, getCurrentUrl());
            if (element[0].nodeName === 'A' && ((attrs.href == null) || attrs.href === '')) {
              return element.attr('href', url);
            }
          });
          element.attr('rel', 'nofollow');
          handler = function(e) {
            var url, win;
            e.preventDefault();
            url = urlFactory(scope, getCurrentUrl());
            return win = $window.open(url, 'popupwindow', popupWinAttrs).focus();
          };
          if (attrs.customHandler != null) {
            element.on('click', handler = function(event) {
              var url;
              url = urlFactory(scope, getCurrentUrl());
              element.attr('href', url);
              return scope.handler({
                $event: event,
                $url: url
              });
            });
          } else {
            element.on('click', handler);
          }
          return scope.$on('$destroy', function() {
            return element.off('click', handler);
          });
        };
      };
    }
  ]).directive('socialFacebook', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: sharedScopeDefinition,
        link: linker(function(scope, url) {
          var shareUrl;
          shareUrl = ["https://facebook.com/sharer.php?"];
          shareUrl.push("u=" + (encodeURIComponent(url)));
          return shareUrl.join('');
        })
      };
    }
  ]).directive('socialTwitter', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: angular.extend({
          status: '@status'
        }, sharedScopeDefinition),
        link: linker(function(scope, url) {
          scope.status || (scope.status = "Check this out! - " + url);
          return "https://twitter.com/intent/tweet?text=" + (encodeURIComponent(scope.status));
        })
      };
    }
  ]).directive('socialGplus', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: sharedScopeDefinition,
        link: linker(function(scope, url) {
          return "https://plus.google.com/share?url=" + (encodeURIComponent(url));
        })
      };
    }
  ]).directive('socialPinterest', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: angular.extend({
          media: '@media',
          description: '@description'
        }, sharedScopeDefinition),
        link: linker(function(scope, url) {
          return "http://pinterest.com/pin/create/button/?url=" + (encodeURIComponent(url)) + "&amp;media=" + (encodeURIComponent(scope.media)) + "&amp;description=" + (encodeURIComponent(scope.description));
        })
      };
    }
  ]).directive('socialStumbleupon', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: sharedScopeDefinition,
        link: linker(function(scope, url) {
          return "https://stumbleupon.com/submit?url=" + (encodeURIComponent(url));
        })
      };
    }
  ]).directive('socialLinkedin', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: sharedScopeDefinition,
        link: linker(function(scope, url) {
          return "https://linkedin.com/shareArticle?url=" + (encodeURIComponent(url));
        })
      };
    }
  ]).directive('socialReddit', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: sharedScopeDefinition,
        link: linker(function(scope, url) {
          return "https://www.reddit.com/submit?url=" + (encodeURIComponent(url));
        })
      };
    }
  ]).directive('socialVk', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: sharedScopeDefinition,
        link: linker(function(scope, url) {
          return "http://vkontakte.ru/share.php?url=" + (encodeURIComponent(url));
        })
      };
    }
  ]).directive('socialOk', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: sharedScopeDefinition,
        link: linker(function(scope, url) {
          return "http://www.odnoklassniki.ru/dk?st.cmd=addShare&st._surl=" + (encodeURIComponent(url));
        })
      };
    }
  ]).directive('socialXing', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: sharedScopeDefinition,
        link: linker(function(scope, url) {
          return "https://www.xing.com/spi/shares/new?url=" + (encodeURIComponent(url));
        })
      };
    }
  ]);

}).call(this);

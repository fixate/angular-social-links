(function() {
  angular.module('socialLinks', []).factory('socialLinker', [
    '$window', '$location', function($window, $location) {
      return function(urlFactory) {
        return function(scope, element, attrs) {
          var currentUrl, handler, url;
          currentUrl = $location.absUrl();
          url = urlFactory(scope, currentUrl);
          if (element[0].nodeName === 'A' && (attrs.href == null)) {
            element.attr('href', url);
            element.attr('rel', 'nofollow');
          }
          handler = function(e) {
            e.preventDefault();
            return $window.open(url, 'popupwindow', "scrollbars=yes,width=" + (attrs.socialWidth || 800) + ",height=" + (attrs.socialHeight || 600)).focus();
          };
          element.on('click', handler);
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
        scope: true,
        link: linker(function(scope, url) {
          return "https://facebook.com/sharer.php?u=" + (encodeURIComponent(url));
        })
      };
    }
  ]).directive('socialTwitter', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: {
          status: '@status'
        },
        link: linker(function(scope, url) {
          scope.status || (scope.status = "Check this out! - " + url);
          return "https://twitter.com/home?status=" + (encodeURIComponent(scope.status));
        })
      };
    }
  ]).directive('socialGoogleplus', [
    'socialLinker', function(linker) {
      return {
        restrict: 'ACEM',
        scope: true,
        link: linker(function(scope, url) {
          return "https://plus.google.com/share?url=" + (encodeURIComponent(url));
        })
      };
    }
  ]);

}).call(this);

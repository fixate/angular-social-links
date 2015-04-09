# Angular Social Sharing Links

Flexible and easy social sharing directives for Twitter, Google Plus, Facebook, Pinterest, StumbleUpon, LinkedIn, and Reddit.

## Installation

Bower:

```shell
bower install angular-social-links
```

## Usage

```javascript
angular.module('myApp', ['socialLinks']);
```

Angular social links will automatically use the absolute URL of the current page:

```html
<a social-twitter>share on twitter</a>
<a social-twitter status="My custom status">share on twitter</a>
<a social-facebook>share on facebook</a>
<a social-gplus>share on google plus</a>
<a social-pinterest media="http://lorempixel.com/100/100/nature/1">share on pinterest</a>
<a social-linkedin>share on linkedin</a>
<a social-stumbleupon>share on stumbleupon</a>
<a social-reddit>share on reddit</a>
<a social-vk>share on vk.com</a>
<a social-ok>share on ok.ru</a>
```

but you can define custom URLs too:

```html
<a social-twitter custom-url="http://google.com">share on twitter</a>
<a social-facebook custom-url="http://google.com">share on facebook</a>
<a social-gplus custom-url="http://google.com">share on google plus</a>
<a social-pinterest media="http://lorempixel.com/100/100/nature/1" custom-url="http://google.com">share on pinterest</a>
<a social-linkedin custom-url="http://google.com">share on linkedin</a>
<a social-stumbleupon custom-url="http://google.com">share on stumbleupon</a>
<a social-reddit custom-url="http://google.com">share on reddit</a>
<a social-vk custom-url="http://google.com">share on vk.com</a>
<a social-ok custom-url="http://google.com">share on ok.ru</a>
```

and custom click handlers for all directives:
```html
<a social-twitter custom-handler="$event.preventDefault();controller.doSomething($url)">share on twitter</a>
```

You can use `$event` (click event object) and `$url` (the share link url).
This will prevent the popup window from coming up. If you don't use `$event.preventDefault`, the link will navigate as usual.

## Build

```shell
npm install
grunt build
```

### License

MIT: http://fixate.mit-license.org/

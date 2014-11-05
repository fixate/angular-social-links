# Angular Social Sharing Links

Flexible and easy social sharing directives for Twitter, Google Plus, Facebook,
Pinterest, LinkedIn, and Reddit

## Installation

Bower:

```shell
bower install angular-social-links
```

## Usage

```javascript
angular.module('myApp', ['socialLinks']);
```

Angular social links will automatically use the absolute URL of the current
page.

```html
<a social-twitter>share on twitter</a>
<a social-twitter status="My custom status">share on twitter</a>

<a social-facebook>share on facebook</a>
<a social-gplus>share on google plus</a>
<a social-pinterest>share on pinterest</a>
<a social-linkedin>share on linkedin</a>
<a social-reddit>share on reddit</a>
```

### With Custom Urls

```html
<a social-twitter custom-url="http://google.com">share on twitter</a>
<a social-facebook custom-url="http://google.com">share on facebook</a>
<a social-gplus custom-url="http://google.com">share on google plus</a>
<a social-pinterest custom-url="http://google.com">share on pinterest</a>
<a social-linkedin custom-url="http://google.com">share on linkedin</a>
<a social-reddit custom-url="http://google.com">share on reddit</a>
```

## Build

```shell
npm install
grunt build
```

### License

MIT: http://fixate.mit-license.org/

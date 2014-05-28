# PostImage Plugin for Mango Blog

Inspired by Medium.com, this is a plugin that requires you to provide an image url for every post. You can then, in your theme (not included here) get the post image and display it however you like.

This is the interface provided for providing your post image:

![](https://raw.githubusercontent.com/CounterMarch/Mango-PostImage/master/readme1.png)

The plugin does come with one setting: `required`, and if set to true, this is the error shown when you don't provide an image before attempting to publish:

![](https://raw.githubusercontent.com/CounterMarch/Mango-PostImage/master/readme2.png)

When `required` is false, or saving a post as a draft, you are not required to include a post image.

## Getting the image url in your theme

Normal theme rules and restrictions apply. The custom field name is `postImage-v1`:

	<mango:Posts>
		<mango:Post>
			<mango:PostProperty customField="postImage-v1" />
		</mango:Post>
	</mango:Posts>

## LICENSE

> **The MIT License (MIT)**

>Copyright (c) 2011 Adam Tuttle and Contributors

>Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

>The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

>THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

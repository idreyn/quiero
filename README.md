# It's like jQuery.post() for AS3!

You know what sucks? AS3's URLRequest class, that's what. It takes about ten lines of code just to load data from a simple web service. Quiero makes that much easier. So, wanna know what the weather is like in Salem, Oregon? Me neither, but let's find it anyway:

## The sucky way

	var request:URLRequest = new URLRequest('http://google.com/ig/api');
	var loader:URLLoader = new URLLoader();
	var variables:URLVariables = new URLVariables();
	variables.weather = 'Salem, OR';
	request.method = URLRequestMethod.GET;
	loader.addEventListener(Event.COMPLETE,onRequestComplete);
	loader.load(request);
	
	function onRequestComplete(e:Event):void {
	  trace(e.target.data);
	}


## The non-sucky (quiero) way

	import quiero.*;
	
	Quiero.request({url:'http://google.com/ig/api',method:'get',data:{weather:'Salem, OR'},onComplete:onRequestComplete});

	function onRequestComplete(e:RequesterEvent):void {
	  trace(e.data)
	}

See how much easier that was? But Quiero is useful for more than just simple URLLoader requests. Hows about:

### Loading images and swf's into Flash?

	Quiero.request({url:'mysomething.swf',loader:addChild(new Loader())});


### Playing sound?

	Quiero.request({url:'someSound.mp3',sound:new Sound()});


### Uploading files?

	var fileReference:FileReference = new FileReference('anImageOrSomething.png');
	Quiero.request({url:'upload.php',data:{name:fileReference.name},file:fileReference});


### Downloading files?

	Quiero.request({url:'test.jpg',downloadFile:new FileReference(),downloadName:"image"})


## Using Quiero

Quiero has exactly one method:

	Quiero.request(params:Object,load:Boolean=true,strict:Boolean=true):URLRequest

But the only part you need to worry about is the params object, through which you can pass parameters to Quiero. This object itself requires only one property:
  * `url:String`: The URL that Quiero will call.
And oodles of optional parameters. The ones you'll probably use most often are `data`, `method`, `format`, and `onComplete`. Let's take a look at these.
  * `data:Object`: A simple AS3 object that contains data to pass to the URL. For instance, to pass a username and password to a login script, you would use `{username:"helloperson",password:"password123"}`.
  * `method:String`: Tells Quiero how to pass the `data` object, using either GET or POST. `"get"` and `"post"` will work fine here. This data is passed to the `method` property of a `URLRequest` object in Quiero's guts.
  * `format:String`: Tells Quiero what kind of data to expect. Use a property from the `URLLoaderDataFormat` class (referenced by `Quiero.formats`).
  * `onComplete:Function`: A function called when the request completes. Takes one parameter, a `RequestEvent`. You can access the loaded data through the event's `data` property.
Quiero uses these properties for event handling:
  * `onIOError:Function`: A callback that expects an `IOErrorEvent` parameter, equivalent to listening for `IOErrorEvent.IO_ERROR` from an object such as a `URLLoader` or a `Sound`.
  * `onSecurityError:Function`: Expects a `SecurityError` parameter, equivalent to listening for `SecurityErrorEvent.SECURITY_ERROR`.
  * `onProgress:Function`: Expects a `ProgressEvent` parameter, equivalent to listening for `ProgressEvent.PROGRESS`.
These properties will also come in handy:
  * `contentType:String`: The MIME type of the data being sent. Use with caution, as the default should normally work fine. This is passed to the `contentType` property of a `URLRequest` object.
  * `headers:Array`: An array of headers to send with the request. Passed to the `requestHeaders` property of a `URLRequest` object.  
  * `forceRefresh:Boolean`: Basically adds a random token named `"quiero_flash_token"` to the `data` parameter, ensuring that Flash won't use the cache to make this request.
  * `toVars:Boolean`: If set to `false`, Quiero won't try to convert your `data` object into a `URLVariables` object. Usually you _want_ this to happen, so use with discretion.
To load data into a `Loader` object:
  * `loader:Loader`: The `Loader` that will receive the content at `url` (an image or a .swf file).
To load data into a `Sound` object:
  * `sound:Sound`: The `Sound` object that will play the sound at `url`.
To upload a `FileReference`:
  * `file:FileReference`: The file to upload to `url`. Note that the AIR class `File` extends `FileReference`.
  * `fileFieldName:String`: The field name that the script at `url` will use to find the file on the server. If not specified, it will remain `"Filedata"`, which is a good default.
To download to a `FileReference`:
  * `download:FileReference`: A `FileReference` object to attempt a download to. Quiero will call its `download` method.
  * `downloadName:String`: The default name of the file that Quiero will attempt to download.
  * _Note that Quiero has no mechanism for listening to `Event.SELECT` and `Event.CANCEL` callbacks for file dialog handling. Please add listeners for these to the `download` object._

I'm not sure what will happen if you specify both `file` and `downloadFile`, but it's reasonable to assume the universe will simply collapse in on itself and such calls should be avoided.

## Hey, what about the other two parameters?

  * If `false`, `load` will prevent the request from loading right away, allowing you to modify the `URLRequest` that Quiero gives you before firing it off.
  * If `true`, `strict` will warn you about properties passed to the `params` object that don't make any sense to Quiero.

 

That is all the documentation Quiero requires! Start making awesome things.

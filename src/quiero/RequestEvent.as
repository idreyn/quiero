package quiero
{
	import flash.events.*;
	public class RequestEvent extends Event
	{
		public var data:*;

		public function RequestEvent(type:String,d:*)
		{
			super(type);
			data=d;
		}
	}
}
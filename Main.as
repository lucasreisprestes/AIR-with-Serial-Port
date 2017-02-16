package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	//import com.quetwo.Arduino.*;
	import flash.utils.ByteArray;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.display.StageDisplayState;
	import flash.utils.setTimeout;
	import com.quetwo.Arduino.*;

	
	
	public class Main extends MovieClip {
		
		public var arduino:ArduinoConnector;
		
		public function Main() {
						
			setTimeout(teste,1000);
						
		}
		
		private function teste():void{
			stage.displayState = StageDisplayState.FULL_SCREEN;
			
			var myLoader:URLLoader = new URLLoader();
			myLoader.load(new URLRequest("config_arduino.xml"));
			myLoader.addEventListener(Event.COMPLETE, processXML);
		}
		
		private function processXML(e:Event):void {
			
			var myXML = new XML(e.target.data);
			trace("PORTA :",myXML.porta[0]);
			trace("Baud :",myXML.baud[0]);
			
			debug.appendText("PORTA :"+myXML.porta[0]);
			debug.appendText("\nBaud :"+myXML.baud[0]);			
			
			arduino = new ArduinoConnector();
		    arduino.connect(myXML.porta[0],myXML.baud[0]);
			
			arduino.addEventListener("socketData",readString);
			debug.appendText('\nisSupported '+ arduino.isSupported() +'\n' );
			
			
		}
		
		private function readString(e:Event):void{
			var log = arduino.readBytesAsString();
			trace(log)
			debug.appendText(log);
		}
						
		protected function closeApp(event:Event):void
		{
				arduino.dispose();                              
		}
	}
	
}

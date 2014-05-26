/**
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * */

package com.bit101.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	[Event(name="change", type="flash.events.Event")]
	public class Tooltip extends Component
	{	
		protected var _tf:TextField;
		protected var _text:String = "";
		protected var _format:TextFormat;
		protected var _back:Sprite;
		protected var _color:uint = 0xf2f2f2;
		protected var _txtWidth:Number = 0;
		protected var _txtHeight:Number = 0;
		
		public function Tooltip(parent:DisplayObjectContainer=null, xpos:Number = 0, ypos:Number =  0, text:String = "")
		{
			this.text = text;
			super(parent, xpos, ypos);
			setSize(200, 50);
		
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			mouseEnabled = false;
			mouseChildren = false;
		}
		
		/**
		 * Creates and adds the child display objects of this component.
		 */
		override protected function addChildren():void
		{
			_back = new Sprite();
			addChild(_back);
			
			_format = new TextFormat(Style.fontName, 10, _color);
			_tf = new TextField();
			_tf.height = _height;
			_tf.embedFonts = Style.embedFonts;
			_tf.antiAliasType = AntiAliasType.ADVANCED;
			_tf.multiline = true;
			_tf.wordWrap = true;
			_tf.selectable = false;
			_tf.defaultTextFormat = _format;
			_tf.text = _text;
			_tf.addEventListener(Event.CHANGE, onChange);	
			addChild(_tf);
			draw();
		}
		
		///////////////////////////////////
		// public methods
		///////////////////////////////////
		
		/**
		 * Draws the visual ui of the component.
		 */
		override public function draw():void 
		{
			super.draw();
			_back.graphics.clear();
			_tf.text = _text;
			_tf.width = _width;
			
			if (_text == "") {
				_txtWidth = _tf.textWidth;
				_txtHeight = _tf.textHeight;
			} else {
				_txtWidth = _tf.textWidth+4;
				_txtHeight = _tf.textHeight+4;
			}
			
			_back.graphics.beginFill(0x555555);
			_back.graphics.drawRect(0,0, _txtWidth, _txtHeight);
			_back.graphics.endFill();
			_tf.height = _txtHeight;
		}
		
		///////////////////////////////////
		// event handlers
		///////////////////////////////////
		
		/**
		 * Called when the text in the text field is manually changed.
		 */
		protected function onChange(event:Event):void
		{
			_text = _tf.text;
			dispatchEvent(event);
		}
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Gets / sets the text of this Label.
		 */
		public function set text(t:String):void
		{
			_text = t;
			if(_text == null) _text = "";
			invalidate();
		}
		public function get text():String
		{
			return _text;
		}
		
		/**
		 * Returns a reference to the internal text field in the component.
		 */
		public function get textField():TextField
		{
			return _tf;
		}		
		
	}
}
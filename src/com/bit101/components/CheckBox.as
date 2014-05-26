/**
 * CheckBox.as
 * Keith Peters
 * version 0.9.10
 * 
 * A basic CheckBox component.
 * 
 * Copyright (c) 2011 Keith Peters
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
 */
 
package com.bit101.components
{
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class CheckBox extends Component
	{
		protected var _back:Sprite;
		protected var _button:Sprite;
		protected var _label:Label;
		protected var _labelText:String = "";
		protected var _selected:Boolean = false;
		protected var _tooltip:Tooltip;
		protected var _toolText:String = "";
		
		/**
		 * Constructor
		 * @param parent The parent DisplayObjectContainer on which to add this CheckBox.
		 * @param xpos The x position to place this component.
		 * @param ypos The y position to place this component.
		 * @param label String containing the label for this component.
		 * @param defaultHandler The event handling function to handle the default event for this component (click in this case).
		 */
		public function CheckBox(parent:DisplayObjectContainer = null, xpos:Number = 0, ypos:Number =  0, label:String = "", defaultHandler:Function = null)
		{
			_labelText = label;
			super(parent, xpos, ypos);
			if(defaultHandler != null)
			{
				addEventListener(MouseEvent.CLICK, defaultHandler);
			}
		}
		
		/**
		 * Initializes the component.
		 */
		override protected function init():void
		{
			super.init();
			setSize(10, 10);
			buttonMode = true;
			useHandCursor = true;
			mouseChildren = false;
		}
		
		/**
		 * Creates the children for this component
		 */
		override protected function addChildren():void
		{
			_back = new Sprite();
			_back.filters = [getShadow(2, true)];
			addChild(_back);
			
			_button = new Sprite();
			_button.filters = [getShadow(1)];
			_button.visible = false;
			addChild(_button);
			
			_label = new Label(this, 0, 0, _labelText);
			_tooltip = new Tooltip(this, 0, 0);
			_tooltip.visible = false;
			draw();
			
			addEventListener(MouseEvent.CLICK, onClick);
			
			this.addEventListener(MouseEvent.ROLL_OVER, showToolTip);
			this.addEventListener(MouseEvent.ROLL_OUT, hideTooltip);
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
			_back.graphics.beginFill(Style.BACKGROUND);
			//_back.graphics.drawCircle(0, 0, _width/2);
			_back.graphics.drawRect(0, 0, _width, _height);
			_back.graphics.endFill();
			
			_button.graphics.clear();
			_button.graphics.beginFill(Style.BUTTON_FACE);
			//_button.graphics.drawCircle(0, 0, (_width/2 -4));
			_button.graphics.drawRect(2, 2, (_width-4), (_height-4));
			
			_label.text = _labelText;
			_label.draw();
			_label.x = _width+2;//12;
			_label.y = _height/2 - (Style.fontSize/2);
			//w_label.y = (10 - _label.height) / 2;
			_width = _label.width + 12;
			_height = 10;
			
			_tooltip.text = _toolText;
			_tooltip.draw();
			_tooltip.width = 200;
			_tooltip.y = -30;//-_tooltip.height/2 -4; //-4;
			//trace("just height", _height);
		}
		
		
		
		
		///////////////////////////////////
		// event handler
		///////////////////////////////////
		
		/**
		 * Internal click handler.
		 * @param event The MouseEvent passed by the system.
		 */
		protected function onClick(event:MouseEvent):void
		{
			_selected = !_selected;
			_button.visible = _selected;
		}
		
		/**
		 * Handler for mouse over on slider
		 * 
		 * */
		protected function showToolTip(event:MouseEvent):void 
		{
			_tooltip.visible = true;
		}
		
		protected function hideTooltip(event:MouseEvent):void 
		{
			_tooltip.visible = false;
		}		
		
		
		///////////////////////////////////
		// getter/setters
		///////////////////////////////////
		
		/**
		 * Sets / gets the label text shown on this CheckBox.
		 */
		public function set label(str:String):void
		{
			_labelText = str;
			invalidate();
		}
		public function get label():String
		{
			return _labelText;
		}
		
		/**
		 * Sets / gets the selected state of this CheckBox.
		 */
		public function set selected(s:Boolean):void
		{
			_selected = s;
			_button.visible = _selected;
		}
		public function get selected():Boolean
		{
			return _selected;
		}

		/**
		 * Sets/gets whether this component will be enabled or not.
		 */
		public override function set enabled(value:Boolean):void
		{
			super.enabled = value;
			mouseChildren = false;
		}
		
		/**
		 * Gets / sets the tooltip text of this slider.
		 * */
		public function set tooltip(str:String):void 
		{
			_toolText = str;
		}
		public function get tooltip():String 
		{
			return _toolText;
		}

	}
}
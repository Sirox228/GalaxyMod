package;

import openfl.display.Graphics;
import openfl.events.TouchEvent;
import openfl.events.Event;
import openfl.display.Sprite;
import openfl.display.Shape;

/*
* @author: Sirox
*/
@:access(openfl.display.Graphics)
@:access(openfl.display.Sprite)
@:access(ooenfl.display.DisplayObject)
class Hitbox extends Sprite {
	// some of the basic variables to detect touch, those are for whole screen, made them private
	public var justReleasedScreen:Bool = false;
	public var releasedScreen:Bool = true;
	public var pressedScreen:Bool = false;
	public var justPressedScreen:Bool = false;
	// same, but those are affected only if touch overlaps this button
	public var justReleased:Bool = false;
	public var released:Bool = true;
	public var pressed:Bool = false;
	public var justPressed:Bool = false;
	
	public function new(order:Int) {
		super();
		set_x(order == 0 ? 0 : 320 * order); // for some reason it don't want to work if i set just 320 * order
		set_y(0);
		/*width = 320;
		height = 720;*/
		trace(x,y,width,height);
		var col:Int = 0xFFFFFF;
		switch(order) {
			case 0:
			    col = 0xFF00FF;
			case 1:
			    col = 0x00FFFF;
			case 2:
			    col = 0x00FF00;
			case 3:
			    col = 0xFF0000;
		}
        makeGraphic(col);
		// loop the updateHitbox function to call each frame
		addEventListener(Event.ENTER_FRAME, updateHitbox);
	}
	
	// generating graphic, basically similar as in flixel ones, but wothout shape, just because we need Graphics instance as return
	private function makeGraphic(col:Int):Void {
		// TO DO: make a save data for gradient, i think i can simply use FlxG here, because Main is created before this
		graphics.beginFill(col);
		graphics.lineStyle(10, col, 1);
		graphics.drawRect(0, 0, 320, 720);
		graphics.endFill();
	}
	
	public var overlaps:Bool = false;
	
	public function updateHitbox(event:Event):Void {
		// TO DO: make a save data for opacity
		justReleased = justReleasedScreen && overlaps;
		justPressed = justPressedScreen && overlaps;
		pressed = pressedScreen && overlaps;
		released = releasedScreen && overlaps;
		if (pressed) {
			alpha = 0.3;
		} else {
			alpha = 0.0;
		}
		if (!pressedScreen) {
			overlaps = false;
		}
		if (justPressedScreen) {
			justPressedScreen = false;
		}
		if (justReleasedScreen) {
			justReleasedScreen = false;
		}
	}
}

/*
* class that wraps all 4 hitboxes together into a single sprite
*/
class HitboxWrapper extends Sprite {
	public var hitboxLeft:Hitbox;
	public var hitboxDown:Hitbox;
	public var hitboxUp:Hitbox;
	public var hitboxRight:Hitbox;
	public var ha:Array<Hitbox> = [];
	
	public function new() {
		super();
		hitboxLeft = new Hitbox(0);
		hitboxDown = new Hitbox(1);
		hitboxUp = new Hitbox(2);
		hitboxRight = new Hitbox(3);
		ha = [hitboxLeft, hitboxDown, hitboxUp, hitboxRight];
		addEventListener(TouchEvent.TOUCH_BEGIN, beginTouchHandle);
		addEventListener(TouchEvent.TOUCH_END, endTouchHandle);
		addEventListener(TouchEvent.TOUCH_MOVE, moveTouchHandle);
		// from here, order does not matter for real, cuz each instance of Hitbox have it's own positions
		addChild(hitboxLeft);
		addChild(hitboxDown);
		addChild(hitboxUp);
		addChild(hitboxRight);
	}
	
	private function beginTouchHandle(event:TouchEvent):Void {
		for (i in ha) {
		    i.justPressedScreen = true;
		    i.pressedScreen = true;
		    i.justReleasedScreen = false;
		    i.releasedScreen = false;
			trace(event.stageX,i.get_x(),i.get_width());
		    // no need to check this for y because hitboxes are 720 pixels height, that means, that they are fullscreen height
		    if (isinRange(event.stageX, i.get_x(), i.get_x() + i.get_width())) {
			    i.overlaps = true;
		    }
	    }
	}
	
	private function endTouchHandle(event:TouchEvent):Void {
		for (i in ha) {
		    i.justPressedScreen = false;
		    i.pressedScreen = false;
		    i.justReleasedScreen = true;
		    i.releasedScreen = true;
		    // no need to check this for y because hitboxes are 720 pixels height, that means, that they are fullscreen height
		    if (isinRange(event.stageX, i.get_x(), i.get_x() + i.get_width())) {
			    i.overlaps = false;
		    }
	    }
	}
	
	private function moveTouchHandle(event:TouchEvent):Void {
		for (i in ha) {
		    if (isinRange(event.stageX, i.get_x(), i.get_x() + i.get_width())) {
			    i.overlaps = true;
		    } else {
			    i.overlaps = false;
		    }
		}
	}
	
	public function isinRange(pos:Float, start:Float, end:Float) {
		if (pos >= start && pos <= end) {
			return true;
		}
		return false;
	}
}

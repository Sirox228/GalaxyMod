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
	private var justReleasedScreen:Bool = false;
	private var releasedScreen:Bool = true;
	private var pressedScreen:Bool = false;
	private var justPressedScreen:Bool = false;
	// same, but those are affected only if touch overlaps this button, made them read-only
	public var justReleased:Bool = false;
	public var released:Bool = true;
	public var pressed:Bool = false;
	public var justPressed:Bool = false;
	
	public function new(order:Int) {
		super();
		x = 320 * order;
		y = 0;
		width = 320;
		height = 720;
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
		graphics = makeGraphic(col);
		justReleased = false;
		released = true;
		pressed = false;
		justPressed = false;
		// loop the updateHitbox function to call each frame
		addEventListener(Event.ENTER_FRAME, updateHitbox);
		addEventListener(TouchEvent.TOUCH_BEGIN, beginTouchHandle);
		addEventListener(TouchEvent.TOUCH_END, endTouchHandle);
		addEventListener(TouchEvent.TOUCH_MOVE, beginTouchHandle);
	}
	
	// generating graphic, basically similar as in flixel ones, but wothout shape, just because we need Graphics instance as return
	private function makeGraphic(col:Int):Graphics {
		var graphic:Graphics = new Graphics(this);
		// TO DO: make a save data for gradient, i think i can simply use FlxG here, because Main is created before this
		graphic.beginFill(col);
		graphic.lineStyle(10, col, 1);
		graphic.drawRect(0, 0, width, height);
		graphic.endFill();
		return graphic;
	}
	
	// does touch overlaps this sprite
	public var overlaps:Bool = false;
	
	public function updateHitbox(event:Event):Void {
		// TO DO: make a save data for opacity
		justReleased = justReleasedScreen && overlaps;
		justPressed = justPressedScreen && overlaps;
		pressed = pressedScreen && overlaps;
		released = releasedScreen && overlaps;
		if (pressed) {
			alpha = 0.75;
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
	
	private function beginTouchHandle(event:TouchEvent):Void {
		justPressedScreen = true;
		pressedScreen = true;
		justReleasedScreen = false;
		releasedScreen = false;
		// no need to check this for y because hitboxes are 720 pixels height, that means, that they are fullscreen height
		if (isinRange(event.localX, event.sizeX, x, x + width)) {
			overlaps = true;
		}
	}
	
	private function endTouchHandle(event:TouchEvent):Void {
		justPressedScreen = false;
		pressedScreen = false;
		justReleasedScreen = true;
		releasedScreen = true;
		if (isinRange(event.localX, event.sizeX, x, x + width)) {
			overlaps = false;
		}
	}
	
	private function moveTouchHandle(event:TouchEvent):Void {
		if (isinRange(event.localX, event.sizeX, x, x + width)) {
			overlaps = true;
		} else {
			overlaps = false;
		}
	}
	
	public function isinRange(pos:Float, size:Float, start:Float, end:Float) {
		if (pos + size >= start && pos + size <= end + size) {
			return true;
		}
		return false;
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
	public function new() {
		super();
		hitboxLeft = new Hitbox(0);
		hitboxDown = new Hitbox(1);
		hitboxUp = new Hitbox(2);
		hitboxRight = new Hitbox(3);
		// from here, order does not matter for real, cuz each instance of Hitbox have it's own positions
		addChild(hitboxLeft);
		addChild(hitboxDown);
		addChild(hitboxUp);
		addChild(hitboxRight);
	}
}

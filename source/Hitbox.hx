package;

import openfl.display.Graphics;
import openfl.events.TouchEvent;
import openfl.events.Event;
import openfl.display.Sprite;
import openfl.display.Shape;
import openfl.display.BlendMode;

/*
* @author: Sirox
*/
@:allow(HitboxWrapper)
//@:allow(flixel.input.touch.FlxTouchManager)
class Hitbox extends Sprite {
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
        makeGraphic(order, col);
		// loop the updateHitbox function to call each frame
		addEventListener(Event.ENTER_FRAME, updateHitbox);
		/*addEventListener(TouchEvent.TOUCH_BEGIN, beginTouchHandle);
		addEventListener(TouchEvent.TOUCH_END, endTouchHandle);
		addEventListener(TouchEvent.TOUCH_OUT, outTouchHandle);*/
		blendMode = BlendMode.DIFFERENCE;
	}
	
	// generating graphic, basically similar as in flixel ones, but wothout shape, just because we need Graphics instance as return
	private function makeGraphic(order:Int, col:Int):Void {
		// TO DO: make a save data for gradient, i think i can simply use FlxG here, because Main is created before this
		graphics.beginFill(col);
		graphics.lineStyle(10, col, 1);
		graphics.drawRect(0, 0, order == 3 ? 315 : 310, 720);
		graphics.endFill();
	}
	
	/*private var overlaps:Bool = false;
	private var last:Bool = false;*/
	
	public function updateHitbox(event:Event):Void {
		// TO DO: make a save data for opacity
		/*justReleased = justReleasedScreen && overlaps;
		justPressed = justPressedScreen && overlaps;
		pressed = pressedScreen && overlaps;
		released = releasedScreen && overlaps;*/
		if (pressed) {
			alpha = 0.3;
		} else {
			alpha = 0.0;
		}
		/*if (last && overlaps) {
			last = false;
			overlaps = false;
		}
		if (!justReleasedScreen && !pressedScreen && !justPressedScreen) {
			overlaps = false;
		}*/
		if (justPressed) {
			justPressed = false;
		}
		if (justReleased) {
			justReleased = false;
			released = true;
		}
	}

	/*private function beginTouchHandle(event:TouchEvent):Void {
		justPressedScreen = true;
		pressedScreen = true;
		justReleasedScreen = false;
		releasedScreen = false;
		// no need to check this for y because hitboxes are 720 pixels height, that means, that they are fullscreen height
		if (isinRange(event.stageX, get_x(), get_x() + get_width())) {
			overlaps = true;
		}
	}

        private var lastOut:Int = 0;

        private function outTouchHandle(event:TouchEvent):Void {
		justPressedScreen = false;
		pressedScreen = false;
		justReleasedScreen = true;
		releasedScreen = true;
                last = true;
                lastOut = 0;
		// no need to check this for y because hitboxes are 720 pixels height, that means, that they are fullscreen height
		if (isinRange(event.stageX, get_x(), get_x() + get_width())) {
			overlaps = true;
		}
	}
	
	private function endTouchHandle(event:TouchEvent):Void {
		justPressedScreen = false;
		pressedScreen = false;
		justReleasedScreen = true;
		releasedScreen = true;
                last = true;
		// no need to check this for y because hitboxes are 720 pixels height, that means, that they are fullscreen height
		if (isinRange(event.stageX, get_x(), get_x() + get_width())) {
			overlaps = true;
		}
	}
	
	private function isinRange(pos:Float, start:Float, end:Float) {
		if (pos >= start && pos <= end) {
			return true;
		}
		return false;
	}*/
}

/*
* class that wraps all 4 hitboxes together into a single sprite, also moving touch
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
		ha = [hitboxLeft,hitboxDown,hitboxUp,hitboxRight];
		addEventListener(Event.ENTER_FRAME, handleTouch);
		//addEventListener(TouchEvent.TOUCH_MOVE, moveTouchHandle);
		// from here, order does not matter for real, cuz each instance of Hitbox have it's own positions
		addChild(hitboxLeft);
		addChild(hitboxDown);
		addChild(hitboxUp);
		addChild(hitboxRight);
		blendMode = BlendMode.DIFFERENCE;
	}
	
	private function handleTouch(event:Event) {
		for (touch in flixel.FlxG.touches.list) {
			trace(touch.x);
			for (h in ha) {
				if (touch.x > h.get_x() - 160 && touch.x < h.get_x() - 160 + h.get_width()) {
					h.pressed = touch.pressed;
					h.justPressed = touch.justPressed;
					h.justReleased = touch.justReleased;
					h.released = touch.released;
				}
			}
		}
	}

	/*private function moveTouchHandle(event:TouchEvent):Void {
		for (i in ha) {
			if (isinRange(event.stageX, i.get_x(), i.get_x() + i.get_width()) && i.lastOut != 1) {
				i.justPressedScreen = true;
				i.pressedScreen = true;
				i.justReleased = false;
				i.released = false;
                                i.lastOut = 1;
				i.overlaps = true;
			}
		}
	}

        private function isinRange(pos:Float, start:Float, end:Float) {
		if (pos >= start && pos <= end) {
			return true;
		}
		return false;
	}*/
}

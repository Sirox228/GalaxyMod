package;

import Song.SwagSong;
import Std;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import haxe.Exception;
import openfl.Lib;
import openfl.system.Capabilities;

using StringTools;

class PlayWindow
{
	public static var res:Array<Float> = [0, 0, 0, 0];
	public static var stage:Array<Float> = [0, 0];
	public static var pos:Array<Float> = [0, 0];
	public static var camz:Float = 1;

	public static function nreset()
	{
		pos = [0, 0];
		camz = 1;
		modcharts.M_cyber.nreset();
	}

	public static function reset()
	{
                #if !android
		if (!FlxG.fullscreen)
		{
                #end
			res = [
				Main.base.x,
				Main.base.y,
				Main.base.width,
				Main.base.height
			];
                #if !android
		}
                #end
		stage = [Capabilities.screenResolutionX, Capabilities.screenResolutionY];
		FlxG.scaleMode = new RatioScaleMode();
	}

	public static function back(camHUD:FlxCamera)
	{
		Main.base.x = res[0];
                Main.base.y = res[1];
                Main.base.width = res[2];
                Main.base.height = res[3];
		camHUD.zoom = 1;
		camHUD.x = 0;
		camz = 1;
		FlxG.scaleMode = new RatioScaleMode();
	}

	public static function move(camHUD:FlxCamera)
	{
		if (PlayState.SONG.song.toLowerCase() == "cyber" && PlayState.storyDifficulty != 0)
		{
			modcharts.M_cyber.move(camHUD);
		}
	}
}

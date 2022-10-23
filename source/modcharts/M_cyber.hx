package modcharts;

import Song.SwagSong;
import Std;
import flixel.FlxCamera;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxStrip;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxRect;
import flixel.system.scaleModes.FixedScaleMode;
import flixel.system.scaleModes.RatioScaleMode;
import haxe.Exception;
import openfl.Lib;
import openfl.system.Capabilities;

using StringTools;

class M_cyber
{
	public static var count:Int = 0;

	public static function nreset()
	{
		count = 0;
	}

	public static function pos(daNote:Note, strumLine:FlxSprite)
	{
		if (Conductor.songPosition >= 70280.8988764045 && Conductor.songPosition < 91595.50561797764)
			daNote.y = (PlayMoving.sy
				- (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(((300 - PlayMoving.sy) / 250) * PlayState.SONG.speed, 2)));
		else if (Conductor.songPosition >= 124044.94382022502 && Conductor.songPosition < 145617.977528)
		{
			if (FlxG.save.data.downscroll)
				daNote.y = (strumLine.y + (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
			else
				daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
			if ((!FlxG.save.data.downscroll
				&& (((Conductor.songPosition - 124044.94382022502) % 2696.62921348 < 1348.31460674 && daNote.y <= PlayMoving.sy)
					|| ((Conductor.songPosition - 124044.94382022502) % 2696.62921348 >= 1348.31460674 && daNote.y > PlayMoving.sy)))
				|| (FlxG.save.data.downscroll
					&& (((Conductor.songPosition - 124044.94382022502) % 2696.62921348 < 1348.31460674 && daNote.y >= PlayMoving.sy)
						|| ((Conductor.songPosition - 124044.94382022502) % 2696.62921348 >= 1348.31460674 && daNote.y < PlayMoving.sy))))
			{
				if (daNote.mustPress)
					daNote.x = PlayMoving.poxlist[daNote.noteData];
				else
					daNote.x = PlayMoving.oxlist[daNote.noteData];
			}
			else
			{
				if (daNote.mustPress)
					daNote.x = PlayMoving.poxlist[3 - daNote.noteData];
				else
					daNote.x = PlayMoving.oxlist[3 - daNote.noteData];
			}
			if (daNote.isSustainNote)
				daNote.x += daNote.width;
		}
		else if (daNote.strumTime >= 145617 && daNote.strumTime < 156236)
		{
			if (daNote.mustPress)
				daNote.x = PlayMoving.poxlist[daNote.noteData];
			else
				daNote.x = PlayMoving.oxlist[daNote.noteData];
			if (daNote.isSustainNote)
				daNote.x += daNote.width;
			else
				daNote.angle += 5;
			if (FlxG.save.data.downscroll)
				daNote.y = (strumLine.y + (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
			else
				daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
		}
		else if (daNote.strumTime >= 156404 && daNote.strumTime < 168456 && Conductor.songPosition < 167191.0112359552)
		{
			if (daNote.mustPress)
				daNote.x = PlayMoving.poxlist[daNote.noteData]
					+ (FlxMath.fastSin((daNote.strumTime - 156404.49438202268) / (2696.62921348) * 3.1415926535) * (PlayWindow.stage[0] * 2 / 10)
						+ PlayWindow.stage[0] / 2 - Main.base.x - 320) * 2;
			else
				daNote.x = PlayMoving.oxlist[daNote.noteData]
					+ (FlxMath.fastSin((daNote.strumTime - 156404.49438202268) / (2696.62921348) * 3.1415926535) * (PlayWindow.stage[0] * 2 / 10)
						+ PlayWindow.stage[0] / 2 - Main.base.x - 320) * 2;
			daNote.y = strumLine.y
				+ (FlxMath.fastCos((daNote.strumTime - 156404.49438202268) / (2696.62921348) * 3.1415926535) * (PlayWindow.stage[1] * -2 / 10)
					+ PlayWindow.stage[1] / 2 - Main.base.y - 180) * 2;
		}
		else if (Conductor.songPosition >= 167191.0112359552 && Conductor.songPosition < 172584.26966292146)
		{
			if (daNote.mustPress)
				daNote.x = PlayMoving.poxlist[daNote.noteData];
			else
				daNote.x = PlayMoving.oxlist[daNote.noteData];
			if (daNote.strumTime % 2696.62921348 < 1348.31460674)
				if (daNote.strumTime % 1348.31460674 < 674.157303371)
					daNote.y = (50
						+ 500 * (daNote.strumTime % 1348.31460674) / 1348.31460674
						- (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
				else
					daNote.y = (50
						+ 500 * (daNote.strumTime % 1348.31460674) / 1348.31460674
						+ (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
			else if (daNote.strumTime % 1348.31460674 < 674.157303371)
				daNote.y = (550
					- 500 * (daNote.strumTime % 1348.31460674) / 1348.31460674
					+ (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
			else
				daNote.y = (550
					- 500 * (daNote.strumTime % 1348.31460674) / 1348.31460674
					- (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
		}
		else if (Conductor.songPosition >= 172584.26966292146 && Conductor.songPosition < 177977.52808988772)
		{
			if (daNote.mustPress)
				daNote.x = PlayMoving.pxlist[daNote.noteData];
			else
				daNote.x = PlayMoving.xlist[daNote.noteData];
			if (FlxG.save.data.downscroll)
				daNote.y = (strumLine.y + (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
			else
				daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
		}
		/*if(Conductor.songPosition >= 91685.3932584271 && Conductor.songPosition < 102387.64044943838)
			{
				if (Conductor.songPosition % 40 < 20)
				{
					if (daNote.noteData < 2)
						daNote.alpha = 0;
					else 
						daNote.alpha = 1;
				}
				else
				{
					if (daNote.noteData < 2)
						daNote.alpha = 1;
					else 
						daNote.alpha = 0;
				}
				if(!daNote.mustPress)
					daNote.x = PlayMoving.oxlist[1 + daNote.noteData % 2];
				else
					daNote.x = PlayMoving.poxlist[1 + daNote.noteData % 2];
				daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
		}*/
		else
		{
			if (FlxG.save.data.downscroll)
				daNote.y = (strumLine.y + (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
			else
				daNote.y = (strumLine.y - (Conductor.songPosition - daNote.strumTime) * (0.45 * FlxMath.roundDecimal(PlayState.SONG.speed, 2)));
		}
	}

	public static function spos(dastrum:NoteStrum, strumLine:FlxSprite)
	{
		if (Conductor.songPosition >= 48707.86516853933 && Conductor.songPosition < 58988.76404494382)
		{
			if (FlxG.save.data.downscroll)
				dastrum.y = 550 + ((Conductor.songPosition - 48707.86516853933) / 10280.8988764) * 160;
			else
				dastrum.y = 50 - ((Conductor.songPosition - 48707.86516853933) / 10280.8988764) * 160;
			strumLine.y = dastrum.y;
		}
		else if (Conductor.songPosition >= 59325.84269662921 && Conductor.songPosition < 59494.38202247191)
		{
			if (FlxG.save.data.downscroll)
				dastrum.y = 550;
			else
				dastrum.y = 50;
			strumLine.y = dastrum.y;
		}
		else if (Conductor.songPosition >= 59494.38202247191 && Conductor.songPosition < 69775.28089887642)
		{
			if (FlxG.save.data.downscroll)
				dastrum.y = 550 + ((Conductor.songPosition - 59494.38202247191) / 10280.8988764) * 160;
			else
				dastrum.y = 50 - ((Conductor.songPosition - 59494.38202247191) / 10280.8988764) * 160;
			strumLine.y = dastrum.y;
		}
		else if (Conductor.songPosition >= 70112.35955056181 && Conductor.songPosition < 70280.8988764045)
		{
			if (FlxG.save.data.downscroll)
				dastrum.y = 550;
			else
				dastrum.y = 50;
			strumLine.y = dastrum.y;
		}
		else if (Conductor.songPosition >= 70280.8988764045 && Conductor.songPosition < 91595.50561797764)
		{
			dastrum.y = 300 - FlxMath.fastSin(((Conductor.songPosition - 70280.8988764045) / 1348.31460674 - 0.5) * 3.1415926535) * 250;
			strumLine.y = dastrum.y;
			PlayMoving.sy = dastrum.y;
		}
		else if (Conductor.songPosition >= 91685.3932584271 && Conductor.songPosition < 93033.70786516868)
		{
			if (FlxG.save.data.downscroll)
				dastrum.y = 550;
			else
				dastrum.y = 50;
			strumLine.y = dastrum.y;
		}
		else if (Conductor.songPosition >= 124044.94382022502 && Conductor.songPosition < 145617.977528)
		{
			if ((Conductor.songPosition - 124044.94382022502) % 2696.62921348 < 1348.31460674)
			{
				if (dastrum.x > 640)
					dastrum.x = PlayMoving.poxlist[dastrum.ID];
				else
					dastrum.x = PlayMoving.oxlist[dastrum.ID];
			}
			else
			{
				if (dastrum.x > 640)
					dastrum.x = PlayMoving.poxlist[3 - dastrum.ID];
				else
					dastrum.x = PlayMoving.oxlist[3 - dastrum.ID];
			}
			if (FlxG.save.data.downscroll)
				PlayMoving.sy = 550 - ((Conductor.songPosition - 124044.94382022502) % 1348.31460674) / 1348.31460674 * 1230;
			else
				PlayMoving.sy = 50 + ((Conductor.songPosition - 124044.94382022502) % 1348.31460674) / 1348.31460674 * 1230;
		}
		else if (Conductor.songPosition >= 145617.97752809015 && Conductor.songPosition < 156067.4157303373)
		{
			if (dastrum.x > 640)
				dastrum.x = PlayMoving.poxlist[dastrum.ID];
			else
				dastrum.x = PlayMoving.oxlist[dastrum.ID];
		}
		else if (Conductor.songPosition >= 156067.4157303373 && Conductor.songPosition < 156235.95505617998)
		{
			if (FlxG.save.data.downscroll)
				dastrum.y = 550 - (Conductor.songPosition - 156067.4157303373) / 168.539325843 * 250;
			else
				dastrum.y = 50 + (Conductor.songPosition - 156067.4157303373) / 168.539325843 * 250;
			strumLine.y = dastrum.y;
		}
		else if (Conductor.songPosition >= 167191.0112359552 && Conductor.songPosition < 172584.26966292146)
		{
			if (Conductor.songPosition % 2696.62921348 < 1348.31460674)
				dastrum.y = 50 + 500 * (Conductor.songPosition % 1348.31460674) / 1348.31460674;
			else
				dastrum.y = 550 - 500 * (Conductor.songPosition % 1348.31460674) / 1348.31460674;
		}
		else if (Conductor.songPosition >= 172584.26966292146 && Conductor.songPosition < 177977.52808988772)
		{
			if (FlxG.save.data.downscroll)
				dastrum.y = 550;
			else
				dastrum.y = 50;
			strumLine.y = dastrum.y;
			dastrum.scale.x = 0.7;
			dastrum.scale.y = 0.7;
			if (dastrum.x > 640)
			{
				dastrum.x = PlayMoving.poxlist[dastrum.ID];
			}
			else
			{
				dastrum.x = PlayMoving.oxlist[dastrum.ID];
			}
		}
		/*else if(Conductor.songPosition >= 91685.3932584271 && Conductor.songPosition < 102387.64044943838)
			{
				if (Conductor.songPosition % 40 < 20)
				{
					if (dastrum.ID < 2)
						dastrum.alpha = 0;
					else 
						dastrum.alpha = 1;
				}
				else
				{
					if (dastrum.ID < 2)
						dastrum.alpha = 1;
					else 
						dastrum.alpha = 0;
				}
				if(dastrum.x<640)
					dastrum.x = PlayMoving.oxlist[1 + dastrum.ID % 2];
				else
					dastrum.x = PlayMoving.poxlist[1 + dastrum.ID % 2];
		}*/
	}

	inline static public function show(daNote:Note):Bool
	{
		if (Conductor.songPosition >= 70280.8988764045 && Conductor.songPosition < 91595.50561797764)
			return (Math.abs(daNote.y - 300) > Math.abs(((300 - PlayMoving.sy) / 250)) * 360);
		else if (daNote.strumTime >= 156404 && daNote.strumTime < 168456 && Conductor.songPosition < 167191.0112359552)
			return Conductor.songPosition < 156404 || daNote.strumTime - Conductor.songPosition > 2696.62921348;
		else
		{
			if (FlxG.save.data.downscroll)
				return daNote.y < -daNote.height;
			else
				return daNote.y > FlxG.height;
		}
	}

	inline static public function kill(daNote:Note):Bool
	{
		if (daNote.strumTime >= 48707 && daNote.strumTime < 70029)
		{
			if (FlxG.save.data.downscroll)
				return daNote.y > FlxG.height && Conductor.songPosition > daNote.strumTime + 1000 / 6;
			else
				return daNote.y < -daNote.height && Conductor.songPosition > daNote.strumTime + 1000 / 6;
		}
		else if (Conductor.songPosition >= 70280.8988764045 && Conductor.songPosition < 91595.50561797764)
			return ((Math.abs(daNote.y - 300) > Math.abs(((300 - PlayMoving.sy) / 250)) * 50)
				&& Conductor.songPosition - daNote.strumTime > 1000 / 6);
		else if (daNote.strumTime >= 156404 && daNote.strumTime < 168456 && Conductor.songPosition < 167191.0112359552)
			return Conductor.songPosition > daNote.strumTime + 1000 / 6;
		else if (Conductor.songPosition >= 167191.0112359552 && Conductor.songPosition < 172584.26966292146)
			return Conductor.songPosition > daNote.strumTime + 1000 / 6;
		else
		{
			if (FlxG.save.data.downscroll)
				return daNote.y > FlxG.height;
			else
				return daNote.y < -daNote.height;
		}
	}

	public static function move(camHUD:FlxCamera)
	{
		if (FlxG.fullscreen)
			FlxG.fullscreen = false;
		if (Conductor.songPosition % 20 < 10)
		{
			if (Conductor.songPosition < 5393.258426966292)
			{
				PlayWindow.reset();
			}
			else if (Conductor.songPosition >= 5393.258426966292 && Conductor.songPosition < 10702.247191011236)
			{ // 640 360
				var tar:Array<Float> = [PlayWindow.stage[0] / 2 - 320, PlayWindow.stage[1] / 2 - 180];
				Main.base.width = 640 + (10702.247191011236 - Conductor.songPosition) / (5308.98876404) * (PlayWindow.res[2] - 640);
				Main.base.height = 360 + (10702.247191011236 - Conductor.songPosition) / (5308.98876404) * (PlayWindow.res[3] - 360);
				Main.base.x = tar[0] + (10702.247191011236 - Conductor.songPosition) / (5308.98876404) * (PlayWindow.res[0] - tar[0]);
				Main.base.y = tar[1] + (10702.247191011236 - Conductor.songPosition) / (5308.98876404) * (PlayWindow.res[1] - tar[1]);
			}
			else if (Conductor.songPosition >= 10786.516853932584 && Conductor.songPosition < 16089.887640449437)
			{
				var bef:Array<Float> = [PlayWindow.stage[0] / 2 - 320, PlayWindow.stage[1] / 2 - 180];
				var tar:Array<Float> = [
					PlayWindow.stage[0] / 2 - 320,
					PlayWindow.stage[1] * 3 / 10 - 180
				];
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				Main.base.x = tar[0] + (16089.887640449437 - Conductor.songPosition) / (5303.37078652) * (bef[0] - tar[0]);
				Main.base.y = tar[1] + (16089.887640449437 - Conductor.songPosition) / (5303.37078652) * (bef[1] - tar[1]);
			}
			else if (Conductor.songPosition >= 16179.775280898875 && Conductor.songPosition < 25617.977528089887)
			{
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				Main.base.x = FlxMath.fastSin((Conductor.songPosition - 16179.775280898875) / (2696.62921348) * 3.1415926535) * (PlayWindow.stage[0] * 2 / 10)
					+ PlayWindow.stage[0] / 2
						- 320;
				Main.base.y = FlxMath.fastCos((Conductor.songPosition - 16179.775280898875) / (2696.62921348) * 3.1415926535) * (PlayWindow.stage[1] * -2 / 10)
					+ PlayWindow.stage[1] / 2
						- 180;
			}
			else if (Conductor.songPosition >= 25617.977528089887 && Conductor.songPosition < 26629.213483146068)
			{
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				Main.base.x = PlayWindow.stage[0] * 3 / 10 - 320;
				Main.base.y = PlayWindow.stage[1] / 2 - 180;
			}
			else if (Conductor.songPosition >= 26629.213483146068 && Conductor.songPosition < 26882.02247191011)
			{
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				Main.base.x = PlayWindow.stage[0] * 3 / 10 - 320;
				Main.base.y = (PlayWindow.stage[1] / -4)
					- 180
					+ (26882.02247191011 - Conductor.songPosition) / (252.808988764) * (PlayWindow.stage[1] / 2 + PlayWindow.stage[1] / 4);
			}
			else if (Conductor.songPosition >= 26966.29213483146 && Conductor.songPosition < 37673.49636483807)
			{
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				if (Conductor.songPosition < 27303.370786516854)
				{
					Main.base.x = PlayWindow.stage[0] - (Conductor.songPosition - 26966.29213483146) / 337.078651685 * 320;
					Main.base.y = PlayWindow.stage[1] / 2 - 180;
				}
				else if (Conductor.songPosition < 32022.47191011236)
				{
					Main.base.x = PlayWindow.stage[0] - 320 - (Conductor.songPosition - 27303.370786516854) / 4719.1011236 * 160;
					Main.base.y = PlayWindow.stage[1] / 2 - 180;
				}
				else if (Conductor.songPosition < 32359.55056179775)
				{
					Main.base.x = PlayWindow.stage[0]
						- 480
						- (Conductor.songPosition - 32022.47191011236) / 337.078651685 * (PlayWindow.stage[0] - 320);
					Main.base.y = PlayWindow.stage[1] / 2 - 180;
				}
				else
					Main.base.x = -160 - (Conductor.songPosition - 33707.86516853933) / 4719.1011236 * (160);
				Main.base.y = PlayWindow.stage[1] / 2 - 180;
			}
			else if (Conductor.songPosition >= 37752.808988764045 && Conductor.songPosition < 48117.9775281)
			{
				if ((Conductor.songPosition - 37752.808988764045) / 674.15730337 >= count)
				{
					PlayWindow.pos = [
						FlxG.random.int(480, PlayWindow.stage[0] - 480),
						FlxG.random.int(270, PlayWindow.stage[1] - 270)
					];
					count += 1;
				}
				if (((Conductor.songPosition - 37752.808988764045) / 337.078651685) % 2 == 0)
				{
					Main.base.width = 960;
					Main.base.height = 540;
				}
				else
				{
					Main.base.width = 960 - ((Conductor.songPosition - 37752.808988764045) % 337.078651685) / 337.078651685 * 640;
					Main.base.height = 540 - ((Conductor.songPosition - 37752.808988764045) % 337.078651685) / 337.078651685 * 360;
				}
				Main.base.x = PlayWindow.pos[0] - Main.base.width / 2;
				Main.base.y = PlayWindow.pos[1] - Main.base.height / 2;
			}
			else if (Conductor.songPosition >= 48117.9775281 && Conductor.songPosition < 48455.05617977528)
			{
				Main.base.width = 960;
				Main.base.height = 540;
				if (FlxG.save.data.downscroll)
				{
					Main.base.x = PlayWindow.pos[0] - 480;
					Main.base.y = PlayWindow.pos[1]
						+ (Conductor.songPosition - 48117.9775281) / 337.078651685 * (PlayWindow.stage[1] * (-0.3) - PlayWindow.pos[1])
						- 270;
				}
				else
				{
					Main.base.x = PlayWindow.pos[0] - 480;
					Main.base.y = PlayWindow.pos[1]
						+ (Conductor.songPosition - 48117.9775281) / 337.078651685 * (PlayWindow.stage[1] * 1.3 - PlayWindow.pos[1])
						- 270;
				}
			}
			else if (Conductor.songPosition >= 48539.32584269663 && Conductor.songPosition < 70112.3595505)
			{
				count = 0;
				FlxG.scaleMode = new FixedScaleMode();
				if (Main.base.width != 480 || Main.base.height != 640)
				{
					Main.base.width = 480;
					Main.base.height = 640;
				}
				PlayWindow.camz = 0.9;
				if (Conductor.songPosition < 48707.86516853933)
				{
					if (FlxG.save.data.downscroll)
					{
						Main.base.x = PlayWindow.stage[0] * 0.3 - 240;
						Main.base.y = PlayWindow.stage[1] * (1.3)
							- ((Conductor.songPosition - 48539.32584269663) / 168.539325843) * (PlayWindow.stage[1] * 0.8)
							- 320;
					}
					else
					{
						Main.base.x = PlayWindow.stage[0] * 0.3 - 240;
						Main.base.y = PlayWindow.stage[1] * (-0.3)
							+ ((Conductor.songPosition - 48539.32584269663) / 168.539325843) * (PlayWindow.stage[1] * 0.8)
							- 320;
					}
					camHUD.x = 320;
				}
				else if (Conductor.songPosition < 58988.76404494382)
				{
					if (FlxG.save.data.downscroll)
					{
						Main.base.x = PlayWindow.stage[0] * 0.3 - 240;
						Main.base.y = PlayWindow.stage[1] * (0.5)
							- ((Conductor.songPosition - 48707.86516853933) / 10280.8988764) * 144
							- 320;
					}
					else
					{
						Main.base.x = PlayWindow.stage[0] * 0.3 - 240;
						Main.base.y = PlayWindow.stage[1] * (0.5)
							+ ((Conductor.songPosition - 48707.86516853933) / 10280.8988764) * 144
							- 320;
					}
					camHUD.x = 320;
				}
				else if (Conductor.songPosition < 59325.84269662921)
				{
					if (FlxG.save.data.downscroll)
					{
						Main.base.x = PlayWindow.stage[0] * 0.3 - 240;
						Main.base.y = PlayWindow.stage[1] * (0.5)
							- 144
							- ((Conductor.songPosition - 58988.76404494382) / 337.078651685) * (PlayWindow.stage[1] * 0.8 - 144)
							- 320;
					}
					else
					{
						Main.base.x = PlayWindow.stage[0] * 0.3 - 240;
						Main.base.y = PlayWindow.stage[1] * (0.5)
							+ 144
							+ ((Conductor.songPosition - 58988.76404494382) / 337.078651685) * (PlayWindow.stage[1] * 0.8 - 144)
							- 320;
					}
					camHUD.x = 320;
				}
				else if (Conductor.songPosition < 59494.38202247191)
				{
					if (FlxG.save.data.downscroll)
					{
						Main.base.x = PlayWindow.stage[0] * 0.7 - 240;
						Main.base.y = PlayWindow.stage[1] * (1.3)
							- ((Conductor.songPosition - 59325.84269662921) / 168.539325843) * (PlayWindow.stage[1] * 0.8)
							- 320;
					}
					else
					{
						Main.base.x = PlayWindow.stage[0] * 0.7 - 240;
						Main.base.y = PlayWindow.stage[1] * (-0.3)
							+ ((Conductor.songPosition - 59325.84269662921) / 168.539325843) * (PlayWindow.stage[1] * 0.8)
							- 320;
					}
					camHUD.x = -260;
				}
				else if (Conductor.songPosition < 69775.28089887642)
				{
					if (FlxG.save.data.downscroll)
					{
						Main.base.x = PlayWindow.stage[0] * 0.7 - 240;
						Main.base.y = PlayWindow.stage[1] * (0.5)
							- ((Conductor.songPosition - 59494.38202247191) / 10280.8988764) * 144
							- 320;
					}
					else
					{
						Main.base.x = PlayWindow.stage[0] * 0.7 - 240;
						Main.base.y = PlayWindow.stage[1] * (0.5)
							+ ((Conductor.songPosition - 59494.38202247191) / 10280.8988764) * 144
							- 320;
					}
					camHUD.x = -260;
				}
				else if (Conductor.songPosition < 70112.3595505)
				{
					if (FlxG.save.data.downscroll)
					{
						Main.base.x = PlayWindow.stage[0] * 0.7 - 240;
						Main.base.y = PlayWindow.stage[1] * (0.5)
							- 144
							- ((Conductor.songPosition - 69775.28089887642) / 337.078651685) * (PlayWindow.stage[1] * 0.8 - 144)
							- 320;
					}
					else
					{
						Main.base.x = PlayWindow.stage[0] * 0.7 - 240;
						Main.base.y = PlayWindow.stage[1] * (0.5)
							+ 144
							+ ((Conductor.songPosition - 69775.28089887642) / 337.078651685) * (PlayWindow.stage[1] * 0.8 - 144)
							- 320;
					}
					camHUD.x = -260;
				}
			}
			else if (Conductor.songPosition >= 70112.35955056181 && Conductor.songPosition < 70280.8988764045)
			{
				camHUD.x = 0;
				PlayWindow.camz = 1;
				FlxG.scaleMode = new RatioScaleMode();
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				Main.base.x = PlayWindow.stage[0] / 2 - 320;
				Main.base.y = PlayWindow.stage[1]
					- (Conductor.songPosition - 70112.35955056181) / 168.539325843 * (PlayWindow.stage[1] / 2 + 55);
			}
			else if (Conductor.songPosition >= 70280.8988764045 && Conductor.songPosition < 91595.50561797764)
			{
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				if (Conductor.songPosition >= 80898.87640449445)
				{
					Main.base.x = PlayWindow.stage[0] / 2
						+ FlxMath.fastSin(((Conductor.songPosition - 80898.87640449445) / 1348.31460674) * 3.1415926535) * PlayWindow.stage[0] / 5 - 320;
					Main.base.y = PlayWindow.stage[1] / 2
						+ FlxMath.fastSin(((Conductor.songPosition - 70280.8988764045) / 1348.31460674 - 0.5) * 3.1415926535) * 125
						- 180;
				}
				else
				{
					Main.base.x = PlayWindow.stage[0] / 2 - 320;
					Main.base.y = PlayWindow.stage[1] / 2
						+ FlxMath.fastSin(((Conductor.songPosition - 70280.8988764045) / 1348.31460674 - 0.5) * 3.1415926535) * 125
						- 180;
				}
			}
			else if (Conductor.songPosition >= 91685.3932584271 && Conductor.songPosition < 102471.91011235974)
			{
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				if (Conductor.songPosition % 40 < 20)
				{
					Main.base.x = FlxMath.fastSin(((Conductor.songPosition - 16179.775280898875) / (2696.62921348)
						+ 1) * 3.1415926535) * (PlayWindow.stage[0] * 2 / 10)
						+ PlayWindow.stage[0] / 2
							- 320;
					Main.base.y = FlxMath.fastCos(((Conductor.songPosition - 16179.775280898875) / (2696.62921348)
						+ 1) * 3.1415926535) * (PlayWindow.stage[1] * -2 / 10)
						+ PlayWindow.stage[1] / 2
							- 180;
				}
				else
				{
					Main.base.x = FlxMath.fastSin((Conductor.songPosition - 16179.775280898875) / (2696.62921348) * 3.1415926535) * (PlayWindow.stage[0] * 2 / 10)
						+ PlayWindow.stage[0] / 2
							- 320;
					Main.base.y = FlxMath.fastCos((Conductor.songPosition - 16179.775280898875) / (2696.62921348) * 3.1415926535) * (PlayWindow.stage[1] * -2 / 10)
						+ PlayWindow.stage[1] / 2
							- 180;
				}
			}
			else if (Conductor.songPosition >= 102471.91011235974 && Conductor.songPosition < 113258.42696629238)
			{
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				if ((Conductor.songPosition - 102471.91011235974) % 674.157303371 < 337.078651685)
				{
					Main.base.x = PlayWindow.stage[0] * 4 / 10
						+ (((Conductor.songPosition - 102471.91011235974) % 337.078651685) / 337.078651685) * PlayWindow.stage[0] / 5 - 320;
					Main.base.y = PlayWindow.stage[1] / 2
						- Math.abs(FlxMath.fastSin(((Conductor.songPosition - 102471.91011235974) % 337.078651685) / 337.078651685 * 3.1415926)) * PlayWindow.stage[1] / 10 - 180;
				}
				else
				{
					Main.base.x = PlayWindow.stage[0] * 6 / 10
						- (((Conductor.songPosition - 102471.91011235974) % 337.078651685) / 337.078651685) * PlayWindow.stage[0] / 5 - 320;
					Main.base.y = PlayWindow.stage[1] / 2
						- Math.abs(FlxMath.fastSin(((Conductor.songPosition - 102471.91011235974) % 337.078651685) / 337.078651685 * 3.1415926)) * PlayWindow.stage[1] / 10 - 180;
				}
			}
			else if (Conductor.songPosition >= 113258.42696629238 && Conductor.songPosition < 123707.86516853962)
			{
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				if ((Conductor.songPosition - 102471.91011235974) % 674.157303371 < 337.078651685)
				{
					Main.base.x = PlayWindow.stage[0] / 2 - 640;
					Main.base.y = PlayWindow.stage[1] / 2 - 180;
				}
				else
				{
					Main.base.x = PlayWindow.stage[0] / 2;
					Main.base.y = PlayWindow.stage[1] / 2 - 180;
				}
			}
			else if (Conductor.songPosition >= 123707.86516853962 && Conductor.songPosition < 156235.95505617998)
			{
				count = 0;
				FlxG.scaleMode = new FixedScaleMode();
				if (Conductor.songPosition < 145617.97752809015)
					PlayWindow.camz = 0.9;
				if (Conductor.songPosition < 124044.94382022502)
				{
					Main.base.width = 480;
					Main.base.height = 1;
					Main.base.x = PlayWindow.stage[0] * 0.3 - 240;
					Main.base.y = PlayWindow.stage[1] / 2 - 320;
					camHUD.x = 320;
				}
				else if (Conductor.songPosition < 124213.48314606771)
				{
					Main.base.width = 480;
					Main.base.height = (Conductor.songPosition - 124044.94382022502) / 168.539325843 * 640;
					Main.base.x = PlayWindow.stage[0] * 0.3 - 240;
					Main.base.y = PlayWindow.stage[1] / 2 - 320;
					camHUD.x = 320;
				}
				else if (Conductor.songPosition < 134494.38202247224)
				{
					Main.base.width = 480;
					Main.base.height = 640 + (Conductor.songPosition - 124213.48314606771) / 10280.8988764 * 80;
					Main.base.x = PlayWindow.stage[0] * 0.3 - 240;
					Main.base.y = PlayWindow.stage[1] / 2 - 320;
					camHUD.x = 320;
				}
				else if (Conductor.songPosition < 134662.92134831494)
				{
					Main.base.width = 480;
					Main.base.height = 720 - (Conductor.songPosition - 134494.38202247224) / 168.539325843 * 719;
					Main.base.x = (PlayWindow.stage[0] * 0.3
						+ (Conductor.songPosition - 134494.38202247224) / 168.539325843 * (PlayWindow.stage[0] * 0.4))
						- 240;
					Main.base.y = PlayWindow.stage[1] / 2 - 320;
					camHUD.x = 320;
				}
				else if (Conductor.songPosition < 134831.46067415763)
				{
					Main.base.width = 480;
					Main.base.height = 1;
					Main.base.x = (PlayWindow.stage[0] * 0.7) - 240;
					Main.base.x = PlayWindow.stage[1] / 2 - 320;
					camHUD.x = 320;
				}
				else if (Conductor.songPosition < 135000.00000000032)
				{
					Main.base.width = 480;
					Main.base.height = (Conductor.songPosition - 134831.46067415763) / 168.539325843 * 640;
					Main.base.x = (PlayWindow.stage[0] * 0.7) - 240;
					Main.base.y = PlayWindow.stage[1] / 2 - 320;
					camHUD.x = -260;
				}
				else if (Conductor.songPosition < 145280.89887640477)
				{
					Main.base.width = 480;
					Main.base.height = 640 + (Conductor.songPosition - 135000.00000000032) / 10280.8988764 * 80;
					Main.base.x = (PlayWindow.stage[0] * 0.7) - 240;
					Main.base.y = PlayWindow.stage[1] / 2 - 320;
					camHUD.x = -260;
				}
				else if (Conductor.songPosition < 145449.43820224746)
				{
					Main.base.width = 480 + (Conductor.songPosition - 145280.89887640477) / 168.539325843 * 160;
					Main.base.height = 720 - (Conductor.songPosition - 145280.89887640477) / 168.539325843 * 719;
					Main.base.x = PlayWindow.stage[0] * 0.7
						- 240
						- (Conductor.songPosition - 145280.89887640477) / 168.539325843 * (PlayWindow.stage[0] * 0.2 + 80);
					Main.base.y = PlayWindow.stage[1] / 2 - 320 + (Conductor.songPosition - 145280.89887640477) / 168.539325843 * 140;
					camHUD.x = -260;
				}
				else if (Conductor.songPosition < 145617.97752809015)
				{
					Main.base.width = 640;
					Main.base.height = 1;
					Main.base.x = (PlayWindow.stage[0] / 2) - 320;
					Main.base.y = PlayWindow.stage[1] / 2 - 180;
					camHUD.x = -260;
				}
				else if (Conductor.songPosition < 145786.51685393284)
				{
					Main.base.width = 640;
					Main.base.height = (Conductor.songPosition - 145617.97752809015) / 168.539325843 * 320;
					Main.base.x = (PlayWindow.stage[0] / 2) - 320;
					Main.base.y = PlayWindow.stage[1] / 2 - 180;
					camHUD.x = 0;
					PlayWindow.camz = 0.45;
					PlayState.defaultCamZoom = 0.425;
				}
				else if (Conductor.songPosition < 156067.4157303373)
				{
					Main.base.width = 640;
					Main.base.height = 320 + (Conductor.songPosition - 145786.51685393284) / 10280.8988764 * 40;
					Main.base.x = (PlayWindow.stage[0] / 2) - 320;
					Main.base.y = PlayWindow.stage[1] / 2 - 180;
					camHUD.x = 0;
					PlayWindow.camz = 0.5;
					PlayState.defaultCamZoom = 0.425;
				}
				else
				{
					if (Main.base.width != 640 || Main.base.height != 360)
					{
						Main.base.width = 640;
						Main.base.height = 360;
					}
					Main.base.x = PlayWindow.stage[0] / 2 - 320;
					Main.base.y = (PlayWindow.stage[1] / 2
						- (Conductor.songPosition - 156067.4157303373) / 168.539325843 * PlayWindow.stage[1] / 5)
						- 180;
					camHUD.x = 0;
					PlayWindow.camz = 0.5;
					PlayState.defaultCamZoom = 0.425;
				}
			}
			else if (Conductor.songPosition >= 156404.49438202268 && Conductor.songPosition < 167106.74157303385)
			{
				PlayWindow.camz = 1;
				PlayState.defaultCamZoom = 0.85;
				FlxG.scaleMode = new RatioScaleMode();
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				Main.base.x = FlxMath.fastSin((Conductor.songPosition - 156404.49438202268) / (2696.62921348) * 3.1415926535) * (PlayWindow.stage[0] * 2 / 10)
					+ PlayWindow.stage[0] / 2
						- 320;
				Main.base.y = FlxMath.fastCos((Conductor.songPosition - 156404.49438202268) / (2696.62921348) * 3.1415926535) * (PlayWindow.stage[1] * -2 / 10)
					+ PlayWindow.stage[1] / 2
						- 180;
			}
			else if (Conductor.songPosition >= 167191.0112359552 && Conductor.songPosition < 172584.26966292146)
			{
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				switch (Std.int((Conductor.songPosition - 167191.0112359552) / 337.078651685) % 4)
				{
					case 0:
						if (Conductor.songPosition % 40 < 20)
						{
							Main.base.x = PlayWindow.stage[0] / 2 - 480;
							Main.base.y = PlayWindow.stage[1] / 2 - 360;
						}
						else
						{
							Main.base.x = PlayWindow.stage[0] / 2 - 160;
							Main.base.y = PlayWindow.stage[1] / 2;
						}
					case 1:
						if (Conductor.songPosition % 40 < 20)
						{
							Main.base.x = PlayWindow.stage[0] / 2
								- 480
								+ 320 * ((Conductor.songPosition - 167191.0112359552) % 337.078651685) / 337.078651685;
							Main.base.y = PlayWindow.stage[1] / 2 - 360;
						}
						else
						{
							Main.base.x = PlayWindow.stage[0] / 2
								- 160
								- 320 * ((Conductor.songPosition - 167191.0112359552) % 337.078651685) / 337.078651685;
							Main.base.y = PlayWindow.stage[1] / 2;
						}
					case 2:
						if (Conductor.songPosition % 40 < 20)
						{
							Main.base.x = PlayWindow.stage[0] / 2 - 160;
							Main.base.y = PlayWindow.stage[1] / 2 - 360;
						}
						else
						{
							Main.base.x = PlayWindow.stage[0] / 2 - 480;
							Main.base.y = PlayWindow.stage[1] / 2;
						}
					case 3:
						if (Conductor.songPosition % 40 < 20)
						{
							Main.base.x = PlayWindow.stage[0] / 2 - 160;
							Main.base.y = PlayWindow.stage[1] / 2
								- 360
								+ 360 * ((Conductor.songPosition - 167191.0112359552) % 337.078651685) / 337.078651685;
						}
						else
						{
							Main.base.x = PlayWindow.stage[0] / 2 - 480;
							Main.base.y = PlayWindow.stage[1] / 2
								- 360 * ((Conductor.songPosition - 167191.0112359552) % 337.078651685) / 337.078651685;
						}
				}
			}
			else if (Conductor.songPosition >= 172584.26966292146 && Conductor.songPosition < 177977.52808988772)
			{
				if (Main.base.width != 640 || Main.base.height != 360)
				{
					Main.base.width = 640;
					Main.base.height = 360;
				}
				if (Conductor.songPosition % 1348.31460674 < 674.15730337)
				{
					if (Conductor.songPosition % 40 < 20)
					{
						Main.base.x = PlayWindow.stage[0] / 2
							+ 320 * FlxMath.fastSin((Conductor.songPosition % 674.15730337) / 674.15730337 * 3.1415926535)
							- 320;
						Main.base.y = PlayWindow.stage[1] / 2 - 180;
					}
					else
					{
						Main.base.x = PlayWindow.stage[0] / 2
							- 320 * FlxMath.fastSin((Conductor.songPosition % 674.15730337) / 674.15730337 * 3.1415926535)
							- 320;
						Main.base.y = PlayWindow.stage[1] / 2 - 180;
					}
				}
				else
				{
					if (Conductor.songPosition % 40 < 20)
					{
						Main.base.x = PlayWindow.stage[0] / 2 - 320);
						Main.base.y = PlayWindow.stage[1] / 2
							+ 180 * FlxMath.fastSin((Conductor.songPosition % 674.15730337) / 674.15730337 * 3.1415926535)
							- 180;
					}
					else
					{
						Main.base.x = PlayWindow.stage[0] / 2 - 320;
						Main.base.y = PlayWindow.stage[1] / 2
							- 180 * FlxMath.fastSin((Conductor.songPosition % 674.15730337) / 674.15730337 * 3.1415926535)
							- 180;
					}
				}
			}
		}
	}
}

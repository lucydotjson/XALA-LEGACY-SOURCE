package;

import editors.WeekEditorState.WeekEditorFreeplayState;
#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import lime.app.Application;
import Achievements;
import flixel.input.keyboard.FlxKey;
import editors.MasterEditorMenu;
import ClientPrefs;
import openfl.filters.ShaderFilter;


using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var psychEngineVersion:String = 'LEGACY BUILD HOTFIX'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;
	public var shaderFilter:Array<ShaderFilter> = [];


	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	public static var firstStart:Bool = true;
	public static var finishedFunnyMove:Bool = false;

	public var playbutton:FlxSprite;
	public var options:FlxSprite;

	public var crt:TVShader;
	public var penis:PenisShader;
	var caShader:ChromaticAbberation;
    public var VignetteShade:VignetteEffect = null;


	var magenta:FlxSprite;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var soreal:FlxSprite;
	var debugKeys:Array<FlxKey>;
	var sex:FlxSprite;
	var bg:FlxSprite;
	override function create()
	{
		super.create();


		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("the void", null);
		#end

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic(Paths.music('xalaMenu'));
		}


		persistentUpdate = persistentDraw = true;

		FlxG.mouse.visible = true;


		bg = new FlxSprite(Paths.image('static'));
		bg.scrollFactor.set();
		bg.setGraphicSize(Std.int(bg.width * 1.8));
		add(bg);

		sex = new FlxSprite(Paths.image('ringthing'));
		sex.scrollFactor.set();
		sex.setGraphicSize(Std.int(sex.width * 0.8));
		sex.updateHitbox();
		sex.screenCenter();
	    add(sex);
		FlxTween.tween(sex, { y: 40}, 2.5, {ease: FlxEase.circInOut, type: PINGPONG});



		playbutton = new FlxSprite(Paths.image('menuButtons/gayshitimeantplay'));
        playbutton.frames = Paths.getSparrowAtlas('menuButtons/gayshitimeantplay');
        playbutton.animation.addByPrefix('default', 'playButton');
        playbutton.animation.addByPrefix('selected', 'playButtonSelect');
        playbutton.x += 0;
        playbutton.y += 0;
		playbutton.setGraphicSize(Std.int(playbutton.width * 1.3));

		options = new FlxSprite(Paths.image('menuButtons/options'));
        options.frames = Paths.getSparrowAtlas('menuButtons/options');
        options.animation.addByPrefix('default', 'optionsButton');
        options.animation.addByPrefix('selected', 'optionsSelect');
        options.x += 850;
        options.y += 0;
		options.setGraphicSize(Std.int(options.width * 1.3));
	


		FlxTween.tween(playbutton, { y: 500}, 1.1, {ease: FlxEase.circInOut});
		FlxTween.tween(options, { y: 500}, 1.1, {ease: FlxEase.circInOut});
		
	
		firstStart = false;
		
		playbutton.updateHitbox();
		options.updateHitbox();

        add(playbutton);
     	add(options);

		
		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "VS XALAMUS " + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		
		if(ClientPrefs.menuShader)
		{

			VignetteShade = new VignetteEffect();
			shaderFilter.push(new ShaderFilter(VignetteShade.shader));

			caShader = new ChromaticAbberation(0);
			add(caShader);
			caShader.amount = -0.5;
			var filter2:ShaderFilter = new ShaderFilter(caShader.shader);

		crt = new TVShader();
		FlxG.camera.setFilters([new ShaderFilter(crt),new ShaderFilter(VignetteShade.shader),new ShaderFilter(filter2.shader)]);
		}

	}

	var selectedSomethin:Bool = false;

	var canClick:Bool = true;
	var usingMouse:Bool = false;

	var timerThing:Float = 0;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}
	
		if (FlxG.mouse.justPressed) {
            if (FlxG.mouse.overlaps(options)) {
                options.animation.play('selected');
                FlxFlicker.flicker(options, .5, 0.06, false, false);
                FlxG.switchState(new options.OptionsState());
            }
            else if (FlxG.mouse.overlaps(playbutton)) {
                playbutton.animation.play('selected');
                FlxFlicker.flicker(playbutton, .5, 0.06, false, false);
                FlxG.switchState(new FreeplayState());
			  }
			  else if (FlxG.mouse.overlaps(sex)) {
                FlxFlicker.flicker(sex, .5, 0.06, false, false);
                FlxG.switchState(new CreditsState());
			  }

			}


			  if (controls.BACK)
				{
					FlxG.switchState(new TitleState());
				}
				
				
				if(ClientPrefs.menuShader)
                       {
				crt.update(elapsed);
					   }


       super.update(elapsed);


}

}



	
	
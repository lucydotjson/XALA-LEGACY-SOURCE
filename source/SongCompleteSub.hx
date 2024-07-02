package;

import openfl.geom.Matrix;
import openfl.display.BitmapData;
import flixel.system.FlxSound;
import flixel.util.FlxAxes;
import flixel.FlxSubState;
import flixel.input.FlxInput;
import flixel.input.keyboard.FlxKey;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.input.FlxKeyManager;
import flixel.ui.FlxBar;
import flixel.addons.display.FlxBackdrop;
import flixel.addons.display.FlxGridOverlay;
import openfl.filters.ShaderFilter;
import flixel.util.FlxTimer;



class SongCompleteSub extends MusicBeatState
{

    var bg:FlxSprite;
	var bars:FlxSprite;
    var text:FlxText;
    var ring:FlxSprite;
    var comboText:FlxText;
    var scoreimage:FlxSprite;
    private var songbarbg:FlxSprite;
    private var sonc:FlxSprite;
    var lerpScore:Int = 0;
    private var songbar:FlxBar;
    var textTween:FlxTween;

    public static var textoptions:Array<Dynamic> = [
		['F-', 0.2], //From 0% to 19%
		['F', 0.4], //From 20% to 39%
		['F+', 0.5], //From 40% to 49%
		['E', 0.6], //From 50% to 59%s
		['D', 0.69], //From 60% to 68%
		['C', 0.7], //69%
		['B', 0.8], //From 70% to 79%
		['A', 0.9], //From 80% to 89%
		['S', 1], //From 90% to 99%
		['S+', 1] //The value on this one isn't used actually, since Perfect is always "1"
	];



    public var VignetteShade:VignetteEffect = null;


    var scoere:Float = 0;
    var scorelength:Float = 0;
    

	public var shaderFilter:Array<ShaderFilter> = [];

    public static var firstStart:Bool = true;
	public static var finishedFunnyMove:Bool = false;

    var pulseColor:FlxColor;

    var char:FlxSprite; 
    

    override function create()
    {

        scorelength = (PlayState.instance.ratingPercent);

        FlxG.sound.playMusic(Paths.music('youwin'));


        var white:FlxSprite = new FlxSprite(-100, -100).makeGraphic(FlxG.width * 2, FlxG.height * 2, 0xffffffff);
		white.scrollFactor.set();
        add(white);

        
         if (PlayState.SONG.song == 'devils-island')
            {
                    trace('yeze');   
                    char = new FlxSprite().loadGraphic(Paths.image('scorescreen/xala'));        
    
            }
         else if (PlayState.SONG.song == 'silent-panic')
        {
                trace('itwork');   
        		char = new FlxSprite().loadGraphic(Paths.image('scorescreen/panic'));        

        }
        else if (PlayState.SONG.song == 'superstition')
            {
                    trace('yipe');   
                    char = new FlxSprite().loadGraphic(Paths.image('scorescreen/sirballs'));        
    
            }

        add(char);


        text = new FlxText(20, 20, 0, "you win!");
		text.size = 100;
		text.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.RED, 4, 1);
        text.color = FlxColor.BLACK;
		text.scrollFactor.set();
        text.x += 650;
        text.y += 0;


		ring = new FlxSprite().loadGraphic(Paths.image('scorescreen/ring'));
   ring.x += 1020;
		ring.y += 250;


        
        scoreimage = new FlxSprite().loadGraphic(Paths.image('scorescreen/score'));
        scoreimage.x += 0;
        scoreimage.y += 100;
        
	    songbarbg = new FlxSprite().loadGraphic(Paths.image('scorescreen/progressbar'));
		songbarbg.scrollFactor.set(0, 0);
	    songbarbg.x += 0;
		songbarbg.y += 500;


        sonc = new FlxSprite().loadGraphic(Paths.image('scorescreen/senc'));
		sonc.scrollFactor.set(0, 0);
		sonc.x += 0;
	     sonc.y += 425;



		songbar = new FlxBar(songbarbg.x, songbarbg.y, LEFT_TO_RIGHT, Std.int(songbarbg.width - 25),Std.int(songbarbg.height - 25), this,
		'scoere', 0, 1);
     songbar.createFilledBar(0xFF000000, 0xFFFF7300);

        
			VignetteShade = new VignetteEffect();
			shaderFilter.push(new ShaderFilter(VignetteShade.shader));

        
		var score = PlayState.instance.songScore;
		if (PlayState.isStoryMode)
		{
			score = PlayState.campaignScore;
		}

        comboText = new FlxText( 'score: 0' );
		comboText.size = 90;
		comboText.setBorderStyle(FlxTextBorderStyle.OUTLINE, FlxColor.BLACK, 4, 1);
		comboText.color = FlxColor.WHITE;
		comboText.scrollFactor.set();
        comboText.y = 600;
        comboText.x += text.x -200;


        new FlxTimer().start(1.45, function(tmr:FlxTimer)
            {
               counttext();

            });



    
        add(scoreimage);
        add(comboText);
        add(songbar);
       add(songbarbg);
       add(sonc);
        add(text);
       add(ring);


        firstStart = false;



        super.create();

    }

    override function update(elapsed:Float)
    {
        scoere = (scorelength);
		FlxTween.tween(songbar, {alpha: 1}, 0.5, {ease: FlxEase.circOut});

        FlxG.camera.setFilters([new ShaderFilter(VignetteShade.shader)]);


        if(FlxG.keys.pressed.ENTER)
        {
                FlxG.switchState(new FreeplayState());
                FlxG.sound.playMusic(Paths.music('freakyMenu'));

         }

         super.update(elapsed);

    }

    private function counttext() 
     {
        FlxG.camera.shake(0.005, 0.35);
        pulseColor = 0xFFFF4444;
        FlxG.sound.play(Paths.sound('confirmMenu'), 0.5);

        comboText.text =  'score: ${PlayState.instance.songScore}';

        textTween = FlxTween.color(comboText, 0.5, pulseColor, 0xFFFFFFFF, { ease: FlxEase.sineOut });
        
    }




}

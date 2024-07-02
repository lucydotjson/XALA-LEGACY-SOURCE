function onStartCountdown()
	setProperty('camHUD.alpha', 0.0001);
end

function onCreate() 
	makeLuaSprite('black', nil, -650, -350);
	makeGraphic('black', 2000, 2000, '#000000');
	setScrollFactor('black', 0, 0);
	scaleObject('black', 2.2, 2.2);
	setObjectCamera('black', 'other');
	addLuaSprite('black', false);

	makeLuaSprite('blackBehind', nil, -650, -350);
	makeGraphic('blackBehind', 2000, 2000, '#000000');
	setScrollFactor('blackBehind', 0, 0);
	scaleObject('blackBehind', 2.2, 2.2);
	setObjectCamera('blackBehind', 'other');
	addLuaSprite('blackBehind', false);
end

function onStepHit()	 
	if curStep == 1 then
		setProperty('cameraSpeed', 111)		
		setProperty('black.alpha', 0.0001)
	elseif curStep == 68 then
		doTweenZoom('tweenScreen', 'camGame', 0.7, 8, 'QuadInOut');
	elseif curStep == 112 then
		doTweenAlpha('tweencamHUD', 'camHUD', 1, 1, 'QuadInOut');
	elseif curStep == 128 then
		cameraFlash('other', 'FFFFFF', 1, 'linear')
	elseif curStep == 256 then
		setProperty('defaultCamZoom', 0.7);
	elseif curStep == 320 then
		setProperty('defaultCamZoom', 0.75);
	elseif curStep == 336 then
		setProperty('defaultCamZoom', 0.8);
	elseif curStep == 352 then
		setProperty('defaultCamZoom', 0.7);
	elseif curStep == 448 then
		setProperty('defaultCamZoom', 0.7);
	elseif curStep == 464 then
		setProperty('defaultCamZoom', 0.8);
	elseif curStep == 476 then
		setProperty('defaultCamZoom', 0.85);
	elseif curStep == 480 then
		setProperty('defaultCamZoom', 0.7);
	elseif curStep == 504 then
		doTweenAlpha('tween1', 'black', 1, 0.65, 'QuadInOut');
	elseif curStep == 512 then
		cameraFlash('other', 'FFFFFF', 1, 'linear')
		setProperty('defaultCamZoom', 0.7);
		doTweenAlpha('tween2', 'black', 0, 0.0000001, 'QuadInOut');
	elseif curStep == 544 then
		setProperty('defaultCamZoom', 0.8);
	elseif curStep == 552 then
		setProperty('defaultCamZoom', 0.85);
	elseif curStep == 556 then
		setProperty('defaultCamZoom', 0.9);
	elseif curStep == 560 then
		setProperty('defaultCamZoom', 0.85);
	elseif curStep == 568 then
		setProperty('defaultCamZoom', 0.8);
	elseif curStep == 576 then
		setProperty('defaultCamZoom', 0.9);
	elseif curStep == 592 then
		setProperty('defaultCamZoom', 0.98);
	elseif curStep == 604 then
		setProperty('defaultCamZoom', 0.85);
	elseif curStep == 608 then
		setProperty('defaultCamZoom', 0.7);
	elseif curStep == 614 then
		setObjectCamera('black', 'camHUD');
		doTweenAlpha('tween3', 'black', 1, 0.75, 'QuadInOut');
	elseif curStep == 640 then
		cameraFlash('other', 'FFFFFF', 0.7, 'linear')
		setProperty('defaultCamZoom', 0.7);
		setProperty('black.alpha', 0.0001);
	elseif curStep == 672 then
		setProperty('defaultCamZoom', 0.8);
	elseif curStep == 704 then
		setProperty('defaultCamZoom', 0.7);
	elseif curStep == 768 then
		setProperty('black.alpha', 1);
		setProperty('defaultCamZoom', 0.7);
		setProperty('cameraSpeed', 1.4)	
	elseif curStep == 824 then
		doTweenAlpha('tween4', 'blackBehind', 1, 0.6, 'QuadInOut');
	elseif curStep == 832 then
		cameraFlash('other', 'FF0000', 0.6, 'linear')
		setProperty('black.alpha', 0.0001);
		doTweenAlpha('tween5', 'blackBehind', 0.0001, 0.0001, 'QuadInOut');
	elseif curStep == 880 then
		setProperty('defaultCamZoom', 0.75);
	elseif curStep == 884 then
		setProperty('defaultCamZoom', 0.85);
	elseif curStep == 888 then
		setProperty('defaultCamZoom', 0.95);
	elseif curStep == 892 then
		setProperty('defaultCamZoom', 1.05);
	elseif curStep == 896 then
		setProperty('defaultCamZoom', 0.7);
	elseif curStep == 944 then
		setProperty('defaultCamZoom', 0.75);
	elseif curStep == 948 then
		setProperty('defaultCamZoom', 0.85);
	elseif curStep == 952 then
		setProperty('defaultCamZoom', 0.95);
	elseif curStep == 956 then
		setProperty('defaultCamZoom', 1.05);
	elseif curStep == 960 then
		setProperty('defaultCamZoom', 0.7);
	elseif curStep == 1304 then
		setProperty('black.alpha', 1);
		cameraShake('camHUD', 0.008, 0.1)
		cameraShake('game', 0.010, 0.1)
	elseif curStep == 1312 then
		cameraFlash('other', 'FF0000', 0.6, 'linear')
		setProperty('black.alpha', 0.0001);
	elseif curStep == 1856 then
		setProperty('black.alpha', 1);
	elseif curStep == 1984 then
		setProperty('blackBehind.alpha', 1);
	end
end

function onEvent(n, v1, v2)
	if n == 'black' then
		setProperty('black.alpha', 1);
		cameraShake('camHUD', 0.008, 0.1)
		cameraShake('game', 0.010, 0.1)
	end
	if n == 'flash' then
		setProperty('black.alpha', 0.0001);
	end
end

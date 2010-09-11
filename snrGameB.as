﻿﻿package
{
	import flash.events.*;
	import flash.display.*;
	import GameTheater.gtObjects.*;
	import GameTheater.gtObjects.gtBehaviors.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;

	public dynamic class snrGameB extends gtBehavior
	{
		public const SNR_GAME_B:String = "snrGameB";
		
		public var player;
		
		public function snrGameB()
		{
			m_name = "gob";
		}
		
		public override function Awake()
		{
			//gameObject.content = new BackGroundBase();
			var bg = gt.GO(snrBackgroundB);
			//psEasel.GetCanvas("background").addChild(bg);
			player = gt.GO(snrPlayerControlB);
			//gameObject.addChild(player);
			var zombie = gt.GO(snrZombieGrunt);
			zombie.gob.playerTarget = player;
		}
		
		public override function Start()
		{
			
		}
		
		public function Show()
		{
			
		}
	}
}
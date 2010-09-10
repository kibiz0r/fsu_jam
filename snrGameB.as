﻿package
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
			gameObject.content = new BackGroundBase();
		}
		
		public override function Start()
		{
			player = gt.GO(snrPlayerControlB);
			gameObject.addChild(player);
			trace("new");
		}
		
		public function Show()
		{
			
		}
	}
}
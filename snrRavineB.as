﻿package  {	import GameTheater.gtObjects.*;	import GameTheater.gtSystems.*;	import PinStriper.psObjects.*;	import PinStriper.psSystems.*;	import PinStriper.psTools.*;		public dynamic class snrRavineB extends gtBehavior	{		public var m_runsHorizontal:Boolean = false;		public var m_runsVertical:Boolean = false;				public function snrRavineB()		{			m_name = "gob";		}		public override function Awake()		{			gameObject.content = new Ravine();		}				public override function Start()		{					}	}	}
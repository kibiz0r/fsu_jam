// Actor.as 
package GameTheater.gtObjects.gtBehaviors
{
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import fl.motion.easing.*;
	import flash.events.*;
	import flash.utils.*;
	import flash.geom.*;
	import GameTheater.gtObjects.*;
	import GameTheater.gtObjects.gtBehaviors.*;
	import GameTheater.gtSystems.*;
	import GameTheater.gtSystems.gtSystemObjects.*;
	import GameTheater.gtTools.*;
	import PinStriper.psObjects.*;
	import PinStriper.psSystems.*;
	import PinStriper.psTools.*;

	public dynamic class gtTagB extends gtBehavior
	{
		public const GTTAG:String = "gtTagB";
		
		public static var m_objects:Object = new Object();
		public var m_tags:Object = new Array();
		
		
		public function gtTagB()
		{
			m_name = "tag";
			m_orderWeight = -0.6;
		}
		
		public function Tag(t:String)
		{
			if (m_objects[t] == null)
				m_objects[t] = new Object();
			
			m_objects[t][gameObject.name] = gameObject;
			
			if (m_tags.indexOf(t) == -1)
				m_tags.push(t)
		}
		
		public function ClearTags()
		{
			for (var i:int = 0; i < m_tags.length; i++)
			{
				delete(m_objects[m_tags[i]][gameObject.name]);// = undefined;
			}
		}
		
		public function GetObjects(t:String)
		{
			return m_objects[t];
		}
		
		public override function Awake()
		{
		}
		
		public override function Start()
		{
		}
		
		public override function Destructor()
		{
			ClearTags();
			super.Destructor();
		}
	}
}
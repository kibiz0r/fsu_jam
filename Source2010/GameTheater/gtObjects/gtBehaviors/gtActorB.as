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
	
	//import org.cove.ape.*;

	public dynamic class gtActorB extends gtBehavior
	{
		public const GTACTOR:String = "gtActor";
		
		public var m_lastParent = null;
		
		public function gtActorB()
		{
			m_name = "actor";
			m_orderWeight = -0.6;
		}
		
		public override function Awake()
		{
			states.Add("Attached",Attached,GTACTOR);
			states.Add("Unattached",Unattached,GTACTOR);
			states.Activate("Unattached");
		}
		
		public override function Start()
		{
		}
		
		public override function Destructor()
		{
			Detach();
			states.DeactivateZone(GTACTOR);
			m_lastParent = null;
			super.Destructor();
		}
		
		// States
		public function Attached(setting:int)
		{
			if (setting == gtState.INIT)
			{
				psEasel.that.addEventListener(psEvent.RESIZE,Resize);
			}
			else if (setting == gtState.EXIT)
			{
				psEasel.that.removeEventListener(psEvent.RESIZE,Resize);
			}
		}
		
		public function Unattached(setting:int)
		{
			if (setting == gtState.INIT)
			{
				gameObject.addEventListener(Event.ADDED_TO_STAGE,AttachedListener);
			}
			else if (setting == gtState.EXIT)
			{
				gameObject.removeEventListener(Event.ADDED_TO_STAGE,AttachedListener);
			}
		}
		
		// Listeners
		public function AttachedListener(e:Event)
		{
			SendMessage("AttachedListener",e);
			states.Activate("Attached");
		}
		
		public function Resize(e:psEvent)
		{
			SendMessage("Resize",e);
		}
		
		// Controls
		public function Attach(mc = null,under:Boolean = false)
		{
			if (mc == null)
			{
				if (m_lastParent == null)
					mc = psEasel.GetCanvas("main");
				else
					mc = m_lastParent;
			}
			if (under)
				mc.addChildAt(gameObject,0);
			else
				mc.addChild(gameObject);
		}
		
		public function Detach()
		{
			if (gameObject.parent)
			{
				m_lastParent = gameObject.parent;
				gameObject.parent.removeChild(gameObject);
			}
			states.Activate("Unattached");
		}
		
		
		public function Center()
		{
			CenterX();
			CenterY();
			return this;
		}
		
		public function CenterX()
		{
			gameObject.x = 0;
			return this;
		}
		
		public function CenterY()
		{
			gameObject.y = 0;
			return this;
		}
		
		public function Top()
		{
			gameObject.y = -(psEasel.that.m_baseResolution.y*0.5);
			return this;
		}
		
		public function Bottom()
		{
			gameObject.y = (psEasel.that.m_baseResolution.y*0.5);
			return this;
		}
		
		public function OnScreen():Boolean
		{
			var p = gameObject.localToGlobal(new Point(0,0));
			if ((p.x - gameObject.width/2) < 0 || (p.x + gameObject.width/2) > psEasel.that.stage.stageWidth)
				return false;
			if ((p.y - gameObject.height/2) < 0 || (p.y + gameObject.height/2) > psEasel.that.stage.stageHeight)
				return false;
			return true;
		}
	}
}